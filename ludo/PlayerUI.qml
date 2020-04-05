import QtQuick 2.0

Rectangle {
    id: root
    color: "transparent"
    width: 190
    height: 190
    property int psize: root.width/3
    property color col: "red"
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
