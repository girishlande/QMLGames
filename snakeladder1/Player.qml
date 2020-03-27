import QtQuick 2.0

Rectangle {
    id:root

    property int pos: 1
    property alias col: innerCircle.color

    signal positionUpdated();

    Snakes {
        id:snakes
    }

    Ladderss {
        id: ladders
    }

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
    }

    Rectangle {
        id:innerCircle
        anchors.centerIn: parent
        color: "red"
        opacity: 0.8
        width: 80
        height: 80
        radius: 40
    }

    NumberAnimation {
        id: posAnimation
        target: root
        property: "pos"
        from: 1
        to: 100
        duration: 20000
        easing.type: Easing.Linear

        onStopped: {
            let newPos = snakes.checkSnakeBite(root.pos);
            if (newPos!==root.pos) {
                root.pos = newPos;
            } else {
                newPos = ladders.checkLadder(root.pos);
                root.pos = newPos;
            }
            root.positionUpdated();
        }
    }
}
