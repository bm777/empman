import QtQuick 2.0
import QtQuick.Controls 2.15

Item { // size controlled by width
    id: root_bareme

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 600
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
        radius: 0.01 * root_bareme.width

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
                width: modelData.width * root_bareme.width;  height: header.height

                Text {
                    x: 0.02 * root_bareme.width
                    text: modelData.text
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:  20 //0.06 * root_bareme.width
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
            width: root_bareme.width;  height: header.height
            opacity: !mouseArea.pressed? 1: 0.3 // pressed state

            property int     row:     index     // outer index
            property variant rowData: modelData // much faster than listView.model[row]

            Row {

                anchors.fill: parent

                Repeater { // index is column
                    model: rowData // headerModel.length

                    delegate: Item { // cell
                        width: headerModel[index].width * root_bareme.width;  height: header.height

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

                onClicked:  root_bareme.clicked(row, rowData)
            }
        }
        Rectangle {
            width: root_bareme.width; height: root_bareme.height
            color: "transparent"
            border.color: "#780000ff"
        }

        ScrollBar{}
//        ScrollBar{}

    }
    // ========================operation=================================================
    TextField {
        id: input_operation
        placeholderText: "Nom de l'opération"
        x: 0
        y: root_bareme.height
        background: Rectangle {
             implicitWidth: header.width * 5 / 7
             implicitHeight: 40
             radius: 3
             color: input_operation.enabled ? "transparent" : "#780000ff"
             border.color: input_operation.enabled ? "#780000ff" : "transparent"
        }
    }

    // ========================valeur====================================================
    TextField {
        id: input_val
        placeholderText: "Valeur Unitaire"
        x: input_operation.width
        y: root_bareme.height
        background: Rectangle {
             implicitWidth: header.width * 2 / 7
             implicitHeight: 40
             radius: 3
             color: input_val.enabled ? "transparent" : "#780000ff"
             border.color: input_val.enabled ? "#780000ff" : "transparent"
        }
    }



    // ============================ComboBox=================================================
    ComboBox {
        id: combo
        x: input_val.x  - 180//+ input_salaire.width
        y: root_bareme.height + input_val.height * 5 / 3
        model: ["Créer", "Mettre à jour", "Supprimer"]



    }

    // ============================confirmer=================================================
    Button {
        id: confirmer
        x: combo.x  + 200//+ input_salaire.width
        y: root_bareme.height + input_val.height * 5 / 3 + 3
        text: "Confirmer"
        contentItem: Text {
            text: confirmer.text
            color: confirmer.down ? "#17a81a" : "2c2c54"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
            font.pointSize: 15
        }

        background: Rectangle {
            color: "white"
            border.color: "#780000ff"
            width: parent.width + 10
            height: parent.height
            radius: 4
        }
    }
}
