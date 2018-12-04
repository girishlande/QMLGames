import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

Window {
    id:root
    visible: true
    width: Screen.width
    height: Screen.height-100
    title: qsTr("Hello World")
    property int brickHeight: 70/2
    property int brickWidth: 150/2
    property int brickSpacing: 10
    property int brickCount: 20
    property int brickLeftMargin: 100
    property int ballspeed: 1000
    property int basewidth: 500
    property int baseheight: 20
    ListModel { id: row1Model  }
    ListModel { id: row2Model  }
    ListModel { id: row3Model  }
    ListModel { id: row4Model  }
    ListModel { id: row5Model  }

    function populateModels() {
        for(var i=0;i<brickCount;i++) {
            row1Model.append({"ix": i*(brickWidth + brickSpacing) + brickLeftMargin, "iy":0, "v":true})
        }
        for(i=0;i<brickCount;i++) {
            row2Model.append({"ix": i*(brickWidth + brickSpacing)+ brickLeftMargin, "iy":brickHeight*1.1,"v":true})
        }
        for(i=0;i<brickCount;i++) {
            row3Model.append({"ix": i*(brickWidth + brickSpacing)+ brickLeftMargin, "iy":brickHeight*2.2,"v":true})
        }
        for(i=0;i<brickCount;i++) {
            row4Model.append({"ix": i*(brickWidth + brickSpacing)+ brickLeftMargin, "iy":brickHeight*3.3,"v":true})
        }
        for(i=0;i<brickCount;i++) {
            row5Model.append({"ix": i*(brickWidth + brickSpacing)+ brickLeftMargin, "iy":brickHeight*4.4,"v":true})
        }
    }

    function bounceBall() {
        if(leftmoveAnimation.running) {
            leftmoveAnimation.stop();
        } else {
            rightmoveAnimation.stop();
        }
        if(topmoveAnimation.running) {
            topmoveAnimation.stop();
        } else {
            bottommoveAnimation.stop();
        }
    }

    function bounceBallWall() {
        if(topmoveAnimation.running) {
            topmoveAnimation.stop();
        } else {
            bottommoveAnimation.stop();
        }
    }

    function checkCollisionwithBrick(pnt,rowModel) {
        if(checkCollisionwithBase(pnt)) {
            return;
        }
        var hitbrick = false;
        for (var i=0;i<rowModel.count; i++){
            var brickitem = rowModel.get(i);
            if (brickitem.v===true) {
                var brickX = brickitem.ix
                var brickY = brickitem.iy
                if (pnt.x >= brickX && pnt.x < brickX+brickWidth &&
                        pnt.y >= brickY && pnt.y < brickY+brickHeight) {
                    brickitem.v = false;
                    hitbrick = true;

                }
            }
        }
        if(hitbrick)
            bounceBall();
    }

    function checkCollisionwithBase(pnt) {
        var brickX = basewall.x
        var brickY = basewall.y
        if (pnt.x >= brickX && pnt.x < brickX+basewall.width &&
                pnt.y >= brickY && pnt.y < brickY+basewall.height) {
            bounceBallWall();
            return true;
        }
        if (pnt.y >= brickY+basewall.height) {
            gameOver();
        }

        return false;
    }

    function gameOver() {
        collisionTimer.stop();
        if(leftmoveAnimation.running) {
            leftmoveAnimation.pause();
        } else {
            rightmoveAnimation.pause();
        }
        if(topmoveAnimation.running) {
            topmoveAnimation.pause();
        } else {
            bottommoveAnimation.pause();
        }
        gameOverIndicator.visible=true;
        clockwise.stop();
    }


    function collision(rowModel) {
        var pnt = Qt.point(ball.x+ball.width/2,ball.y+ball.height/2);
        checkCollisionwithBrick(pnt,rowModel);
        pnt = Qt.point(ball.x,ball.y+ball.height/2);
        checkCollisionwithBrick(pnt,rowModel);
        pnt = Qt.point(ball.x+ball.width,ball.y+ball.height/2);
        checkCollisionwithBrick(pnt,rowModel);
        pnt = Qt.point(ball.x+ball.width/2,ball.y);
        checkCollisionwithBrick(pnt,rowModel);
        pnt = Qt.point(ball.x+ball.width/2,ball.y+ball.height);
        checkCollisionwithBrick(pnt,rowModel);
    }

    Component.onCompleted: {
        rightmoveAnimation.start();
        topmoveAnimation.start();
        populateModels();
    }

    Rectangle {
        id:background
        anchors.fill: parent
        color: "black"
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onMouseXChanged: {
                basewall.x = mouse.x
            }
        }
    }
    Image {
        id:gameOverIndicator
        source: "qrc:/images/gameover1.jpg"
        anchors.centerIn: background
        visible: false
    }

    Rectangle {
        id:basewall
        x: root.width/2 - width/2
        y:root.height - height
        width: basewidth
        height: baseheight
        color: "blue"
    }


    Repeater {
        model: row1Model;
        Brick {x:ix; y:iy; width: brickWidth; height: brickHeight; visible: v}
    }
    Repeater {
        model: row2Model;
        Brick {x:ix; y:iy; width: brickWidth; height: brickHeight; visible: v}
    }
    Repeater {
        model: row3Model;
        Brick {x:ix; y:iy; width: brickWidth; height: brickHeight; visible: v}
    }
    Repeater {
        model: row4Model;
        Brick {x:ix; y:iy; width: brickWidth; height: brickHeight; visible: v}
    }
    Repeater {
        model: row5Model;
        Brick {x:ix; y:iy; width: brickWidth; height: brickHeight; visible: v}
    }
    Image {
        id:ball
        source: "qrc:/images/ball.png"
        x:root.width/2 - width/2
        y:root.height - height - basewall.height
        width: 100
        height: 100
    }
    RotationAnimation {
        id:clockwise
        target: ball
        from: 0;
        to: 360;
        duration: ballspeed
        loops: Animation.Infinite
        running: true
    }

    NumberAnimation {
        id:rightmoveAnimation
        target: ball
        to: root.width - ball.width
        property: "x"
        duration: ballspeed+500
        easing.type: Easing.Linear
        onStopped: {
            leftmoveAnimation.start();
        }
    }
    NumberAnimation {
        id:leftmoveAnimation
        target: ball
        to: 0
        property: "x"
        duration: ballspeed + 500
        easing.type: Easing.Linear
        onStopped: {
            rightmoveAnimation.start()
        }
    }
    NumberAnimation {
        id:topmoveAnimation
        target: ball
        to: 0
        duration: ballspeed
        property: "y"
        easing.type: Easing.Linear
        onStopped: {
            bottommoveAnimation.start()
        }
    }
    NumberAnimation {
        id:bottommoveAnimation
        target: ball
        to:root.height
        property: "y"
        duration: 2000
        easing.type: Easing.Linear
        onStopped: {
            topmoveAnimation.start()
        }
    }


    Timer {
        id:collisionTimer
        interval: 5;
        repeat: true;
        running: true

        onTriggered: {
            root.collision(row1Model);
            root.collision(row2Model);
            root.collision(row3Model);
            root.collision(row4Model);
            root.collision(row5Model);
        }
    }
}
