import QtQuick 2.0

Rectangle {
    id:root
    property alias label: levelLabel.text
    property bool active: false
    property color activecolor: "orange"
    property color inactivecolor: "green"
    property bool enabled: true
    signal clicked();

    width: 150
    height: 50
    radius: 20

    color: (active|| buttonMouseArea.containsMouse)? activecolor : inactivecolor
    Text {
        id: levelLabel
        font.pixelSize: 30
        anchors.centerIn: parent
    }

    MouseArea{
        id:buttonMouseArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: root.enabled
        onClicked: {
            root.clicked();
        }
    }
}
