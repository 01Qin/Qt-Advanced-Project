import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls
import QtQuick.Window
import QtCharts

Window {
    id: root
    width: 1200
    height: 700
    visible: true
    title: qsTr("Smart Terrarium 🪴")


    property real minHumidity: 60
    property real maxHumidity: 85
    property real minTemp: 18
    property real maxTemp: 26

    property bool humidityLow: environment.valid && environment.humidity < minHumidity
    property bool humidityHigh: environment.valid && environment.humidity > maxHumidity
    property bool tempLow: environment.valid && environment.temp < minTemp
    property bool tempHigh: environment.valid && environment.temp > maxTemp
    property bool alertShown: false
    property string activeMetric: ""

    property color humidityColor: {
        if (!environment.valid) return "#abd1c6"
        if (environment.humidity > maxHumidity) return "#e16162" // Red
        if (environment.humidity < minHumidity) return "#f9bc60" // Orange
        return "#abd1c6" // Green
    }


    property color tempColor: {
        if (!environment.valid) return "#abd1c6"
        if (environment.temp > maxTemp) return "#e16162" // too warm
        if (environment.temp < minTemp) return "#004643" // too cold
}

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

                    numericValue: environment.valid ? environment.humidity : NaN
                    unit: "%"
                    iconSource: humidityHigh ? "humidity/humidity_high.png"
                                : humidityLow ? "humidity/humidity_low.png"
                                              : "humidity/humidity.png"
                    cardColor: humidityColor
                    active: activeMetric === "humidity"
                    onClicked: {
                        activeMetric = "humidity"
                    }
                }

                SensorCard{
                    label: "Temperature"
                    numericValue: environment.valid ? environment.temp : NaN
                    unit: "°C"
                    iconSource: tempHigh ? "temp/temp_high.png"
                                : tempLow ? "temp/temp_low.png"
                                :"temp/temperature.png"
                    cardColor: tempColor
                    active: activeMetric === "temperature"
                    onClicked: activeMetric = "temperature"

                }
            }

            // history panel
            HistoryChart {
                visible: activeMetric !== ""
                width: 460
                height: 200
                anchors.horizontalCenter:parent.horizontalCenter
                metric: activeMetric // humidity or temp
                dataPoints: activeMetric == "humidity" ? environment.humidityHistory : environment.tempHistory
                color: activeMetric == "humidity" ? humidityColor : tempColor
                onCloseRequested: activeMetric = ""

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

                // Text {

                //     text: qsTr("Mode: AUTO")
                //     font.pixelSize: 13
                //     font.bold: true
                //     color: "#fffffe"
                // }

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


                    // Button {
                    //     text: simulator.running ? "Stop Simulation" : "Start Simulation"
                    //     onClicked: simulator.running ? simulator.stop() : simulator.start()

                    //     background: Rectangle {
                    //         radius: 8
                    //         color: "#f9bc60"
                    //     }

                    //     contentItem: Text {
                    //         text: parent.text
                    //         color: "#001e1d"
                    //         font.pixelSize: 13
                    //     }

                    // }

                    // Button {
                    //     text: "Auto Mode"
                    //     enabled: false

                    //     background: Rectangle {
                    //         radius: 8
                    //         color: "#f9bc60"
                    //     }

                    //     contentItem: Text {
                    //         text: parent.text
                    //         color: "#001e1d"
                    //         font.pixelSize: 13
                    //     }


                    // }

                    // Button {
                    //     text: "Mist ON"
                    //     enabled: false

                    //     background: Rectangle {
                    //         radius: 8
                    //         color: "#f9bc60"
                    //     }

                    //     contentItem: Text {
                    //         text: parent.text
                    //         color: "#001e1d"
                    //         font.pixelSize: 13
                    //     }

                    // }

                    // Button {
                    //     text: "Mist OFF"
                    //     enabled: false

                    //     background: Rectangle {
                    //         radius: 8
                    //         color: "#f9bc60"
                    //     }

                    //     contentItem: Text {
                    //         text: parent.text
                    //         color: "#001e1d"
                    //         font.pixelSize: 13
                    //     }

                    // }
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
            alertDialog.messageText = "Humidity is too high (" + Math.round(environment.humidity) +
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
            alertDialog.messageText = "Humidity is too low (" + Math.round(environment.humidity) +
                    "%).\nPlants may dry out."
            alertDialog.open()
        }

        if (!humidityLow){
            alertShown = false
        }
    }

    // Temperature alerts
    onTempHighChanged: {
        if (tempHigh){
            alertDialog.titleText = "High Temperature"
            alertDialog.messageText = "Temperature is too high (" + environment.temp.toFixed(1) +
            "°C)."
            alertDialog.open()
        }
        if (!tempHigh){
            alertShown= false
        }
    }

    onTempLowChanged: {
        if (tempLow){
            alertDialog.titleText = "Low Temperature"
            alertDialog.messageText = "Temperature is too low (" + environment.temp.toFixed(1) +
            "°C)."
            alertDialog.open()
        }
        if (!tempLow){
            alertShown = false
        }
    }



}
