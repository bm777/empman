import QtQuick 2.0
import QtQuick.Controls 2.15

Item { // size controlled by width
    id: root_point

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 600
    property real ratio: Math.sqrt(width * width + height * height)
//    Rectangle {
//        color: "red"
//        width: root.width * 0.65
////        x: root.width * 0.1
//        height: root.height
//    }
    // ===========================================================
    Text {
        id: point_text
        text: "FICHE DE POINTAGE INDIVIDUEL"
        y: - 80
        x: root_point.width * 0.3
        color: "#880000ff"
        font.pointSize: root_point.width * 0.023
    }
    Text {
        id: name
        text: "Nom :"
        y: - root_point.width * 0.04
//        x: root_point.width * 0.3
        color: "#880000ff"
        font.pointSize: root_point.width * 0.023
    }
    ComboBox {
        id: combo_name
        x: name.x + name.width  + 30//+ input_salaire.width
        y: name.y
        width: 150
        model: ["Jean-Claude", "Marie-Claude", "Anne-Claude", "Jeanne-Claude"]
        background: Rectangle{
            color: "transparent"
        }


    }
    // ==========
    Text {
        id: month
        text: "Mois :"
        y: - root_point.width * 0.04
        x: root_point.width - 280
        color: "#880000ff"
        font.pointSize: root_point.width * 0.023
    }
    ComboBox {
        id: combo_month
        x: month.x + month.width  + 10//+ input_salaire.width
        y: month.y
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
        radius: 0.01 * root_point.width

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
                width: modelData.width * root_point.width;  height: header.height

                Text {
                    x: 0.02 * root_point.width
                    text: modelData.text
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize:  20 //0.06 * root_point.width
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
//        highlightFollowsCurrentItem: true

        delegate: Item { // row
            width: root_point.width;  height: header.height
            opacity: !mouseArea.pressed? 1: 0.3 // pressed state

            property int     row:     index     // outer index
            property variant rowData: modelData // much faster than listView.model[row]

            Row {

                anchors.fill: parent

                Repeater { // index is column
                    model: rowData // headerModel.length

                    delegate: Item { // cell
                        width: headerModel[index].width * root_point.width;  height: header.height

                        Text {
                            x: 0.02 * root_point.width
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
                    root_point.clicked(row, rowData)


                }
            }
        }

        ScrollBar{visible: true}
//        ScrollBar{}

    }
    Rectangle                                                                                                       {
        width: root_point.width; height: root_point.height - 50
        y: 50
        color: "transparent"
        border.color: "#780000ff"
    }

    // ============================variable fixe====================================================================================
    // ========================cni====================================================
    ComboBox {
        id: combo_operation
        x: header.width * 1.04
        y: root_point.height * 0.17
        width: header.width * 0.2
        model: ["Operation", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
        background: Rectangle{
            color: "transparent"
        }
    }
    TextField {
        id: id_quantite
        placeholderText: "Quantité"
        x: header.width * 1.04
        y: root_point.height * 0.28
        background: Rectangle {
             implicitWidth: header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_quantite.enabled ? "transparent" : "#780000ff"
             border.color: id_quantite.enabled ? "#780000ff" : "transparent"
        }
    }
    TextField {
        id: id_date
        placeholderText: "Date"
        x: header.width * 1.04
        y: root_point.height * 0.39
        background: Rectangle {
             implicitWidth: header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_date.enabled ? "transparent" : "#780000ff"
             border.color: id_date.enabled ? "#780000ff" : "transparent"
        }
    }
    TextField {
        id: id_observation
        placeholderText: "Observation"
        x: header.width * 1.04
        y: root_point.height * 0.50
        background: Rectangle {
             implicitWidth: header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_observation.enabled ? "transparent" : "#780000ff"
             border.color: id_observation.enabled ? "#780000ff" : "transparent"
        }
    }
    Button {
        id: confirmer_point
        x: header.width * 1.13
        y: root_point.height * 0.61
        text: "Pointer"
        contentItem: Text {
            text: confirmer_point.text
            color: confirmer_point.down ? "#17a81a" : "2c2c54"
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

    // =================================================================================================
    Text {
        id: variable_fixe
        text: "Variable fixe :"
        y:  root_point.height * 1.03
//        x: root_point.width * 0.3
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: fixe
        text: "35800"
        y:  root_point.height * 1.025
        x: root_point.width * 0.18
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================variable fixe=================================================

    Text {
        id: salaire_brute
        text: "Salaire brute :"
        y:  fixe.y + root_point.width * 0.08
//        x: root_point.width * 0.3
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: brute
        text: "35800"
        y:  salaire_brute.y - 3
        x: root_point.width * 0.18
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================variable fixe===================================================================================

    Text {
        id: avance
        text: "Avance retenue :"
        y:  variable_fixe.y
        x: root_point.width * 0.5
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: val_avance
        text: "250"
        y:  fixe.y
        x: root_point.width * 0.72
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================variable fixe=========================================

    Text {
        id: retenue
        text: "Total retenue :"
        y:  salaire_brute.y
        x: root_point.width * 0.5
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: total_retenue
        text: "250"
        y:  brute.y
        x: root_point.width * 0.72
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================net a payer===================================================================================

    Text {
        id: net
        text: "Net A Payer :"
        y:  salaire_brute.y
        x: root_point.width * 0.8
        color: "#880000ff"
        font.underline: true
        font.bold: true
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: val_net
        text: "36050"
        y:  brute.y
        x: root_point.width * 0.97
        color: "black"
        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    Rectangle {
        anchors.fill: val_net
        color: "#805f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: total_retenue
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: val_avance
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: brute
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: fixe
        color: "#505f27cd"
        radius: 3
    }

}
