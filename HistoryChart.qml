import QtQuick
import QtQuick.Controls
import QtCharts

Item {
    id: root
    property string metric: "humidity"
    property var dataPoints: []
    property color color: "#abd1c6"
    property var dateLabels: []
    signal closeRequested()

    // animate in
    opacity: visible ? 1 : 0
    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }

    // close Button
    Rectangle {
        anchors.fill: parent
        radius: 20
        color: "#cc000000"

        Rectangle{
            id: closeButton
            width: 28
            height: 28
            radius: 6
            color: "#001e1d"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10


        Text {
            text: qsTr("x")
            color: "#e8e4e6"
            anchors.centerIn: parent
            font.pixelSize: 16
            font.bold: true
        }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
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
            margins.bottom: 24
            margins.left: 0
            margins.right: 0

            DateTimeAxis {
                id: axisX
                format: "MMM d"

                labelsColor: "#fffffe"
                labelsFont.pixelSize: 10
                labelsAngle: -45
                gridLineColor: "#33ffffff"

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

        if(!dataPoints || dataPoints.length === 0)
            return

        var minTime = null
        var maxTime = null


        for (var i =0; i < dataPoints.length; i++){
            var dateStr = (dateLabels && dateLabels.length > i) ? dateLabels[i] : ""
            var date = new Date(dateStr)

            if(isNaN(date.getTime())) continue
            if (!minTime || date < minTime) minTime = date
            if (!maxTime || date > maxTime) maxTime = date
            series.append(date.getTime(), dataPoints[i])
        }

        if(minTime && maxTime){
            axisX.min = minTime
            axisX.max = maxTime
        }
    }

    // onDataPointsChanged: rebuildSeries()
    // onMetricChanged: rebuildSeries()
    // // onDateLabelsChanged: rebuildSeries()
}
