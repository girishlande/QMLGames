import QtQuick 2.0

Rectangle {
    id:root
    border.color: "yellow"
    border.width: 3
    width: 100
    height: 100
    radius: width/2
    color: "red"
    property string direction: "right"
    property bool head: false
    property bool goldenegg: false

    function calculateAngle() {
        if (root.direction==="top") {
            return 45;
        } else if(root.direction==="right") {
            return 135;
        } else if(root.direction==="bottom") {
            return 225;
        } else if(root.direction==="left") {
            return 315;
        }
    }
    onDirectionChanged: {
        console.log("direction changed")
        rotationId.angle = root.calculateAngle();
    }

    Rectangle{
        id:headRect
        visible: head
        x:0
        y:0
        width: root.width/2
        height: root.height/2
        color: "black"
        z:2
        transform: Rotation {
            id:rotationId
            origin.x: root.width/2
            origin.y: root.height/2
            angle:root.calculateAngle()
        }
    }


    NumberAnimation {
        target: root
        property: "opacity"
        from:0.5
        to:1
        duration: 2000
        easing.type: Easing.Linear
        loops: Animation.Infinite
        running:goldenegg
    }
}
