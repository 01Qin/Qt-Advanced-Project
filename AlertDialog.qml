import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.Controls

// Reusable modal alert popup with severity levels (warning / critical)
// Usage: set titleText, messageText, severity, then call alertDialog.open()

Dialog {
    id: alertDialog
    modal: true // blocks interaction with background
    anchors.centerIn: parent
    width: 360
    padding: 20


    // ── Public API ───────────────────────────────────────────────────────
    property string titleText: ""
    property string messageText: ""
    property string severity: "Warning"

    // ── Background ───────────────────────────────────────────────────────
    // White rounded card with a subtle drop shadow underneath
    background: Rectangle{
        radius: 16
        color: "White"

        // Drop shadow — slightly offset dark rectangle behind the card
        Rectangle {
            anchors.fill: parent
            radius: 20
            y: 6
            color: "#25000000"
            z: -1
        }
    }


    // ── Content ──────────────────────────────────────────────────────────
    Column {
        spacing: 12
        width: parent.width

        // Header row: emoji icon + title text
        // Icon and color change based on severity level
        Row {
            spacing: 12
            anchors.horizontalCenter: parent.horizontalCenter

            // 🚨 for critical alerts, ⚠️ for general warnings
            Text {
                text: severity === "critical" ? "🚨" : "⚠️"
                font.pixelSize: 26
            }

            Text {
                text: titleText
                font.pixelSize: 20
                font.weight: Font.DemiBold
                // Red for critical, yellow for warning
                color: severity === "critical" ? "#c62828" : "#efc600"
            }
        }

        // Horizontal divider between header and message body
        Rectangle {
            width: parent.width
            height: 1
            color: "#e0e0e0"
        }

        // Message body — wraps to multiple lines if needed
        Text {
            text: messageText
            width: parent.width
            wrapMode: Text.Wrap
            font.pixelSize: 14
            color: "#001e1d"
            horizontalAlignment: Text.AlignHCenter
        }

        // Dismiss button — color matches severity
        // Closes the dialog when tapped
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
