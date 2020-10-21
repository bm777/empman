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

    Rectangle {
            id: _system_left
            width: root.width * 0.87
            height: root.height
            color: "white"
            x: 0

        }
    Item {
        Rectangle {
            width: root.width * 0.87
            height: root.height * 0.08
            color: "#880000ff"

            Text {
                id: name
                text: main_
                anchors.centerIn: parent
                color: "white"
                font.pointSize: 18
            }

            Rectangle {

            }
        }

    }





}
