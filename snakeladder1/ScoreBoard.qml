import QtQuick 2.0

Rectangle {
    id: root

    property ListModel players
    property int playerTurn: 0
    property int entryHeight: 60
    property int entryWidth: 300

    color: "white"
    width: root.entryWidth
    height: players.count * entryHeight
    radius: 10

    Column {
        anchors.fill: parent
        spacing: 5
        Repeater {
            model: players
            delegate: Rectangle {
                id: playerRect
                width: root.entryWidth
                height: root.entryHeight
                color: model.mcolor
                radius: 5

                Row {
                    spacing: 10
                    Image {
                        id: name
                        source: "qrc:/images/svg/playbutton.svg"
                        width: root.entryHeight/2
                        height: root.entryHeight/2
                        opacity: index === root.playerTurn ? 1 : 0
                        y: entryHeight/4
                    }
                    Image {
                        id: profilePhoto
                        source: model.photo
                        width: root.entryHeight
                        height: root.entryHeight
                        fillMode: Image.Stretch
                    }
                    Text {
                        text: model.name
                        font.pointSize: 20
                    }
                }
            }
        }

    }
}
