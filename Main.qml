import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Window

Window {
    width: 120
    height: 700
    visible: true
    title: qsTr("Smart Terrarium 🪴")

    EnvironmentModel; {
        id: environment
    }

    OpenMeteo{
        id: simulator
        environment: environment
    }

    Rectangle{
        anchors.fill: parent
        color: "#f2f6f3"

        Column {
            anchors.centerIn: parent
            spacing: 40

            // Header
            Column {
                spacing: 4
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "Smart Terrarium 🪴"
                    font.pixelSize: 28
                    font.weight: Font.DemiBold
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
                    value: environment.humidity.toFixed(1)
                    unit: "%"
                    iconSource:"humidity/humidity.svg"
                }

                SensorCard{
                    label: "Temperature"
                    value: environment.temperature.toFixed(1)
                    unit: "C"
                    iconSource:"temp/medium-temperature-icon.png"
                }
            }

            // status
            Text {
                text: "Source: " + environment.source
                font.pixelSize: 12
                color: "#8a9a8f"
            }
        }
    }

    // bottom control area
    Row {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        spacing: 16

        Button {
            text: simulator.running ? "Stop Simulation" : "Start Simulation"
            onClicked: {
                simulator.running ? simulator.stop() : simulator.start()
            }
        }
        Button {
            text: "Auto Mode"
            onClicked: {
                // enable auto humidity control
            }
        }

        Button {
            text: "Mist ON"
            enabled: false
        }
    }
}
