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
            {text: "Ville", width: 1/7},
            {text: "Naissance", width: 1/7},
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
                return Code.fillPointages(pointage.string_name)
            } else {
                return Code.fillPointages(pointage.string_name)
            }
        }

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

        dataModel: {
            return Code.fillStatistic(recap.string_mois, recap.string_annee)

        }

        onClicked: print('onClicked', row, JSON.stringify(rowData))

    }

    Right {
        visible: true
    }


}
