import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Dialog {
    id: dialog
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    padding: 0

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
    }

    Text {

        text: messageText
        wrapMode: Text.wrapMode
        width: 300

    }

}
