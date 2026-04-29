import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Dialog {
    id: alertDialog
    modal: true
    anchors.centerIn: parent
    width: 360
    padding: 20


    // public api
    property string titleText: ""
    property string messageText: ""
    property string severity: "Warning"

    // Dialog background
    background: Rectangle{
        radius: 16
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
    Column {
        spacing: 12
        width: parent.width

        // header
        Row {
            spacing: 12
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: severity === "critical" ? "🚨" : "⚠️"
                font.pixelSize: 26
            }

            Text {
                text: titleText
                font.pixelSize: 20
                font.weight: Font.DemiBold
                color: severity === "critical" ? "#c62828" : "#efc600"
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
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: 14
            color: "#001e1d"
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            width: 120
            height: 40
            padding: 0

            background: Rectangle {
                radius: 12
                color: severity === "critical" ? "#c62828" : "#efc600"
            }

            contentItem: Text {
                text: "OK"
                color: "white"
                font.pixelSize: 14
                anchors.fill: parent
                font.weight: Font.Medium
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

            }

            onClicked: alertDialog.close()
        }
    }


}
