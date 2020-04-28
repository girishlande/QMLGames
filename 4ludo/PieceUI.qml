import QtQuick 2.0

Rectangle {
    id: root

    property int size: 50
    property int innerSize: size/2
    property alias innerColor: innerRect.color
    property int offset: 10
    property alias innerText: name.text
    property alias active: pieceUiMouseArea.visible

    width: root.size
    height: root.size
    color: "transparent"

    signal clicked();

    Rectangle {
        anchors.centerIn: parent
        width: root.size - root.offset
        height: root.size - root.offset
        radius: root.size - root.offset
        color: "black"
        Rectangle {
            id:innerRect
            anchors.centerIn: parent
            width: root.innerSize
            height: root.innerSize
            radius: root.innerSize
            Text {
                id: name
                text: qsTr("T")
                anchors.centerIn: parent
            }
        }
        MouseArea {
            id: pieceUiMouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked();
            }
        }
    }
}
