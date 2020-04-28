import QtQuick 2.0

Rectangle {
    width: 200
    height: 100
    color: "brown"

    Image {
        id: brickImage
        source: "qrc:/images/fullbrick.png"
        anchors.fill: parent
    }
}
