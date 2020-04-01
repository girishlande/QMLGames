import QtQuick 2.0

Item {
    id: root
    property int playerTurn: 0
    property ListModel players

    signal positionUpdated();

    function movePosition(pos) {
        playersRepeater.itemAt(playerTurn).advancePosition(pos);
        players.get(playerTurn).mposition = playersRepeater.itemAt(playerTurn).pos;
        if (players.get(playerTurn).mposition>=100) {
            players.remove(playerTurn);
            positionUpdated();
        }

        root.playerTurn++;
        root.playerTurn = root.playerTurn % players.count;
    }

    Repeater {
        id:playersRepeater
        model: players
        delegate: Player {
            col: mcolor
            pos: mposition
            playerphoto: photo

            onPositionUpdated: {
                root.positionUpdated();
            }

        }
    }

}
