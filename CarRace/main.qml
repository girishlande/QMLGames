import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import QtGraphicalEffects 1.0

Window {
    id:root
    visible: true
    width: Screen.width
    height: road1.height+road2.height
    title: qsTr("Hello World")

    property int vehicleSppedDuration: 500
    property int carWidth: 130
    property int carHeight: 75
    property bool gamestarted: false
    property variant carLanes: [1,2,3]
    property int activeLevel: 0
    property bool gamePaused: false

    function randomIndex(carIndex) {
        var found = false;
        var laneNumber = Math.round(Math.random()*3)
        for (var i=0; i<carLanes.length; i++) {
            if(carLanes[i]===laneNumber) {
                found = true;
                break;
            }
        }
        if(found===false) {
            carLanes[carIndex] = laneNumber;
        } else {
            randomIndex(carIndex);
        }
    }

    function randomNumber() {
        return Math.random() * 1500;
    }

    function getNumber() {
        return root.randomNumber();
    }

    function startGame() {
        if (gamePaused) {
            road1Animation.restart();
            car1Animation.restart();
            car2Animation.restart();
            car3Animation.restart();
        } else if (!gamestarted) {
            road1Animation.start();
            car1Animation.start();
            car2Animation.start();
            car3Animation.start();
        }
        gamestarted = true
        collisionTimer.running = true;
        winnerTimer.running = true;
    }

    function resetGame() {
        road1Animation.stop();
        car1Animation.stop();
        car2Animation.stop();
        car3Animation.stop();

        road1Animation.pause();
        car1Animation.pause();
        car2Animation.pause();
        car3Animation.pause();
        gameover.visible = false;
        gamestarted = false;
        collisionTimer.running = false;
        gamePaused = true;
    }

    function pauseGame() {
        road1Animation.pause();
        car1Animation.pause();
        car2Animation.pause();
        car3Animation.pause();
    }

    // Level bar
    Rectangle {
        id:levelBar
        width: 200
        height: 350
        radius: 20
        anchors.right: background.right
        anchors.top: background.top
        color: "blue"
        z: 1
        Column {
            id: lebelButtons
            anchors.centerIn: parent
            spacing: 10
            Repeater {
                model: 5
                MyButtom {
                    active: index == activeLevel
                    label: qsTr("LEVEL-"+(index+1))
                    onClicked: {
                        activeLevel = index;
                        vehicleSppedDuration = 1000 - index*200

                    }
                }
            }
        }
    }

    Rectangle {
        id:playButtons
        anchors.top: levelBar.bottom
        anchors.topMargin: 20
        anchors.left: levelBar.left
        height: 150
        width: levelBar.width
        radius: levelBar.radius
        color: "yellow"
        z:1

        Column {
            spacing: 10
            anchors.centerIn: parent
            MyButtom {
                id: startButton
                activecolor: "red"
                inactivecolor: "blue"
                label: "Start"
                enabled: !gameover.visible
                onClicked: {
                    root.startGame();
                }
            }
            MyButtom {
                id: resetButton
                activecolor: "red"
                inactivecolor: "blue"
                label: "Reset"
                onClicked: {
                    root.resetGame();
                }
            }

        }

    }

    Rectangle {
        id:background
        anchors.fill: parent
        color: "green"
        Item {
            anchors.fill: parent
            focus: true
            Keys.onPressed: {
                if (event.key === Qt.Key_Left && gameover.visible===false) {
                    if ((car.x-road1.x)>car.width)
                        car.x = car.x - car.height
                    event.accepted = true;
                }
                if (event.key === Qt.Key_Right && gameover.visible===false) {
                    if ((car.x-road1.x)<car.height*4)
                        car.x = car.x + car.height
                    event.accepted = true;
                }

            }
        }
    }


    Image {
        id: road1
        source: "qrc:/images/road.png"
        x:root.width/2 - width/2
        y:root.height/2
    }
    Image {
        id: road2
        source: "qrc:/images/road.png"
        x:root.width/2 - width/2
        anchors.bottom: road1.top
    }
    Image {
        id: road3
        source: "qrc:/images/road.png"
        x:root.width/2 - width/2
        anchors.bottom: road2.top
    }
    Image {
        id: car
        source: "qrc:/images/car.png"
        width: carWidth
        height: carHeight
        rotation: -90
        x: background.width/2 - (carHeight * 2.4)
        anchors.bottom: background.bottom
        anchors.bottomMargin: 100
    }
    Image {
        id: car1
        source: "qrc:/images/browncar.png"
        width: carWidth
        height: carHeight
        rotation: -90
        x: background.width/2 - (carHeight * 2.4) + carHeight
        y: 0
    }

    ColorOverlay {
        id:car1overlay
        anchors.fill: car1
        opacity: 0.5
        source: car1
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
        rotation: -90
    }

    Image {
        id: car2
        source: "qrc:/images/orangeCar.png"
        width: carWidth
        height: carHeight
        rotation: -90
        x: background.width/2 - (carHeight * 2.4) + carHeight*2
        y: 0
    }
    ColorOverlay {
        id:car2overlay
        anchors.fill: car2
        opacity: 0.5
        source: car2
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1);
        rotation: -90
    }

    Image {
        id: car3
        source: "qrc:/images/browncar.png"
        width: carWidth
        height: carHeight
        rotation: -90
        x: background.width/2 - (carHeight * 2.4) + carHeight*3
        y: -300
    }

    ColorOverlay {
        id:car3overlay
        anchors.fill: car3
        opacity: 0.5
        source: car1
        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
        rotation: -90
    }

    Image {
        id: gameover
        source: "qrc:/images/gameover.jpeg"
        anchors.centerIn: parent
        visible: false
    }

    NumberAnimation {
        id: road1Animation
        target: road1
        property: "y"
        duration: vehicleSppedDuration
        to: root.height
        easing.type: Easing.Linear
        onStopped: {
            road1.y=root.height/2
            road1Animation.start();
        }
    }

    NumberAnimation {
        id: car1Animation
        target: car1
        property: "y"
        duration: vehicleSppedDuration*4
        to: root.height
        easing.type: Easing.Linear
        onStopped: {
            randomIndex(0)
            car1.x = background.width/2 - (carHeight * 2.4) + carHeight * carLanes[0]
            car1.y = 0
            car1overlay.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            car1Animation.start();
        }
    }

    NumberAnimation {
        id: car2Animation
        target: car2
        property: "y"
        duration: vehicleSppedDuration*4
        to: root.height
        easing.type: Easing.Linear
        onStopped: {
            randomIndex(1)
            car2.y = -200
            car2.x = background.width/2 - (carHeight * 2.4) + carHeight * carLanes[1]
            car2overlay.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            car2Animation.start();
        }
    }

    NumberAnimation {
        id: car3Animation
        target: car3
        property: "y"
        duration: vehicleSppedDuration*4
        to: root.height
        easing.type: Easing.Linear
        onStopped: {
            randomIndex(2)
            car3.y = 100
            car3.x = background.width/2 - (carHeight * 2.4) + carHeight * carLanes[2]
            car3overlay.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
            car3Animation.start();
        }
    }

    Timer {
        id:collisionTimer
        interval: 5; repeat: true; running: true

        function myContains( pnt ) {
            return (pnt.x >= car1.x && pnt.x < (car1.x + car1.width) &&
                    pnt.y >= car1.y && pnt.y < (car1.y + car1.height)) ||
                    (pnt.x >= car2.x && pnt.x < (car2.x + car2.width) &&
                     pnt.y >= car2.y && pnt.y < (car2.y + car2.height)) ||
                    (pnt.x >= car3.x && pnt.x < (car3.x + car3.width) &&
                     pnt.y >= car3.y && pnt.y < (car3.y + car3.height))
        }

        function collision() {
            var pnt = Qt.point(car.x+car.width/2,car.y+car.height/2);
            if (myContains(pnt)) {
                return true;
            }
            return false;
        }


        onTriggered: {
            if ( collision()) {
                if(road1Animation.running) {
                    road1Animation.pause();
                }
                if (car1Animation.running) {
                    car1Animation.pause();
                }
                if (car2Animation.running) {
                    car2Animation.pause();
                }
                if (car3Animation.running) {
                    car3Animation.pause();
                }
                gameover.visible = true;
                winnerTimer.running = false;

            }
        }
    }

    Rectangle {
        id: winnerDisplay
        width: 400
        height: 150
        radius: 10
        color: "gold"
        visible: false
        Text {
            text: qsTr("Congratulations!!!You Won in this level !!")
            font.pixelSize: 40
            anchors.centerIn: parent
            anchors.fill: parent
            wrapMode: Text.WordWrap
        }
    }
    Timer {
        id:winnerTimer
        interval: 5000; repeat: true; running: false

        onTriggered: {
            winnerDisplay.visible = true;
            root.pauseGame();
        }
    }

}
