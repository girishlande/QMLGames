import QtQuick 2.0

Item {
    property int blobRadius: 40

    Grid {
        anchors.fill: parent
        rows: 10
        columns: 10
        Repeater {
            model: 100
            Rectangle {
               width: 100
               height: 100
               color: "transparent"
                Rectangle {
                    width: blobRadius
                    height: blobRadius
                    anchors.centerIn: parent
                    color: "black"
                }
            }
        }
    }


}
