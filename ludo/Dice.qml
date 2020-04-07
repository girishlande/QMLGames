import QtQuick 2.0

Rectangle {
    id:root

    property int value: 0
    property alias active: diceMouseArea.visible

    signal diceRolled()

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
        id: diceMouseArea
        anchors.fill: parent
        onClicked: {
            root.value = Math.ceil(Math.random()*6);
            root.diceRolled();
        }
    }

    Keys.onDigit1Pressed: {
        root.value = 1;
        root.diceRolled();
    }

    Keys.onDigit2Pressed: {
        root.value = 2;
        root.diceRolled();
    }

    Keys.onDigit3Pressed: {
        root.value = 3;
        root.diceRolled();
    }

    Keys.onDigit4Pressed: {
        root.value = 4;
        root.diceRolled();
    }

    Keys.onDigit5Pressed: {
        root.value = 5;
        root.diceRolled();
    }

    Keys.onDigit6Pressed: {
        root.value = 6;
        root.diceRolled();
    }
}

