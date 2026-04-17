import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Dialog {
    id: alertDialog
    modal: true
    anchors.centerIn: parent
    width:360
    padding: 20


    // public api
    property string titleText: ""
    property string messageText: ""
    property string serverity: "Warning"

    // Dialog background
    background: Rectangle{
        radius: 20
        color: "White"

        // soft shadow
        Rectangle {
            anchors.fill: parent
            radius: 20
            y: 6
            color: "#25000000"
            z: -1
        }
    }

    // content
    contentItem: Column {
        width: 360
        spacing: 18
        padding: 24

        // header
        Row {
            spacing: 12
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: serverity === "critical" ? "🚨" : "⚠️"
                font.pixelSize: 26
            }

            Text {
                text: titleText
                font.pixelSize: 20
                font.weight: Font.DemiBold
                color: serverity === "critical" ? "#c62828" : "#efc600"
            }
        }

        // divider
        Rectangle {
            width: parent.width
            height: 1
            color: "#e0e0e0"
        }

        // message
        Text {
            text: messageText
            wrapMode: Text.Wrap
            font.pixelSize: 14
            width: 300
            color: "#444"
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "OK"
            width: 120
            height: 40

            background: Rectangle {
                radius: 12
                color: serverity === "critical" ? "#c62828" : "#efc600"
            }

            contentItem: Text {
                text: "OK"
                color: "white"
                font.pixelSize: 14
                font.weight: Font.Medium
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
            }

            onClicked: dialog.close()
        }
    }


}
