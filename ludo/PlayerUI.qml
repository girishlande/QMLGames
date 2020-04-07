import QtQuick 2.0

Rectangle {
    id: root

    property bool active: false
    property int psize: root.width/3
    property color col: "red"

    color: "transparent"
    width: 190
    height: 190

    Image {
        id: chakraImage
        source: "qrc:/resources/images/chakra.png"
        anchors.centerIn: parent
        width: 40
        height: 40
        fillMode: Image.Stretch
        visible: root.active
    }
    Timer {
        running: root.active
        repeat: true
        interval: 20
        onTriggered: {
            chakraImage.rotation = (chakraImage.rotation + 10 ) %360
        }
    }

    PieceUI {
        size:root.psize
        x:root.psize
        y:0
        innerColor: root.col
    }
    PieceUI {
        size:root.psize
        x:0
        y:root.psize
        innerColor: root.col
    }
    PieceUI {
        size:root.psize
        x:root.psize*2
        y:root.psize
        innerColor: root.col
    }
    PieceUI {
        size:root.psize
        x:root.psize
        y:root.psize*2
        innerColor: root.col
    }
}
