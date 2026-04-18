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


    }
}
