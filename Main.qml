import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Window

Window {
    width: 1200
    height: 700
    visible: true
    title: qsTr("Smart Terrarium 🪴")

    property real minHumidity: 60
    property real maxHumidity: 85
    property real minTemperature: 18
    property real maxTemperature: 26

    property bool humidityLow: environment.humidity < minHumidity
    property bool humidityHigh: environment.humidity > maxHumidity
    property bool temperatureLow: environment.temperature < minTemperature
    property bool temperatureHigh: environment.temperature > maxTemperature

    // background
    Rectangle{
        anchors.fill: parent
        color: "#f2f6f3"

        Column {
            anchors.centerIn: parent
            anchors.margins: 40
            spacing: 28

            // Header
            Column {
                spacing: 4
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Smart Terrarium 🪴"
                    font.pixelSize: 28
                    font.weight: Font.DemiBold
                    color: "#1f2d1f"
                }

                Text {
                    text: "Live environment monitoring"
                    font.pixelSize: 14
                    color: "#6b7b6f"
                }
            }

            // Sensor area
            Row {
                spacing: 32
                anchors.horizontalCenter: parent.horizontalCenter

                SensorCard{
                    label: "Humidity"
                    numericValue: environment.humidity
                    unit: "%"
                    iconSource:"humidity/humidity.png"
                    cardColor: "#3f8f3f"
                    active: activeMetric == "humidity"
                    onClicked: {
                        activeMetric = "humidity"
                    }
                }

                SensorCard{
                    label: "Temperature"
                    numericValue: environment.temperature
                    unit: "C"
                    iconSource:"temp/temperature.png"
                    cardColor: "#2e7d6b"
                    active: activeMetric === "temperature"
                    onClicked: activeMetric = "temperature"

                }
            }

    // status
    Rectangle{
        width: parent.width
        height: 44
        radius: 12
        color: "#e6efe8"

        Row {
            anchors.centerIn: parent
            spacing: 32


                Text {

                    text: environment.humidity > 85 ? "Mold Risk" : "Mold Risk: Low"
                    font.pixelSize: 13
                    color: environment.humidity > 85 ? "#c62828" : "#2e7d32"
                }

                Text {

                    text: qsTr("Mode: AUTO")
                    font.pixelSize: 13
                    color: "#2e7d32"
                }

                Text {
                    text: qsTr("Mode: Online")
                    font.pixelSize: 13
                    color: "#2e7d32"
                }
        }

    }


            // metadata
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Source: " + environment.source
                font.pixelSize: 12
                color: "#8a9a8f"
            }

            Item {
                height: 1
                width: 1
            }

            // control zone
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                height: 70
                width: 520
                radius: 20
                color: "#ffffff"

                Rectangle {
                    anchors.fill: parent
                    radius: 20
                    y: 6
                    color: "#20000000"
                }

                Row {
                    anchors.bottom: parent.bottom
                    spacing: 16

                    Button {
                        text: simulator.running ? "Stop Simulation" : "Start Simulation"
                        onClicked: simulator.running ? simulator.stop() : simulator.start()

                    }

                    Button {
                        text: "Auto Mode"
                        enabled: false
                    }

                    Button {
                        text: "Mist ON"
                        enabled: false
                    }

                    Button {
                        text: "Mist OFF"
                        enabled: false
                    }
                }
            }
        }
    }

    AlertDialog{
        id: alertDialog
    }



}
