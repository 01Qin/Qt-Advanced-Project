import QtQuick
import QtQuick.Controls

Rectangle {
    width: 150
    height: 100
    radius: 10
    color: "#2e7d32"

    Column {
        anchors.centerIn: parent
        spacing: 4

        Text {
            id: name
            text: qsTr("Humidity")
            color: "white"
        }

        Text {
            text: environment.humidity.toFixed(1) + " %"
            font.pixelSize: 20
            color: "white"
        }
    }
}
