import QtQuick 2.0
import QtQuick.Controls 2.15
import "script.js" as Code
import QtQuick.LocalStorage 2.15

Item { // size controlled by width
    id: root_point

// public
    property variant headerModel: [ // widths must add to 1

    ]

    property variant dataModel: [

    ]
    property string string_date: ""

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 600
    property real ratio: Math.sqrt(width * width + height * height)
    property bool state_form: checkBox.checked ? true : false

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
        model: {
            print("noms:", Code.fillNoms());
            return Code.fillNoms();
        }

        background: Rectangle{
            color: "transparent"
        }
    }
    CheckBox {
        id: checkBox
        y: - 82
        x: root_point.width * 0.8
        text: "Mode modification"
    }

    // ==========
    Text {
        id: month
        visible: !state_form
        text: "Mois :"
        y: - root_point.width * 0.04
        x: root_point.width - 280
        color: "#880000ff"
        font.pointSize: root_point.width * 0.023
    }
    ComboBox {
        id: combo_month
        visible: !state_form
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
        visible: !state_form
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
        visible: state_form
        id: combo_operation
        x: header.width * 1.016
        y: root_point.height * 0.17
        width: root_point.width * 0.2405 //header.width * 0.2
        model: Code.comboBaremes()
        background: Rectangle{
            color: "transparent"
            border.color: "#780000ff"
            height: 38
        }
    }
    TextField {
        visible: state_form
        id: id_quantite
        placeholderText: "Quantité"
        x: header.width * 1.016
        y: root_point.height * 0.25
        background: Rectangle {
             implicitWidth: root_point.width * 0.2405 //header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_quantite.enabled ? "transparent" : "#780000ff"
             border.color: id_quantite.enabled ? "#780000ff" : "transparent"
        }
    }
    DatePicker {
        id: id_date
        visible: state_form
        x: header.width * 1.016
        y: root_point.height * 0.331
        Component.onCompleted: set(new Date()) // today
            onClicked: {
                root_point.string_date = Qt.formatDate(date, 'M/d/yyyy')
                print('==onClicked', root_point.string_date)
        }
        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border.color: "#780000ff"
        }
    }
    TextField {
        visible: state_form
        id: id_observation
        placeholderText: "Observation"
        x: header.width * 1.016
        y: root_point.height * 0.512
        background: Rectangle {
             implicitWidth: root_point.width * 0.2405 //header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_observation.enabled ? "transparent" : "#780000ff"
             border.color: id_observation.enabled ? "#780000ff" : "transparent"
        }
    }
    Rectangle {
        visible: state_form
        id: confirmer_point
        x: header.width * 1.016
        y: root_point.height * 0.59
        color: "#380000ff"
        border.color: "#780000ff"
        width: root_point.width * 0.2405 //parent.width + 10
        height: 40
        radius: 4

        Text {
            id: inside_txt
            text: "Pointer"
            anchors.centerIn: confirmer_point
            elide: Text.ElideRight
            font.pointSize: 15
        }

        MouseArea {
            anchors.fill: confirmer_point
            onClicked: {
                var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);


                if(state_form) {
                    var tmp = []
                    try {
                        db.transaction(function (tx) {
                            tx.executeSql('CREATE TABLE IF NOT EXISTS pointages (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                                                fk_employe INTEGER,
                                                                                jour DATE,
                                                                                fk_operation INTEGER,
                                                                                quantite INTEGER,
                                                                                prix INTEGER,
                                                                                observation TEXT,
                                                                                FOREIGN KEY (fk_employe) REFERENCES employes(id),
                                                                                FOREIGN KEY (fk_operation) REFERENCES baremes(id))');

                            var data_employe = Code.employe_to_id(combo_name.textAt(combo_name.currentIndex))
                            var data_bareme = Code.bareme_to_id(combo_operation.textAt(combo_operation.currentIndex))
                            var data_prix = Code.price_from_bareme(data_bareme)
                            tmp = [data_employe, string_date, data_bareme, id_quantite.text, data_prix, id_observation.text]
                            tx.executeSql('INSERT INTO pointages (fk_employe, jour, fk_operation, quantite, prix, observation)
                                           VALUES (?,?,?,?,?,?)', tmp);
                            print("creating element into table pointage")
                        })
                    } catch (err) {
                        console.log("Error creating table in database: " + err)
                    };
                    pointage.dataModel = Code.fillPointages();
                    print("==", tmp)
                } // ================

            }
            onExited: confirmer_point.color = "#380000ff"
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
