import QtQuick 2.0
import QtMultimedia 5.12

Rectangle {
    id:root

    property int pos: 1
    property alias col: innerCircle.color
    property alias playerphoto: playerPic.source
    property int ballRadius: 60
    property int count: 0
    property int delayCount: 10
    property int inc: 40
    property int snakeIndex: 8
    property int snakeIt: 0

    signal positionUpdated();


    function setPosition(new_position) {
        let old_pos = root.pos;
        posAnimation.from = old_pos;
        posAnimation.to = new_position;
        posAnimation.duration = (new_position - old_pos) * 500;
        posAnimation.start();
    }

    function advancePosition(increment) {
        let old_pos = root.pos;
        let new_position = old_pos + increment;
        posAnimation.from = old_pos;
        posAnimation.to = new_position;
        posAnimation.duration = (new_position - old_pos) * 500;
        posAnimation.start();
    }

    x: mapper.getX(pos)
    y: mapper.getY(pos)
    width: 100
    height: 100
    radius: 25
    color: "transparent"
    onPosChanged: {
        root.x = mapper.getX(pos);
        root.y = mapper.getY(pos);
        clickSound.play();
    }

    Snakes {
        id:snakes
    }

    Ladderss {
        id: ladders
    }

    SoundEffect {
        id: clickSound
        source: "qrc:/sounds/bipclick.wav"
    }

    Rectangle {
        id:innerCircle
        anchors.centerIn: parent
        color: "red"
        opacity: 0.8
        width: 80
        height: 80
        radius: 40
        clip: true

        ProfilePicture {
            id: playerPic
            width: parent.width
            height: parent.height
        }
    }

    SoundEffect {
        id: snakeBite
        source: "qrc:/sounds/slurp.wav"
    }

    SoundEffect {
        id: ladderSound
        source: "qrc:/sounds/airplane1.wav"
    }

    NumberAnimation {
        id: posAnimation
        target: root
        property: "pos"
        from: 1
        to: 100
        easing.type: Easing.Linear

        onStopped: {
            let newPos = snakes.checkSnakeBite(root.pos);
            if (newPos!==root.pos)
            {
                snakeBite.play();
                testSnakeIndex(root.pos);
                root.pos = newPos;
            } else {
                newPos = ladders.checkLadder(root.pos);
                if (newPos!==root.pos) {
                    ladderSound.play();
                    root.startLadderAnimation(root.pos,newPos);
                    root.pos = newPos;
                }
            }
            root.positionUpdated();
        }
    }

    function startLadderAnimation(oldPos,newPos) {
        let oldX = mapper.getX(oldPos);
        let newX = mapper.getX(newPos);
        let oldY = mapper.getY(oldPos);
        let newY = mapper.getY(newPos);
        ladderAnimationX.from = oldX;
        ladderAnimationX.to = newX;
        ladderAnimationY.from = oldY;
        ladderAnimationY.to = newY;

        ladderAnimationX.duration=2000;
        ladderAnimationY.duration=2000;
        ladderAnimationX.start();
        ladderAnimationY.start();
    }

    function testSnakeIndex(index) {
        fileReader.readFile(index);
        root.count=0;
        mtimer.start();
    }

    NumberAnimation {
        id: ladderAnimationX
        target: root
        property: "x"
        easing.type: Easing.Linear
        onStopped: {
            root.positionUpdated();
        }
    }

    NumberAnimation {
        id: ladderAnimationY
        target: root
        property: "y"
        easing.type: Easing.Linear
        onStopped: {
            root.positionUpdated();
        }
    }

    NumberAnimation {
        id: xmovement
        target: root
        property: "x"
        duration: root.delayCount
        easing.type: Easing.Linear
    }

    NumberAnimation {
        id: ymovement
        target: root
        property: "y"
        duration: root.delayCount
        easing.type: Easing.Linear
    }

    Timer {
        id: mtimer
        running: false
        interval: root.delayCount
        repeat: true
        onTriggered: {
            if (count < fileReader.getPoints()) {

                xmovement.from = root.x
                xmovement.to = fileReader.getX(count++) - root.width/2;
                ymovement.from = root.y
                ymovement.to = fileReader.getY(count++) - root.height/2;
                count += root.inc;
                xmovement.start();
                ymovement.start();
            } else {
                mtimer.stop();
            }
        }
    }

}
