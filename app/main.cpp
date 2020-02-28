/*
    Copyright (C) 2019 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com
    Author: Volker Krause <volker.krause@kdab.com>

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#include <QDebug>
#include <QApplication>
#include <QGeoPositionInfoSource>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTimer>
#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

#include <gammaray/core/server.h>

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString serverAddress READ serverAddress NOTIFY serverAddressChanged)

public:
    explicit Controller(QObject *parent = nullptr);
    QString serverAddress() const;

    Q_INVOKABLE void enableGPS();

signals:
    void serverAddressChanged();

private:
    void setupGPS();
};

Controller::Controller(QObject *parent)
    : QObject(parent)
{
    // give the GammaRay probe time to initialize networking
    QTimer::singleShot(0, this, [this]() {
        const auto server = qobject_cast<GammaRay::Server*>(GammaRay::Endpoint::instance());
        QObject::connect(server, &GammaRay::Server::externalAddressChanged, this, &Controller::serverAddressChanged);
    });
}

QString Controller::serverAddress() const
{
    const auto server = qobject_cast<GammaRay::Server*>(GammaRay::Endpoint::instance());
    if (!server) {
        return {};
    }
    return server->externalAddress().toString();
}

void Controller::enableGPS()
{
#ifdef Q_OS_ANDROID
    if (QtAndroid::checkPermission("android.permission.ACCESS_FINE_LOCATION") == QtAndroid::PermissionResult::Granted) {
        setupGPS();
        return;
    }

    QtAndroid::requestPermissions({"android.permission.ACCESS_FINE_LOCATION"}, [this] (const QtAndroid::PermissionResultMap &result) {
        if (result["android.permission.ACCESS_FINE_LOCATION"] == QtAndroid::PermissionResult::Granted) {
            setupGPS();
        }
    });
#else
    setupGPS();
#endif
}

void Controller::setupGPS()
{
    auto source = QGeoPositionInfoSource::createDefaultSource(this);
    source->startUpdates();
}


Q_DECL_EXPORT int main(int argc, char **argv)
{
    QCoreApplication::setApplicationName(QStringLiteral("GammaRay Platform Probe"));
    QCoreApplication::setOrganizationName(QStringLiteral("KDAB"));
    QCoreApplication::setOrganizationDomain(QStringLiteral("kdab.com"));

    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    QApplication app(argc, argv); // QApplication, so we get the QStyle tool

    qmlRegisterSingletonType<Controller>("com.kdab.gammaray.PlatformProbe", 1, 0, "Controller", [](QQmlEngine*, QJSEngine*) -> QObject* {
        return new Controller;
    });

    QQmlApplicationEngine engine;
    engine.load(QStringLiteral("qrc:/main.qml"));

#ifdef Q_OS_ANDROID
    QtAndroid::hideSplashScreen();
#endif
    return app.exec();
}

#include "main.moc"
