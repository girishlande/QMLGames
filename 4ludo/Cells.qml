import QtQuick 2.0

Item {
    property int cellWidth: 63
    property int cellHeight: 63
    property int clickIndex: 0

    Repeater {
        id: iRepeat
        model: 3
        Repeater {
            id:jRepeat
            model: 15
            property int iIndex: index
            Rectangle {
                id: cell1
                x:28+index*cellWidth
                y:405+iIndex*cellHeight
                border.color: "pink"
                width: cellWidth
                height: cellHeight
                color: "black"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("{"+cell1.x+","+cell1.y+"},");
                        console.log("G:"+mapper.getX(clickIndex)+","+mapper.getY(clickIndex));
                        clickIndex++;
                    }
                }
            }
        }
    }

    Repeater {
        model: 15
        Repeater {
            model: 3
            property int iIndex: index
            Rectangle {
                id: cell
                x:405+index*cellWidth
                y:28+iIndex*cellHeight
                border.color: "pink"
                width: cellWidth
                height: cellHeight
                color: "black"

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("{"+cell.x+","+cell.y+"},");
                        console.log("G:"+mapper.getX(clickIndex)+","+mapper.getY(clickIndex));
                        clickIndex++;
                    }
                }
            }
        }
    }

}
