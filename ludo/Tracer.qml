import QtQuick 2.0

Item {
    property int cellWidth: 63
    property int cellHeight: 63
    property int clickIndex: 0
    Timer {
        id: tracerTimer
        interval: 200
        repeat: true
        onTriggered: {
            clickIndex = (clickIndex+1)%72;
        }
    }

    Rectangle {
        id:tracer
        width: cellWidth
        height: cellHeight
        x: mapper.getX(clickIndex)
        y: mapper.getY(clickIndex)
        color: "pink"
        radius: width
        MouseArea{
            anchors.fill: parent
            onClicked: {
                tracerTimer.start();
            }
        }
    }

}
