import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick 2.12

Item {
    id:root

    width: 72
    height: 72

    signal outcome(var value);

    function startRolling() {
        animatedImage.visible = true;
        diceTimer.start();
        diceSound.play();
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
            diceSound.stop();
            diceImage.imgIndex = Math.ceil((Math.random() * 100))%6 + 1;
            diceTimer.running = false;
            animatedImage.visible = false;
            outcome(diceImage.imgIndex);
        }
    }
    MouseArea {
        focus: true
        anchors.fill: parent
        onClicked: {
            root.startRolling();
        }
        Keys.onDigit1Pressed: root.outcome(1);
        Keys.onDigit2Pressed: root.outcome(2);
        Keys.onDigit3Pressed: root.outcome(3);
        Keys.onDigit4Pressed: root.outcome(4);
        Keys.onDigit5Pressed: root.outcome(5);
        Keys.onDigit6Pressed: root.outcome(6);
    }

    SoundEffect {
        id: diceSound
        source: "qrc:/sounds/dice.wav"
    }

}

