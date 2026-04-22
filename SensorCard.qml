import QtQuick
import QtQuick.Controls

Item {
    id: root
    width: 150
    height: 180

    property string label: ""
    property string unit: ""
    property url iconSource: ""
    property color cardColor: "#3a8f3a"
    property real numericValue: 0
    property bool active: false
    property bool hovered: mouse.containsMouse

    signal clicked()

 // shadow
    Rectangle{
        anchors.fill: parent
        radius: 20
        y: active ? 16 : hovered ? 13: 10
        color: hovered || active ? "#30000000" : "#25000000"
    }

// card
    Rectangle{
        id: card
        anchors.fill: parent
        radius: 20
        color: cardColor
        border.width: active ? 2 : 0
        border.color: "white"
        scale: active ? 1.04 : hovered ? 1.02 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Behavior on border.width {
            NumberAnimation{
                duration: 150
            }
        }


        Column {
            anchors.centerIn: parent
            spacing: 10

            Image {
                source: iconSource
                width: 36
                height: 36
                fillMode: Image.PreserveAspectFit
                // visible: iconSource !== ""
            }

            Text {
                text: label
                font.pixelSize: 14
                color: "#f5f5f5"
                opacity: 0.9
            }

            Text {
                // visible:true
                text: isNaN(numericValue) ? "--" : Math.round(numericValue) + " " + unit
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "white"

                Behavior on text {
                    NumberAnimation{
                        duration: 30
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }

}
    MouseArea{
        id: mouse
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: root.clicked()
    }

    Behavior on active {
        NumberAnimation{
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on numericValue {
        NumberAnimation{
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on cardColor {

        ColorAnimation {
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }
}
