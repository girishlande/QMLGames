import QtQuick 2.12
import QtQuick.Window 2.12
import Player 1.0

Window {
    id: root
    visible: true
    width: 1000
    height: 1000
    title: qsTr("Ludo Game by Girish")

    property int playerTurn: 0

    Image {
        id: background
        source: "qrc:/resources/images/ludo.png"
        anchors.fill: parent
        fillMode: Image.Stretch
    }

    Dice {
        id: dice
        value: 2
        onValueChanged: {
            console.log("User rolled Cube:" + value)
            root.playerTurn = (root.playerTurn+1)%4
        }
    }

    PlayerUI {
        id: player1
        x:124
        y:686
        col:"yellow"
        active: root.playerTurn==0
    }
    PlayerUI {
        id: player2
        x:122
        y:124
        col:"lightgreen"
        active: root.playerTurn==1
    }
    PlayerUI {
        id: player3
        x:686
        y:124
        col:"red"
        active: root.playerTurn==2
    }
    PlayerUI {
        id: player4
        x:686
        y:686
        col:"blue"
        active: root.playerTurn==3
    }


    Repeater {
        id: pieceRepeater
        model: pieceModel
        delegate: PieceUI {
            innerColor: model.col
            x: model.xpos
            y: model.ypos
            innerText: "" + model.name
            active: index>=root.playerTurn*4 && index<(root.playerTurn+1)*4
            onClicked: {
                console.log("player clicked");
                moveTransition.target = model;
                moveTransition.from = model.localindex;
                moveTransition.to = model.localindex + dice.value;
                moveTransition.duration = dice.value * 400;
                moveTransition.start();
            }
        }
    }


    NumberAnimation {
        id: moveTransition
        property: "localindex"
        running: false
        easing.type: Easing.InOutQuad
    }
}
