import QtQuick 2.0

Item { // size controlled by width
    id: root_user

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 200
//    Rectangle {
//        color: "red"
//        width: root.width * 0.65
////        x: root.width * 0.1
//        height: root.height
//    }

    Rectangle {
        id: header
//        x: root.width * 0.1
        width: parent.width;  height: 50
        color: '#6c5ce7'
        radius: 0.01 * root_user.width

        Rectangle { // half height to cover bottom rounded corners
            width: parent.width;  height: 0.5 * parent.height
            color: parent.color
            anchors.bottom: parent.bottom
        }
//        Rectangle { // half height to cover bottom rounded corners
//            width: parent.width * 0.5;  height: parent.height
//            color: parent.color
//            anchors.right: parent.right
//        }

        ListView { // header
            anchors.fill: parent
            orientation: ListView.Horizontal
            interactive: false

            model: headerModel

            delegate: Item { // cell
                width: modelData.width * root_user.width;  height: header.height

                Text {
                    x: 0.02 * root_user.width
                    text: modelData.text
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:  20 //0.06 * root_user.width
                    color: 'white'
                }
            }
        }
    }

    ListView { // data
        anchors{fill: parent;  topMargin: header.height}
        interactive: contentHeight > height
        clip: true
        model: dataModel

        delegate: Item { // row
            width: root_user.width;  height: header.height
            opacity: !mouseArea.pressed? 1: 0.3 // pressed state

            property int     row:     index     // outer index
            property variant rowData: modelData // much faster than listView.model[row]

            Row {

                anchors.fill: parent

                Repeater { // index is column
                    model: rowData // headerModel.length

                    delegate: Item { // cell
                        width: headerModel[index].width * root_user.width;  height: header.height

                        Text {
                            x: 15
//                            x: root.width * 0.11
                            text: modelData
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 20
                        }
                    }
                }
            }

            MouseArea {
                id: mouseArea

                anchors.fill: parent

                onClicked:  root_user.clicked(row, rowData)
            }
        }
        Rectangle {
            width: root_user.width; height: root_user.height
            color: "transparent"
            border.color: "#780000ff"
        }

        ScrollBar{}
//        ScrollBar{}
    }
    TextInput {

    }
}
