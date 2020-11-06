import QtQuick 2.15 // 2
import QtQuick.Window 2.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import Qt3D.Core 2.0
import QtMultimedia 5.3
import QtGraphicalEffects 1.12

Item {
    id: _leftview
    width: root.width * 0.60
    height: root.height * 1
    property string main_: "MANAGEMENT DES EMPLOYES"

// =========================employe==========================================================

    Employe {
        y: 50
        id: user

        visible: true
        headerModel: [
            {text: "Noms", width: 2/7},
            {text: "Téléphone", width: 1/7},
            {text: "Naissance", width: 1/7},
            {text: "Ville", width: 1/7},
            {text: "c.n.i", width: 1/7},
            {text: "Salaire fixe", width: 1/7},
        ]

        dataModel: [
            ['Jean-Claude',    '656502714', '2000', 'Yde', '87654321', '50000'],
            ['Jean-Claude',    '656502714', '2000', 'Yde', '87654321', '50000'],
            ['Jean-Claude',    '656502714', '2000', 'Yde', '87654321', '50000'],
            ['Jean-Claude',    '656502714', '2000', 'Yde', '87654321', '50000'],
            ['Jean-Claude',    '656502714', '2000', 'Yde', '87654321', '50000'],
        ]
        onClicked: print('onClicked', row, JSON.stringify(rowData))
    }


}
