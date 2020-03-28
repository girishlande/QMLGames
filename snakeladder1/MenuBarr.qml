import QtQuick 2.0
import QtQuick.Controls 2.4

MenuBar {
    id: root
    signal editPlayers();

    Menu {
        title: "Game"
        MenuItem { text: "New..." }
        MenuSeparator { }
        MenuItem {
            text: "Close"
            onTriggered: {
                Qt.quit()
            }
        }
    }

    Menu {
        title: "Players"
        MenuItem {
            text: "Edit Players"
            onTriggered: {
                root.editPlayers();
            }
        }
    }

    Menu {
        title: "About"
        MenuItem { text: "Snake And Ladder" }
    }
}
