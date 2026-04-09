import QtQuick
import QtQuick.Controls

Rectangle {
    width: 150
    height: 100
    radius: 10
    color: "#2e7d32"

    property string label: value
    property string value: value
    property string unit: value

    Column {
        anchors.centerIn: parent
        spacing: 4

        Text {
            id: name
            text: label
            color: "white"
        }

        Text {
            text: value + " " + uint
            font.pixelSize: 20
            color: "white"
        }
    }
}
