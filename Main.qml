import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Smart Terrarium")

    DashboardPage {
        anchors.fill: parent
    }

}
