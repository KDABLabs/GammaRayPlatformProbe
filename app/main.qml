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
import QtQuick.Controls 2.10
import QtQuick.Controls.Material 2.10

import com.kdab.gammaray.PlatformProbe 1.0

ApplicationWindow
{
    visible: true
    title: qsTr("GammaRay Platform Probe")
    width: 480
    height: 720

    Material.theme: Material.Light
    Material.accent: "#0077c8" // KDAB blue

    readonly property int __margin: 16

    header: Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        height: headerLabel.implicitHeight + 2 * __margin
        color: Material.accent

        Label {
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
        anchors.fill: parent
        anchors.margins: __margin

        Label {
            text: qsTr("Address: ") + Controller.serverAddress
        }

        Button {
            id: gpsButton
            Layout.fillWidth: true
            text: qsTr("Enable GPS")
            onClicked: {
                Controller.enableGPS();
                gpsButton.enabled = false;
            }
        }

        Item { Layout.fillHeight: true }

        Button {
            Layout.fillWidth: true
            text: qsTr("Exit")
            onClicked: Qt.quit();
            Material.background: Material.Red
        }
    }
}
