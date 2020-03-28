import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

Dialog {
    id: dialog
    title: "Players"
    standardButtons: Dialog.Ok | Dialog.Cancel

    property ListModel model
    property color selectedColor: "red"

    width: 400
    height: 400

    Button {
        id: addButton
        text: "Add Player"
        x: parent.width/2 - width/2
        onClicked: {
            dialog.model.append({name:"test", mcolor:"red", mposition: 1});
        }
    }

    ListView {
        anchors.top: addButton.bottom
        anchors.topMargin: 50

        height: 250
        width: parent.width/2
        model: dialog.model
        delegate: Row {
                TextField {
                    text: model.name
                    onTextChanged: {
                        model.name = text;
                    }
                }
                Rectangle {
                    id: pickerColor
                    width: 40
                    height: 40
                    radius: 20
                    color: model.mcolor

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            colorDialog.playerIndex=index;
                            colorDialog.open();
                        }
                    }

                    ColorDialog {
                        id: colorDialog

                        property int playerIndex: 0
                        title: "Please choose a color"
                        onAccepted: {
                            console.log("You chose: " + colorDialog.color);
                            let c = colorDialog.color;
                            model.mcolor = c.toString();
                        }
                    }

                }
        }
    }


    onAccepted: console.log("Ok clicked")
    onRejected: console.log("Cancel clicked")
}
