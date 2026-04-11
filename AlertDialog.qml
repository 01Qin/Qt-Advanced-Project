import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

Dialog {
    id: dialog
    modal: true
    standardButtons: dialog.Ok

    property string titleText: ""
    property string messageText: ""

    title: titleText

    Text {

        text: messageText
        wrapMode: Text.wrapMode
        width: 300

    }

}
