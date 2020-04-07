import QtQuick 2.0

Rectangle {
    id:root

    property int value: 0

    width: 200
    height: 200
    color: "transparent"
    anchors.centerIn: parent

    Text {
        anchors.centerIn: parent
        font.pointSize: 50
        text: "" + root.value
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.value = Math.ceil(Math.random()*6);
        }
    }
}

