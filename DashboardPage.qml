import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "Smart Terrarium Dashboard"
            font.pixelSize: 24
        }

        Text {
            text: "Humidity: -- %"
        }

        Text {
            text: "Temperature: -- C"
        }
    }
}
