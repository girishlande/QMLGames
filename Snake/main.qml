import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id:root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Hello World")

    property int snakeEggWidth: 100
    property int snakeEggCount: 6
    property string direction: "left"
    ListModel { id: snakeModel  }

    function populateModels() {
        for(var i=0;i<snakeEggCount;i++) {
            snakeModel.append({"ix": i*snakeEggWidth+500, "iy":0, "snakedirection":"left"})
        }
    }

    function generateEgg() {
        newEgg.x = Math.random()  * (Screen.width - snakeEggWidth) + snakeEggWidth/2
        newEgg.y = Math.random()  * (Screen.height - snakeEggWidth) + snakeEggWidth/2
    }

    function gotEgg(pnt) {
        var X = newEgg.x
        var Y = newEgg.y
        if (pnt.x >= X && pnt.x < X + newEgg.width &&
                pnt.y >= Y && pnt.y < Y+newEgg.height) {
            return true;
        }
        return false;
    }

    function advanceSnake() {
        var px = snakeModel.get(snakeEggCount-1).ix;
        var py = snakeModel.get(snakeEggCount-1).iy;

        for(var i=snakeEggCount-1;i>0;i--) {
            var current = snakeModel.get(i);
            var previous = snakeModel.get(i-1);
            current.ix = previous.ix;
            current.iy = previous.iy
        }
        var headEgg = snakeModel.get(0);
        if (direction==="left") {
            headEgg.ix -= snakeEggWidth;
        } else if (direction==="right") {
            headEgg.ix += snakeEggWidth;
        } else if (direction==="bottom") {
            headEgg.iy += snakeEggWidth;
        } else if (direction==="top") {
            headEgg.iy -= snakeEggWidth;
        }
        var pnt = Qt.point(headEgg.ix+snakeEggWidth/2,headEgg.iy+snakeEggWidth/2);
        if(gotEgg(pnt)) {
            snakeModel.append({"ix": px, "iy":py, "snakedirection":"left"})
            snakeEggCount++;
            generateEgg();
        }
    }

    Component.onCompleted: {
        generateEgg();
        populateModels();
    }



    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"
        Item {
            anchors.fill: parent
            focus: true
            Keys.onPressed: {
                var headEgg = snakeModel.get(0);
                if (event.key === Qt.Key_Left) {
                    root.direction="left"
                    console.log("left")
                    headEgg.snakedirection="left"
                }
                if (event.key === Qt.Key_Right) {
                    root.direction="right"
                    console.log("right")
                    headEgg.snakedirection="right"
                }
                if (event.key === Qt.Key_Up) {
                    root.direction="top"
                    console.log("top")
                    headEgg.snakedirection="top"
                }
                if (event.key === Qt.Key_Down) {
                    root.direction="bottom"
                    console.log("bottom")
                    headEgg.snakedirection="bottom"
                }
            }
            Keys.onReleased: {
            }
        }
    }

    Repeater {
        model: snakeModel
        SnakeEgg {
            x:ix
            y:iy
            width: snakeEggWidth
            height: snakeEggWidth
            head: index===0
            direction: snakedirection
        }
    }

    SnakeEgg {
        id:newEgg
        width: snakeEggWidth
        height: snakeEggWidth
        head: false
        goldenegg: true
        color:"blue"
    }

    Timer {
        id:advanceSnakeTimer
        interval: 200
        repeat: true;
        running: true

        onTriggered: {
            root.advanceSnake();
        }
    }

    Rectangle {
        width: 150
        height: 60
        radius: 10
        anchors.right: background.right
        anchors.top: background.top
        color: "orange"
        Text {
            id: pointText
            text: qsTr("#") + snakeEggCount
            font.pixelSize: 40
            anchors.centerIn: parent
        }
    }
}
