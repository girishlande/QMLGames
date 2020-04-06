import QtQuick 2.12
import QtQuick.Window 2.12
import Player 1.0

Window {
    visible: true
    width: 1000
    height: 1000
    title: qsTr("Ludo Game by Girish")


    Image {
        id: background
        source: "qrc:/resources/images/ludo.png"
        anchors.fill: parent
        fillMode: Image.Stretch
    }

    Dice {
        id: dice
        property int diceValue: 0
        onEmitValue: {
            console.log("User rolled Cube:" + value)
            dice.diceValue = value;
        }
    }

    PlayerUI {
        id: player1
        x:122
        y:124
        col:"lightgreen"
    }
    PlayerUI {
        id: player2
        x:686
        y:124
        col:"red"
    }
    PlayerUI {
        id: player3
        x:686
        y:686
        col:"blue"
    }
    PlayerUI {
        id: player4
        x:124
        y:686
        col:"yellow"
    }

    Repeater {
        model: pieceModel
        delegate: PieceUI {
            innerColor: model.col
            x: model.xpos
            y: model.ypos
            innerText: "" + model.name

            onClicked: {
                console.log("player clicked");
                pieceModel.advancePiece(index,dice.diceValue);
            }
        }
    }

}
