import QtQuick 2.0
import QtQuick.Window 2.12

Rectangle {
    id: root
    x: parent.width - root.width
    y: 100

    width: 50
    height: 100
    color: "red"

    NumberAnimation {
        target: root
        property: "x"
        duration: 2000
        running: true
        easing.type: Easing.Linear
        from: Screen.width
        to: -100
        onLoopCountChanged: {
            console.log("loop changed")
        }

        onStopped:  {
            console.log("animation stopped")
            from= Screen.width + Math.random() * 4000
            start();
        }
    }
}
