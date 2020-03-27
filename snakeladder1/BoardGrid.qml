import QtQuick 2.0

Repeater {
    model: 100
    delegate: Rectangle {
        width: 100
        height: 100
        x: mapper.getX(index+1)
        y: mapper.getY(index+1)
        opacity: 0.5
        Text {
            text:(index+1)
            anchors.centerIn: parent
            font.pointSize: 20
        }
    }
}
