import QtQuick 2.0

Item {

    ListModel {
        id:snakes
        ListElement { start:8; end:4; }
        ListElement { start:18; end:1; }
        ListElement { start:26; end:10; }
        ListElement { start:39; end:5; }
        ListElement { start:51; end:6; }
        ListElement { start:54; end:36; }
        ListElement { start:56; end:1; }
        ListElement { start:60; end:23; }
        ListElement { start:75; end:28; }
        ListElement { start:90; end:48; }
        ListElement { start:83; end:45; }
        ListElement { start:85; end:59; }
        ListElement { start:92; end:25; }
        ListElement { start:97; end:87; }
        ListElement { start:99; end:63; }
    }

    function checkSnakeBite(position) {
        for(let i=0;i<snakes.count;i++) {
            let s = snakes.get(i).start;
            if (s===position) {
                position = snakes.get(i).end;
            }
        }
        return position;
    }
}
