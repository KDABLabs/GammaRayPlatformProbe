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

import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5 as QQC2

QQC2.ApplicationWindow
{
    visible: true

    header: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: headerLabel.implicitHeight + 20
        color: "#0077c8"

        QQC2.Label {
            id: headerLabel
            anchors.centerIn: parent
            text: qsTr("GammaRay Platform Probe")
            color: "white"
            font.pointSize: 24
        }
    }

    Image {
        source: "qrc:/watermark.png"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

    ColumnLayout {
        anchors.centerIn: parent

        QQC2.Label {
            text: qsTr("Address: ") + _serverAddress;
        }

        QQC2.Button {
            text: qsTr("Exit")
            onClicked: Qt.quit();
        }
    }
}
