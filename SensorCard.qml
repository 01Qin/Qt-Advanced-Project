import QtQuick
import QtQuick.Controls

Item {
    width: 150
    height: 180

    property string label: ""
    property string value: ""
    property string unit: ""
    property url iconSource: ""
    property color cardColor: "#3a8f3a"

 // shadow
    Rectangle{
        anchors.fill: parent
        radius: 20
        y: 5
        color: "#200000000"
    }

// card
    Rectangle{
        anchors.fill: parent
        radius: 20
        color: "#2e7d32"

        Column {
            anchors.centerIn: parent
            spacing: 10

            Image {
                source: iconSource
                width: 36
                height: 36
                opacity: 0.9
                fillMode: Image.PreserveAspectFit
                visible: iconSource !== ""
            }

            Text {
                text: label
                font.pixelSize: 14
                color: "#c8e6c9"
            }

            Text {
                text: value + " " + uint
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
}
