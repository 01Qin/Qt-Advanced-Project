import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Window

Window {
    width: 1200
    height: 700
    visible: true
    title: qsTr("Smart Terrarium 🪴")

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
                }

                SensorCard{
                    label: "Temperature"
                    numericValue: environment.temperature
                    unit: "C"
                    iconSource:"temp/temperature.png"
                    cardColor: "#2e7d6b"
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

        Button {
            text: "Mist OFF"
            enabled: false
        }
    }
}
