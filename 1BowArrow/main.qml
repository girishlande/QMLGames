import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.0

Window {
    id:root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")
    property int bullsEyeDuration: 3000
    property int missCount: 0
    property alias arrowDuration: arrowAnimation.duration

    Component.onCompleted: {
        root.showFullScreen();
    }



    Rectangle {
        id:bowRect
        x:100
        y:parent.height/2 - height/2
        width: 250
        height: 300
        color: "white"
        property bool mousePressed: false
        property int initialX: 100
        Canvas {
            anchors.fill: parent
            id:canvas
            property real mousexposlimit: 100
            property real mousexpos: 100
            onPaint:{
                var ctx = canvas.getContext('2d');
                ctx.clearRect(0,0, 250, 300)
                ctx.strokeStyle = Qt.rgba(0, 0, 0, 1);
                ctx.lineWidth = 4;
                ctx.beginPath();
                ctx.moveTo(100, 0);//start point
                ctx.bezierCurveTo(200,100,200,200, 100, 300);
                ctx.stroke();
                ctx.lineWidth = 2;
                ctx.moveTo(100, 0);//start point
                ctx.lineTo(mousexpos,150);
                ctx.moveTo(mousexpos, 150);//start point
                ctx.lineTo(100,300);
                ctx.stroke();
            }
        }

    }

    NumberAnimation {
        id:restoreStringAnimation
        target: canvas
        property: "mousexpos"
        duration: 1000
        to:100
        easing.type: Easing.InOutQuad
        onPropertyChanged: {
            canvas.requestPaint();
        }
    }
    Image {
        id: arrow
        source: "qrc:/images/arrow.png"// This is available in all ed
        width: 200
        height: 30
        x:bowRect.x + canvas.mousexposlimit
        y:parent.height/2 - height/2
    }


    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPressed: {
            if (mouse.x>10 && mouse.x>arrow.x && mouse.x<arrow.x+arrow.width &&
                    mouse.y>arrow.y && mouse.y<arrow.y+arrow.height) {
                canvas.mousexpos = mouse.x - 100
                bowRect.mousePressed = true;
                canvas.requestPaint();
            }
        }
        onReleased: {
            if (bowRect.mousePressed === true) {
                bowRect.mousePressed = false;
                arrowAnimation.start();
                canvas.mousexpos = 100;
                canvas.requestPaint();
            }
        }

        onMouseXChanged: {
            if(bowRect.mousePressed &&  mouse.x >10) {
                if ((mouse.x-100)<canvas.mousexposlimit) {
                    canvas.mousexpos = mouse.x - 100
                    arrow.x = mouse.x
                    canvas.requestPaint();
                    var stringMagnitude = canvas.mousexposlimit - mouse.x
                    var duration = 3000 - (stringMagnitude * 100)
                    if (duration>100) {
                        root.arrowDuration = duration
                    }
                }
            }
        }
    }

    Image {
        id: bullsEye
        source: "qrc:/images/bullsEye.svg"
        x:parent.width - bullsEye.width
        width: 300
        height: 300
    }

    Rectangle {
        id:bullsEyeCenter
        width: 50
        height: 50
        anchors.centerIn: bullsEye
        visible: false
    }

    ColorOverlay {
        anchors.fill: bullsEye
        source: bullsEye
        color: "#80000090"
    }

    NumberAnimation {
        id: arrowAnimation
        target: arrow
        property: "x"
        duration: 1000
        to:root.width
        easing.type: Easing.Linear
        onStopped: {
            if (collisionTimer.collision()) {
                print("HIT");
                status.text="HIT"
            } else {
                print("MISS");
                missCount++;
                status.text="MISS (#" + missCount + ")"
            }
            arrow.opacity = 0
            arrow.x = bowRect.x + canvas.mousexposlimit
            arrowAppearanceAnimation.running=true

        }
    }

    NumberAnimation {
        id: arrowAppearanceAnimation
        target: arrow
        property: "opacity"
        duration: 2000
        to:1
        easing.type: Easing.Linear
    }

    NumberAnimation {
        id: bullsEyeDownwardAnimation
        target: bullsEye
        property: "y"
        duration: bullsEyeDuration
        to:root.height - bullsEye.height
        easing.type: Easing.Linear
        running: true
        onStopped: {
            bullsEyeUpwardAnimation.start()
        }
    }
    NumberAnimation {
        id: bullsEyeUpwardAnimation
        target: bullsEye
        property: "y"
        duration: bullsEyeDuration
        to:0
        easing.type: Easing.Linear
        running: false
        onStopped: {
            bullsEyeDownwardAnimation.start()
        }
    }

    Timer {
        id:collisionTimer
        interval: 5; repeat: true; running: true

        function myContains( pnt ) {
            return (pnt.x >= bullsEyeCenter.x && pnt.x < (bullsEyeCenter.x + bullsEyeCenter.width) &&
                    pnt.y >= bullsEyeCenter.y && pnt.y < (bullsEyeCenter.y + bullsEyeCenter.height));
        }

        function collision() {
            var pnt = Qt.point(arrow.x+arrow.width,arrow.y+arrow.height/2);
            if (collisionTimer.myContains(pnt)) {
                return true;
            }
            return false;
        }


        onTriggered: {
            if ( collision() && arrowAnimation.running) {
                collisionTimer.running = false;
                status.text="HIT"
                arrowAnimation.pause();
                if (bullsEyeDownwardAnimation.running)
                    bullsEyeDownwardAnimation.pause()
                if(bullsEyeUpwardAnimation.running)
                    bullsEyeUpwardAnimation.pause();
            }
        }
    }

    Text {
        id: status
        text: qsTr("Start shooting")
        font.pixelSize: 50
        x:parent.width/2
    }

    Rectangle {
        id: restartButton
        anchors.top: parent.top
        anchors.left: parent.left
        width: 150
        height: 50
        color: "blue"
        radius: 10
        Text {
            id: restartLabel
            text: qsTr("RESTART")
            font.pixelSize: 30
            anchors.centerIn: parent
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                restartButton.color="green"
            }
            onExited: {
                restartButton.color="blue"
            }

            onClicked: {
                if (arrowAnimation.running) {
                    arrowAnimation.stop()
                }

                if (bullsEyeUpwardAnimation.running)
                    bullsEyeUpwardAnimation.stop()
                if (bullsEyeDownwardAnimation.running)
                    bullsEyeDownwardAnimation.stop()
                bullsEye.y = root.height/2 - bullsEye.height/2
                bullsEyeDownwardAnimation.start()
                missCount=0
                status.text="Start shooting"
                arrow.x = bowRect.x + canvas.mousexposlimit
                collisionTimer.running = true;
            }
        }
    }
}
