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
    property bool state_retenu: false
    property bool state_avance: false
    property string _id: ""

    signal clicked(int row, variant rowData);  //onClicked: print('onClicked', row, JSON.stringify(rowData))

// private
    width: root.width * 0.65;  height: 600
    property real ratio: Math.sqrt(width * width + height * height)
    property bool state_form: checkBox.checked ? true : false
    property string string_name: {
//        Code.fillPointages(combo_name.textAt(combo_name.currentIndex))
        return combo_name.textAt(combo_name.currentIndex)
    }

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
            if(checkBox.checked){
                pointage.dataModel = Code.fillPointages(combo_name.currentText)
            }else{
                pointage.dataModel = Code.fillVisualisation(string_name, combo_month.currentText, combo_year.currentText)
            }

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
//        onCurrentTextChanged: {
//            pointage.dataModel = Code.fillVisualisation(string_name, combo_month.currentText, combo_year.currentText)
//        }

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

//        onCurrentTextChanged: {
//            Code.fillVisualisation(string_name, combo_month.currentText, combo_year.currentText)
//        }
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
                    var index = combo_operation.currentIndex
                    _id = rowData[0]
                    combo_operation.currentIndex = combo_operation.find(rowData[2])
                    id_quantite.text = rowData[3]
                    id_observation.text = rowData[6]
                    id_date.selectedDate = new Date(rowData[1])
                    inside_txt.text = "Mise à Jour"
                    print(id_date.selectedDate)
                    root_point.clicked(row, rowData)

                }
            }
        }

        ScrollBar{visible: true}
//        ScrollBar{}

    }
    Rectangle {
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
        visible: {
            root_point.string_date = Qt.formatDate(id_date.selectedDate, 'M/d/yyyy')
            return state_form
        }

        x: header.width * 1.016
        y: root_point.height * 0.331
        Component.onCompleted: set(new Date()) // today
            onClicked: {
                root_point.string_date = Qt.formatDate(date, 'M/d/yyyy')
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
        width: root_point.width * 0.15 //parent.width + 10
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
                            var data_prix = Code.price_from_bareme(combo_operation.textAt(combo_operation.currentIndex))
                            tmp = [data_employe[0], string_date, data_bareme[0], id_quantite.text, data_prix[0], id_observation.text]
                            tx.executeSql('INSERT INTO pointages (fk_employe, jour, fk_operation, quantite, prix, observation)
                                           VALUES (?,?,?,?,?,?)', tmp);

                            if(inside_txt.text == "Mise à Jour"){
                                print('inside update')
                                tx.executeSql('UPDATE pointages
                                               SET jour=?, fk_operation=?, quantite=?, observation=?, fk_employe=?
                                               WHERE id=?', [string_date, data_bareme[0], id_quantite.text, id_observation.text, data_employe[0], parseInt(_id)])
                                inside_txt.text = "Pointer"

                            }
                        })
                    } catch (err) {
                        console.log("Error creating table in database: " + err)
                    };

                    pointage.dataModel = Code.fillPointages(string_name);
                    combo_operation.model = Code.comboBaremes()
//                    print("datamodel:", pointage.dataModel)
                } // ================

            }
            onExited: confirmer_point.color = "#380000ff"
        }
    }
    Rectangle {
        visible: state_form
        id: sup_point
        x: header.width * 1.18
        y: root_point.height * 0.59
        color: "#080000ff"
        border.color: "#780000ff"
        width: root_point.width * 0.075 //parent.width + 10
        height: 40
        radius: 4
        Text {
//            id: inside_
            text: "x"
            color: "red"
            anchors.centerIn: sup_point
            elide: Text.ElideRight
            font.pointSize: 25
        }
        MouseArea {
            anchors.fill: sup_point
            onEntered: {
                sup_point.color = "#78ff0000"
            }
            onExited: {
                sup_point.color = "#080000ff"
            }
            onClicked: {
                var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
                try {
                    db.transaction(function (tx) {
                    var data_employe = Code.employe_to_id(combo_name.textAt(combo_name.currentIndex))
                    tx.executeSql('DELETE FROM pointages
                                   WHERE fk_employe=?
                                   AND SUBSTR(mois, 1,2)=?
                                   AND SUBSTR(mois, 7, 10)=?', [id_avance.text, id_retenue.text, data_employe[0],  string_date.slice(0,2), string_date.slice(6,10)]);
                    print("executed:", [id_avance.text, id_retenue.text, data_employe[0]])
                });

                } catch (e) {
                    print('error while deleting pointage tble')
                }
            }
        }
    }

    TextField {
        visible: state_form
        id: id_avance
        placeholderText: "Avance du mois"
        x: header.width * 1.016
        y: root_point.height * 0.77
        background: Rectangle {
             implicitWidth: root_point.width * 0.2405 //header.width * 0.2
             implicitHeight: 40
             radius: 3
             color: id_observation.enabled ? "transparent" : "#780000ff"
             border.color: id_observation.enabled ? "#780000ff" : "transparent"
        }
    }
    TextField {
        visible: state_form
        id: id_retenue

        placeholderText: "Retenue du mois"
        x: header.width * 1.016
        y: root_point.height * 0.84
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
        id: btn_retenu
        x: header.width * 1.016
        y: root_point.height * 0.91
        color: "#380000ff"
        border.color: "#780000ff"
        width: root_point.width * 0.15 //parent.width + 10
        height: 40
        radius: 4
        Text {
            id: content_retenu
            text: "Enreg."
            anchors.centerIn: btn_retenu
            elide: Text.ElideRight
            font.pointSize: 15
        }
        MouseArea {
            anchors.fill: btn_retenu
            onClicked: {
                var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
                var tmp = []
                var months = ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
                var index_month = months.indexOf(combo_month.currentText) + 1
                if (index_month < 10){
                    index_month = "0"+index_month.toString()
                } var test = ""

                try {
                    db.transaction(function (tx) {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS retenues (id INTEGER PRIMARY KEY AUTOINCREMENT,
                                                                            fk_employe INTEGER,
                                                                            mois DATE,
                                                                            avance INTEGER,
                                                                            retenue INTEGER,
                                                                            FOREIGN KEY (fk_employe) REFERENCES employes(id))');

                        var data_employe = Code.employe_to_id(combo_name.textAt(combo_name.currentIndex))[0]
                        var data_bareme = Code.bareme_to_id(combo_operation.textAt(combo_operation.currentIndex))
                        var data_prix = Code.price_from_bareme(combo_operation.textAt(combo_operation.currentIndex))
                        tmp = [data_employe[0], string_date, id_avance.text, id_retenue.text]
                        test = tx.executeSql('SELECT mois
                                              FROM retenues
                                              WHERE SUBSTR(mois, 1, 2)=?
                                              AND SUBSTR(mois, 7, 10)=?
                                              AND fk_employe=?', [string_date.slice(0, 2), string_date.slice(6, 10), data_employe]);

                        if(test.rows.length == 0){
                            print("length:", test.rows.length)
                            tx.executeSql('INSERT INTO retenues (fk_employe, mois, avance, retenue)
                                           VALUES(?,?,?,?)', tmp);
                        } else {

                        }
                    print("tmp", [string_date.slice(0, 2), string_date.slice(6, 10), data_employe])
                    })
                } catch (err) {
                    console.log("Error creating or inserting on retenues table in database: " + err)
                };

            }
        }
    }
    Rectangle {
        visible: state_form
        id: ar
        x: header.width * 1.17
        y: root_point.height * 0.91
        color: "#080000ff"
        border.color: "#780000ff"
        width: root_point.width * 0.085 //parent.width + 10
        height: 40
        radius: 4
        Text {
            id: text_inside_ar
            text: "M.à.J"
            color: "red"
            anchors.centerIn: ar
            elide: Text.ElideRight
            font.pointSize: 18
        }
        MouseArea {
            anchors.fill: ar
            onClicked: {
                var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
                try {
                    db.transaction(function (tx) {
                    var data_employe = Code.employe_to_id(combo_name.textAt(combo_name.currentIndex))
                    tx.executeSql('UPDATE retenues SET avance=?, retenue=?
                                   WHERE fk_employe=?
                                   AND SUBSTR(mois, 1,2)=?
                                   AND SUBSTR(mois, 7, 10)=?', [id_avance.text, id_retenue.text, data_employe[0],  string_date.slice(0,2), string_date.slice(6,10)]);
                    print("executed:", [id_avance.text, id_retenue.text, data_employe[0]])
                });

                } catch (e) {
                    print('error while updating retenues tble')
                }

            }

            onEntered: {
                ar.color = "#78ff0000"
            }
            onExited: {
                ar.color = "#080000ff"
            }
        }
    }

    // =================================================================================================
    Text {
        id: salaire_variable
        text: "Variable :"
        y:  root_point.height * 1.03
//        x: root_point.width * 0.3
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: variable
        text: Code.variable(pointage.dataModel)
        y:  root_point.height * 1.025
        x: root_point.width * 0.18
        color: "black"
        font.pointSize: root_point.width * 0.025
    }
    // ============================variable fixe=================================================

    Text {
        id: salaire_fixe
        text: "Fixe :"
        y:  variable.y + root_point.width * 0.08
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: fixe
        text: Code.salaire_fixe(string_name)[0]
        y:  salaire_fixe.y - 3
        x: root_point.width * 0.18
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================== brute ======================================================
    Text {
        id: salaire_brute
        text: "Brute:"
        y: fixe.y + root_point.width * 0.08
        color: "#800000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: brute
        text: Code.brute(variable.text, fixe.text)
        y: salaire_brute.y -3
        x: root_point.width * 0.18
        font.pointSize: root_point.width * 0.025
    }

    // ============================avance retenue=================================================

    Text {
        id: text_avance
        text: "Avance:"
        y:  salaire_variable.y
        x: root_point.width * 0.5
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: val_avance
        text: "250"
        y:  variable.y
        x: root_point.width * 0.72
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================retenue=========================================

    Text {
        id: retenue
        text: "Autre retenue :"
        y:  salaire_fixe.y
        x: root_point.width * 0.5
        color: "#880000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: total_retenue
        text: "250"
        y:  fixe.y
        x: root_point.width * 0.72
        color: "black"
//        font.bold: true
        font.pointSize: root_point.width * 0.025
    }
    // ============================ total retenu ==================================
    Text {
        id: text_total_retenu
        text: "Total retenue:"
        y: salaire_brute.y
        x: root_point.width * 0.5
        color: "#800000ff"
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: val_total_retenu
        text: Code.brute(total_retenue.text, val_avance.text)
        y: brute.y
        x: root_point.width * 0.72
        font.pointSize: root_point.width * 0.025
    }
    // ============================net a payer======================================

    Text {
        id: net
        text: "Net A Payer :"
        y:  salaire_fixe.y
        x: root_point.width * 0.8
        color: "#880000ff"
        font.underline: true
        font.bold: true
        font.pointSize: root_point.width * 0.02
    }
    Text {
        id: val_net
        text: Code.net(brute.text, val_total_retenu.text)
        y:  fixe.y
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
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            Timer {
                id: timer
                interval: 400
                onTriggered: print("single click")
            }
            onClicked: {
                if(mouse.button == Qt.LeftButton){
                    if(timer.running){
                        print('double clicked')
                        id_avance.text = val_avance.text
                        id_retenue.text = total_retenue.text
//                        inside_txt.text = "Mise à Jour"
                        timer.stop()
                    } else
                        timer.restart()
                }
            }
        }
    }
    Rectangle {
        anchors.fill: val_avance
        color: "#505f27cd"
        radius: 3
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            Timer {
                id: timer2
                interval: 400
                onTriggered: print("single click")
            }
            onClicked: {
                if(mouse.button == Qt.LeftButton){
                    if(timer2.running){
                        print('double clicked')
                        id_avance.text = val_avance.text
                        id_retenue.text = total_retenue.text
                        timer2.stop()
                    } else
                        timer2.restart()
                }
            }
        }
    }
    Rectangle {
        anchors.fill: fixe
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: variable
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: brute
        color: "#505f27cd"
        radius: 3
    }
    Rectangle {
        anchors.fill: val_total_retenu
        color: "#505f27cd"
        radius: 3
    }

}
