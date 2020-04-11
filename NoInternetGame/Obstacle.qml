import QtQuick 2.0
import QtQuick.Window 2.12

Rectangle {
    id: root
    x: parent.width - root.width
    y: 100

    property bool active: true
    function stop() {
        root.active=false;
    }

    width: 10
    height: 40
    color: "red"

    Component.onCompleted: t1.start()
    Timer {
        id: t1
        interval: Math.random()*5000
        onTriggered: {
            n1.start()
        }
    }

    NumberAnimation {
        id: n1
        target: root
        property: "x"
        duration: 5000
        easing.type: Easing.Linear
        from: Screen.width - root.width
        to: -root.width

        onStopped:  {
            console.log("animation stopped")
            if (root.active)
            t1.start();
        }
    }
}
