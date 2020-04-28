import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.4

ApplicationWindow {
    id:root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Snake and Ladder")

    menuBar: MenuBarr {
        id: menubar
        onEditPlayers: {
            playerDialog.open();
        }
    }

    Board {
        id: board
    }

    PlayerModel {
        id: playerModel
    }

    Players {
        id: players
        players: playerModel
        onPositionUpdated: {
            scoreBoard.playerTurn = players.playerTurn
        }
    }

    ScoreBoard {
        id: scoreBoard
        players: playerModel
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 500
    }

    Dice {
        id: dice
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 600
        onOutcome: {
            players.movePosition(value);
        }
    }

   PlayersDialog {
       id: playerDialog
       model: playerModel
   }
}
