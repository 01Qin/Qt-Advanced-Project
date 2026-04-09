import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Item {
    width: parent.width
    height: parent.height

    Column {
        anchors.centerIn: parent
        spacing: 12

    SensorCard{
        Label: "Humidity"
        value: environment.humidity.toFixed(1)
        unit: "%"
    }

    SensorCard{
        Label: "Temperature"
        value: environment.temperature.toFixed(1)
        unit: "C"
    }
    Text {
        id: name
        text: qsTr("Source: " + environment.source)

    }

    }
}
