import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height

    Column {
        anchors.centerIn: parent
        spacing: 12

    SensorCard{}
    Text {
        id: name
        text: qsTr("Source: " + environment.source)
    }
    }
}
