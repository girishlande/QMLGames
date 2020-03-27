import QtQuick 2.0

Item {

    ListModel {
        id:ladders
        ListElement { start:3; end:20; }
        ListElement { start:6; end:14; }
        ListElement { start:11; end:28; }
        ListElement { start:15; end:34; }
        ListElement { start:17; end:74; }
        ListElement { start:22; end:37; }
        ListElement { start:38; end:59; }
        ListElement { start:49; end:67; }
        ListElement { start:57; end:76; }
        ListElement { start:61; end:78; }
        ListElement { start:73; end:86; }
        ListElement { start:81; end:98; }
        ListElement { start:88; end:91; }
    }

    function checkLadder(position) {
        for(let i=0;i<ladders.count;i++) {
            let s = ladders.get(i).start;
            if (s===position) {
                position = ladders.get(i).end;
            }
        }
        return position;
    }
}
