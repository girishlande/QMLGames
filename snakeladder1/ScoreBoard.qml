import QtQuick 2.0

Rectangle {
    id: root

    property ListModel players
    property int playerTurn: 0

    color: "white"
    width: 300
    height: players.count * 50
    radius: 10

    Column {
        anchors.fill: parent
        Repeater {
            model: players
            delegate: Rectangle {
                id: playerRect
                width: root.width
                height: 50
                color: model.mcolor
                Rectangle {
                    x: 10
                    y: playerRect.height/2 - height/2
                    width: 30
                    height: width
                    //radius: width/2
                    color: "black"
                    visible: index===root.playerTurn

                    Image {
                        id: name
                        source: "qrc:/images/icons/rightarrow.jpg"
                        anchors.fill: parent
                    }
                }

                Row {
                    width: parent.width-20
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: "       " + model.name
                        font.pointSize: 20
                    }
                }
            }
        }

    }
}
