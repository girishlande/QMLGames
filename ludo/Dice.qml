import QtQuick 2.0

Rectangle {
    id:root

    anchors.centerIn: parent

    width: 200
    height: 200
    color: "transparent"

    signal emitValue(var value);

    property int currentValue: 0
    Text {
        anchors.centerIn: parent
        font.pointSize: 50
        text: "" + root.currentValue
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            currentValue = Math.ceil(Math.random()*6);
            root.emitValue(currentValue);
        }
    }
}

