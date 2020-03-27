import QtQuick 2.0

Rectangle {
    id:background
    anchors.fill: parent

    Row {
        anchors.fill: parent
        spacing: 0
        Rectangle {
            id:leftRect
            width: 1000
            height: 1000
            color: "green"
            border.color: "black"
            border.width: 4
            Image {
                id:boardImg
                source: "qrc:/images/board.jpg"
                opacity: 0.8
            }
        }
        Rectangle {
            id:rightRect
            height: parent.height
            width: parent.width - parent.spacing - leftRect.width
            color: "#22b14d"
        }
    }
}
