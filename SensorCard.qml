import QtQuick
import QtQuick.Controls

Item {
    width: 150
    height: 180

    property string label: ""
    property string unit: ""
    property url iconSource: ""
    property color cardColor: "#3a8f3a"
    property real numericValue: 0
    property bool active: false
    signal clicked()

 // shadow
    Rectangle{
        anchors.fill: parent
        radius: 20
        y: active ? 14 : 10
        color: "#200000000"
    }

// card
    Rectangle{
        anchors.fill: parent
        radius: 20
        color: active ? cardColor : Qt.darker(cardColor, 1.3)

        Column {
            anchors.centerIn: parent
            spacing: 10

            Image {
                source: iconSource
                width: 36
                height: 36
                opacity: active ? 1.0 : 0.5
                fillMode: Image.PreserveAspectFit
                visible: iconSource !== ""
            }

            Text {
                text: label
                font.pixelSize: 14
                color: "#c8e6c9"
            }

            Text {
                // visible:true
                text: Math.round(numericValue) + " " + unit
                font.pixelSize: 20
                font.weight: Font.Bold
                color: "white"

                Behavior on text {
                    NumberAnimation{
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: parent.clicked()
        cursorShape: Qt.PointingHandCursor
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
            from: "#3a8f3a"
            to: "#c62828"
            duration: 400
            easing.type: Easing.InOutQuad
        }
    }
}
