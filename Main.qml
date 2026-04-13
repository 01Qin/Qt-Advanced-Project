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
    property bool alertShown: false

    property color humidityColor:
        humidityHigh ? "#c62828" : // mold risk
        humidityLow ? "#ef6c00" : // too dry
                      "#4CAF50" // healthy

    property color temperatureColor:
        temperatureHigh ? "#c62828" : // too hot
        temperatureLow ? "#1565c0" : // too clod
                      "#26A69A" // healthy

    // background
    Item {
        anchors.fill: parent

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: "images/background.jpg"
        }

        Column {
            anchors.centerIn: parent
            anchors.margins: 40
            spacing: 28

            // Header
            Column {
                spacing: 4
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    text: "🪴 Smart Terrarium 🪴"
                    font.pixelSize: 28
                    font.weight: Font.DemiBold
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                }

                Text {
                    text: "Live environment monitoring"
                    font.pixelSize: 14
                    color: "#fffffe"
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width

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
                    cardColor: humidityColor
                    active: activeMetric === "humidity" ? "" : "humidity"
                    onClicked: {
                        activeMetric = "humidity"
                    }
                }

                SensorCard{
                    label: "Temperature"
                    numericValue: environment.temperature
                    unit: "C"
                    iconSource:"temp/temperature.png"
                    cardColor: temperatureColor
                    active: activeMetric === "temperature"
                    onClicked: activeMetric = "temperature" ? "" : "temperature"

                }
            }

    // status
    Rectangle{
        width: parent.width
        height: 44
        radius: 12
        color: "transparent"

        Row {
            anchors.centerIn: parent
            spacing: 32


                Text {

                    text: environment.humidity > 85 ? "Mold Risk" : "Mold Risk: Low"
                    font.pixelSize: 13
                    font.bold: true
                    color: environment.humidity > 85 ? "#c62828" : "#fffffe"
                }

                Text {

                    text: qsTr("Mode: AUTO")
                    font.pixelSize: 13
                    font.bold: true
                    color: "#fffffe"
                }

                Text {
                    text: qsTr("Mode: Online")
                    font.pixelSize: 13
                    font.bold: true
                    color: "#fffffe"
                }
        }

    }


            // metadata
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Source: " + environment.source
                font.pixelSize: 12
                color: "#fffffe"
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
                color: "transparent"


                Row {
                    anchors.bottom: parent.bottom
                    anchors.centerIn: parent
                    spacing: 16


                    Button {
                        text: simulator.running ? "Stop Simulation" : "Start Simulation"
                        onClicked: simulator.running ? simulator.stop() : simulator.start()

                        background: Rectangle {
                            radius: 8
                            color: "#f9bc60"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#001e1d"
                            font.pixelSize: 13
                        }

                    }

                    Button {
                        text: "Auto Mode"
                        enabled: false

                        background: Rectangle {
                            radius: 8
                            color: "#f9bc60"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#001e1d"
                            font.pixelSize: 13
                        }


                    }

                    Button {
                        text: "Mist ON"
                        enabled: false

                        background: Rectangle {
                            radius: 8
                            color: "#f9bc60"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#001e1d"
                            font.pixelSize: 13
                        }

                    }

                    Button {
                        text: "Mist OFF"
                        enabled: false

                        background: Rectangle {
                            radius: 8
                            color: "#f9bc60"
                        }

                        contentItem: Text {
                            text: parent.text
                            color: "#001e1d"
                            font.pixelSize: 13
                        }

                    }
                }
            }
        }
    }

    AlertDialog{
        id: alertDialog
    }

    // Humidity alerts
    onHumidityHighChanged: {
        if (humidityHigh){
            alertDialog.titleText = "Mold Risk"
            alertDialog.messageText = "humidity is too high (" + Math.round(environment.humidity) +
                    "%).\nRisk of mold growth."
            alertDialog.open()
        }

        if (!humidityHigh){
            alertShown = false
        }
    }

    onHumidityLowChanged: {
        if (humidityLow){
            alertDialog.titleText = "Low Humidity"
            alertDialog.messageText = "humidity is too low (" + Math.round(environment.humidity) +
                    "%).\nPlants may dry out."
            alertDialog.open()
        }

        if (!humidityLow){
            alertShown = false
        }
    }

    // Temperature alerts
    onTemperatureHighChanged: {
        if (temperatureHigh){
            alertDialog.titleText = "High Temperature"
            alertDialog.messageText = "Temperature is too high (" + environment.temperature.toFixed(1) +
            "C)."
            alertDialog.open()
        }
        if (!temperatureHigh){
            alertShown= false
        }
    }

    onTemperatureLowChanged: {
        if (temperatureLow){
            alertDialog.titleText = "Low Temperature"
            alertDialog.messageText = "Temperature is too low (" + environment.temperature.toFixed(1) +
            "C)."
            alertDialog.open()
        }
        if (!temperatureLow){
            alertShown = false
        }
    }



}
