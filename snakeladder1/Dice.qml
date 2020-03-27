import QtQuick 2.0

Item {
    id:root

    width: 72
    height: 72

    signal outcome(var value);

    function startRolling() {
        animatedImage.visible = true;
        diceTimer.start();
    }

    Image {
        id:  diceImage
        property int imgIndex: 1
        source: "qrc:/images/dice/4/" + imgIndex + ".png"
        visible: !animatedImage.visible
    }

    AnimatedImage {
        id: animatedImage

        property int imgIndex: 1
        property int timerValue: 0

        visible: false
        source:'qrc:/images/dice/4/rollingDice.gif'
    }

    Timer {
        id: diceTimer
        interval: 1000; running: false;
        onTriggered: {
            diceImage.imgIndex = Math.ceil((Math.random() * 100))%6 + 1;
            diceTimer.running = false;
            animatedImage.visible = false;
            outcome(diceImage.imgIndex);
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.startRolling();
        }
    }
}

