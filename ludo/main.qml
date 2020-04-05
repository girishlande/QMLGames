import QtQuick 2.12
import QtQuick.Window 2.12

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
        onEmitValue: {
            console.log("User rolled Cube:" + value)
        }
    }
}
