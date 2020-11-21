import QtQuick 2.15 // 2
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import Qt3D.Core 2.0
import QtMultimedia 5.3
import QtGraphicalEffects 1.12
import QtQuick.LocalStorage 2.15
import "script.js" as Code

Item {
    id: _leftview
    width: root.width * 0.60
    height: root.height * 1
    property string main_: "MANAGEMENT DES EMPLOYES"

    // =========================employe==========================================================

    Employe {
        y: 100
        x: 50
        id: user

        visible: false
        headerModel: [
            {text: "Noms", width: 2/7},
            {text: "Téléphone", width: 1/7},
            {text: "Naissance", width: 1/7},
            {text: "Ville", width: 1/7},
            {text: "c.n.i", width: 1/7},
            {text: "Salaire fixe", width: 1/7},
        ]

        dataModel: {
            Code.fillEmployes();
        }

        onClicked: print('onClicked', row, JSON.stringify(rowData))
    }

    // =========================bareme==========================================================
    Bareme {
        id: bareme
        y: 100
        x: 50

        visible: false
        headerModel: [
            {text: "Operation", width: 5/7},
            {text: "Valeur unitaire", width: 2/7},
        ]

        dataModel: {
            Code.fillBaremes();
        }

//            [
//            ['COUPE NGOUMOU',  '30'],
//            ['COUPE BAMENDA',  '30'],
//            ['COUPE EKOPTENTE',  '50'],
//            ['COUPE AKONO',  '50'],
//            ['RABATTAGE',  '100'],
//        ]
        onClicked: print('onClicked', row, JSON.stringify(rowData))
    }

    Pointage {
        id: pointage
        y: 100
        x: 50

        visible: false
        headerModel: [
            {text: "N°", width: 0.5/7},
            {text: "Date", width: 1/7},
            {text: "Opérations", width: 2/7},
            {text: "Qté", width: 0.5/7},
            {text: "P.U", width: 0.5/7},
            {text: "Montant", width: 1/7},
            {text: "Observation", width: 1.5/7},
        ]

        dataModel: {
            if(pointage.state_form) {
                print("modification")
//                return Code.fillPointages()
            } else {
                print("visualisation")
                return Code.fillPointages()
            }
        }

          /*[
            ['1',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['2',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['3',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['4',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['5',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
            ['6',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['7',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['8',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['9',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['10',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
            ['11',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['12',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['13',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['14',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['15',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
            ['16',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['17',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['18',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['19',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['20',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
            ['21',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['22',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['23',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['24',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['25',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
            ['26',    '2020-11-04', 'COUPE NGOUMOU', '4', '30', '120', ""],
            ['27',    '656502714', 'COUPE BAMENDA', '10', '30', '300', ""],
            ['28',    '656502714', 'COUPE BAMENDA', '50', '30', '1500', ""],
            ['29',    '656502714', 'COUPE EKOPTENTE', '40', '50', '2000', ""],
            ['30',    '656502714', 'COUPE EKOPTENTE', '20', '50', '1000', ""],
        ]*/
        onClicked: print('onClicked', row, JSON.stringify(rowData))

    }
    Recap {
        id: recap
        y: 100
        x: 50

        visible: false
        headerModel: [
            {text: "N°", width: 0.5/10},
            {text: "Noms", width: 2/10},
            {text: "Salaire F.", width: 1/10},
            {text: "Salaire V.", width: 1/10},
            {text: "Salaire", width: 1/10},
            {text: "Avance", width: 1/10},
            {text: "Autre R", width: 1/10},
            {text: "Total R", width: 1/10},
            {text: "Net à payer", width: 1/10},
//            {text: "Obs", width: 0.5/10},
        ]

        dataModel: [
            ['1',    'Jean-Claude', '35800', '0', '0', '0', "250", "250", "35550"],
            ['2',    'Marie-Claude', '45000', '0', '0', '0', "250", "250", "44750"],
            ['3',    'Jean-Claude', '35800', '0', '0', '0', "250", "250", "35550"],
            ['4',    'Marie-Claude', '45000', '0', '0', '0', "250", "250", "44750"],
            ['5',    'Jean-Claude', '35800', '0', '0', '0', "250", "250", "35550"],
            ['6',    'Marie-Claude', '45000', '0', '0', '0', "250", "250", "44750"],
            ['7',    'Jean-Claude', '35800', '0', '0', '0', "250", "250", "35550"],
            ['8',    'Marie-Claude', '45000', '0', '0', '0', "250", "250", "44750"],


        ]
        onClicked: print('onClicked', row, JSON.stringify(rowData))

    }

    Right {
        visible: true
    }


}
