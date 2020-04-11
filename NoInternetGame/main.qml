import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.12

Window {
    id:root
    visible: true
    width: Screen.width

    height: 600
    title: qsTr("Hello World")

    property int jumpHeight: 200
    function jump() {
        a1.start()
    }

    NumberAnimation {
        id:a1
        target: player
        property: "y"
        duration: 300
        easing.type: Easing.Linear
        from: root.height - road.height  - player.height
        to: root.height - road.height - player.height - root.jumpHeight
        onStopped: a2.start();
    }

    NumberAnimation {
        id:a2
        target: player
        property: "y"
        duration: 300
        easing.type: Easing.Linear
        from:root.height - road.height - player.height - root.jumpHeight
        to: root.height - road.height  - player.height
    }


    Button {
        id: jumpButton
        text: "Jump"
        focus: true
        onClicked: {
            root.jump();
        }
    }

    Rectangle {
        id:player
        x:50
        y:root.height - road.height - height
        width: 50
        height: 100
        radius: 20
        color: "black"
    }
    Rectangle {
        id:road
        width: parent.width
        height: 100
        y: root.height  -height
        color: "green"
    }

    Keys.onSpacePressed: {
        root.jump();
    }

    Obstacle {
        id: o1
    }

    Component.onCompleted: {

    }
}
