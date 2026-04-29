import QtQuick
import QtQuick.Controls
import QtCharts

Item {
    id: root
    property string metric: "humidity"
    property var dataPoints: []
    property color color: "#abd1c6"
    signal closeRequested()

    // animate in
    opacity: visible ? 1 : 0
    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "#cc000000"

        // close Button
        Text {

            text: qsTr("x")
            color: "white"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 12
            font.pixelSize: 16

            MouseArea {
                anchors.fill: parent
                onClicked: root.closeRequested()
            }
        }

        Text {
            id: chartTitle
            text: root.metric === "humidity" ? "Humidity History (%)" : "Temperature History (°C)"
            color: "white"
            font.pixelSize: 13
            font.bold: true
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 12
        }

        ChartView {
            anchors.top: chartTitle.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8
            backgroundColor: "transparent"
            plotAreaColor: "transparent"
            legend.visible: false
            antialiasing: true
            margins.top: 0
            margins.bottom: 0
            margins.left: 0
            margins.right: 0

            ValueAxis {
                id: axisX
                min: 0
                max: Math.max(root.dataPoints.length - 1, 1)
                labelsColor: "#fffffe"
                labelsFont.pixelSize: 10
                gridLineColor: "#33ffffff"
                tickCount: 5
            }

            ValueAxis {
                id: axisY
                min: root.metric == "humidity" ? 0 : -10
                max: root.metric == "humidity" ? 100 : 40
                labelsColor: "#fffffe"
                labelsFont.pixelSize: 10
                gridLineColor: "#33ffffff"
                tickCount: 5
            }

            LineSeries {
                id: series
                axisX: axisX
                axisY: axisY
                width: 2
                color: "white"
            }

            Component.onCompleted: root.rebuildSeries()
        }
    }

    function rebuildSeries(){
        series.clear()
        for (var i =0; i < dataPoints.length; i++){
            series.append(i, dataPoints[i])
        }
    }

    onDataPointsChanged: rebuildSeries()
}
