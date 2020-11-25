import QtQuick 2.0
import QtQuick.Controls 2.15

Item { // size controlled by width
    id: root_recap

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]
    property string string_mois: {
        return combo_month.textAt(combo_month.currentIndex)
    }
    property string string_annee: {
        return combo_year.textAt(combo_year.currentIndex)
    }

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.8;  height: 600
    property real ratio: Math.sqrt(width * width + height * height)
//    Rectangle {
//        color: "red"
//        width: root.width * 0.65
////        x: root.width * 0.1
//        height: root.height
//    }
    // ===========================================================
    Text {
        id: recap_text
        text: "FICHE DE RECAPITULATIF SALAIRE MOIS DE :"
        y: - 80
        x: root_recap.width * 0.2
        color: "#880000ff"
        font.pointSize: root_recap.width * 0.023
    }


    // ==========
    Text {
        id: month
        text: ""
        y: - 80
        x: root_recap.width * 0.81
        color: "#880000ff"
        font.pointSize: root_recap.width * 0.023
    }
    ComboBox {
        id: combo_month
        x: month.x + month.width  + 10//+ input_salaire.width
        y: - 80
        width: 100
        model: ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
        background: Rectangle{
            color: "transparent"
        }

    }
    ComboBox {
        id: combo_year
        x: combo_month.x + combo_month.width  + 10//+ input_salaire.width
        y: month.y
        width: 100
        model: ["2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030", "2031"]
        background: Rectangle{
            color: "transparent"
        }


    }

    // ===========================================================

    Rectangle {
        id: header
//        x: root.width * 0.1
        width: parent.width;  height: 50
        color: '#6c5ce7'
        radius: 0.01 * root_recap.width

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
                width: modelData.width * root_recap.width;  height: header.height

                Text {
                    x: 0.02 * root_recap.width
                    text: modelData.text
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:  20 //0.06 * root_recap.width
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
            width: root_recap.width;  height: header.height
            opacity: !mouseArea.pressed? 1: 0.3 // pressed state

            property int     row:     index     // outer index
            property variant rowData: modelData // much faster than listView.model[row]

            Row {

                anchors.fill: parent

                Repeater { // index is column
                    model: rowData // headerModel.length

                    delegate: Item { // cell
                        width: headerModel[index].width * root_recap.width;  height: header.height

                        Text {
                            x: 0.02 * root_recap.width
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

                onClicked:  {
                    root_recap.clicked(row, rowData)



                }
            }
        }

        ScrollBar{}
//        ScrollBar{}

    }
    Rectangle {
        width: root_recap.width; height: root_recap.height - 50
        y: 50
        color: "transparent"
        border.color: "#780000ff"
    }
     // ============================variable fixe===================
    Text {
        id: text_fixe
        text: "250000"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.26
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_variable
        text: "2100"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.37
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_salaire
        text: "2100"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.465
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_avance
        text: "2100"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.565
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_retenue
        text: "250"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.665
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_total_retenue
        text: "21000"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.765
        font.pointSize: root_recap.width * 0.015
    }
    Text {
        id: text_net
        text: "210000"
        color: "black"
        y: root_recap.height + 50
        x: header.width * 0.865
        font.pointSize: root_recap.width * 0.015
    }

    // ============================variable fixe====================================================================================



    Rectangle {
        anchors.fill: text_fixe
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_variable
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_salaire
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_avance
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_retenue
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_total_retenue
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: text_net
        color: "#505f27cd"
        radius: 3
    }

}
