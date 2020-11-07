import QtQuick 2.15

Item {
    property string state_home: "OutMouse"
    property string state_h: ""
    property string state_camera: "OutMouse"
    property string state_c: ""
    property string state_person: "OutMouse"
    property string state_p: ""
    property string state_stat: "OutMouse"
    property string state_s: ""

    property string string_menu1: "Employés"
    property string string_source1: "file:/home/bm7/eyeloop/images/dashboard.png"

    property string string_menu2: "Barêmes"
    property string string_source2: "file:/home/bm7/eyeloop/images/camera.png"

    property string string_menu3: "Pointage"
    property string string_source3: "file:/home/bm7/eyeloop/images/person.png"

    property string string_menu4: "Statistic"
    property string string_source4: "file:/home/bm7/eyeloop/images/stat.png"

//    property type name: value
    Rectangle {
        id: _system_right
        width: root.width * (1 - 0.87)
        height: root.height
        color: "#88192a56"
        x: root.width * 0.87
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#880000ff"}
            GradientStop { position: 0.5; color: "#88192a56"}
            //GradientStop { position: 0.8; color: "#88192a56"}
            GradientStop { position: 1.0; color: "#88000000"}
        }
    }

    Item {
        x: _system_right.x +100
        y: -5
//        visible: false
        Image {
            scale: 0.5
            source: "../images/shutdown.png"
        }

    }
//    Rectangle {
//        width: root.width * 1 //(1 - 0.87)
//        height: 2
//        color: "#95afc0"
//        radius: 10
//        y: _system_right.height * 0.08
//        x: 0 //root.width * 0.87
//    }

    // ===========================[ 1 ]========================================
    Item {

        id: right_dahboard
        x: _system_right.x - 50
        y: 50                              // here can be changed
        width: _system_right.width
        height: 100
        // =============================
        Rectangle {
            id: menu_dashboard
            color: {

                if((state_home === "OutMouse" ) && (state_h === "")){
                    return "transparent"
                } else if(state_home === "InMouse"){
                    return "#6c5ce7"
                } else if(state_h === "Clicked") {
                    return "#806c5ce7"
                }
            }

            width: root.width * (1 - 0.87)
            height: 100
            y: 70
            x: 50
            MouseArea {
                anchors.fill: menu_dashboard
                hoverEnabled: true
                onEntered:{
                    state_home = "InMouse";
                }
                onClicked: {
                    state_h = "Clicked"
                    state_c = ""
                    state_p = ""
                    state_s = ""

                    user.visible = true
                    bareme.visible = false
                }

                onExited: {
                    if(state_home === "OutMouse") {
                        state_home = "InMouse"
                    }
                    if(state_home !== "OutMouse") {
                        state_home = "OutMouse"
//                        menu_dashboard.color = "transparent"
                    }
                }
            }
        }
        // =============================
                Text {
                    id: dashboard_text
                    text: string_menu1
                    color: "white"
                    x: 70
                    y: 105
                    font.pointSize: 20

                }
    }
    // ========================================================================
    // ===========================[ 2 ]========================================
    Item {

        id: right_camera
        x: _system_right.x - 50
        y: 150                              // here can be changed
        width: _system_right.width
        height: 100
        // =============================
        Rectangle {
            id: menu_camera
            color: {

                if((state_camera === "OutMouse" ) && (state_c === "")){
                    return "transparent"
                } else if(state_camera === "InMouse"){
                    return "#6c5ce7"
                } else if(state_c === "Clicked") {
                    return "#806c5ce7"
                }
            }
            width: root.width * (1 - 0.87)
            height: 100
            y: 70
            x: 50
            MouseArea {
                anchors.fill: menu_camera
                hoverEnabled: true
                onEntered:{
                    state_camera = "InMouse";
                }
                onClicked: {
                    state_h = ""
                    state_c = "Clicked"
                    state_p = ""
                    state_s = ""

                    user.visible = false
                    bareme.visible = true
                }

                onExited: {
                    if(state_camera === "OutMouse") {
                        state_camera = "InMouse"
                    }
                    if(state_camera !== "OutMouse") {
                        state_camera = "OutMouse"
                    }
                }
            }
        }
        // =============================
                Text {
                    id: camera_text
                    text: string_menu2
                    color: "white"
                    x: 70
                    y: 105
                    font.pointSize: 20

                }
    }
    // ========================================================================
    // ===========================[ 3 ]========================================
    Item {

        id: right_person                                                //
        x: _system_right.x - 50
        y: 250                              // here can be changed
        width: _system_right.width
        height: 100
        // =============================
        Rectangle {
            id: menu_person                                             //
            color: {

                if((state_person === "OutMouse" ) && (state_p === "")){
                    return "transparent"
                } else if(state_person === "InMouse"){
                    return "#6c5ce7"
                } else if(state_p === "Clicked") {
                    return "#806c5ce7"
                }
            }
            width: root.width * (1 - 0.87)
            height: 100
            y: 70
            x: 50
            MouseArea {
                anchors.fill: menu_person                               //
                hoverEnabled: true
                onEntered: {
                    state_person = "InMouse";                           //
                }
                onClicked: {
                    state_h = ""
                    state_c = ""
                    state_p = "Clicked"
                    state_s = ""

                    user.visible = false
                    bareme.visible = false
                }

                onExited: {
                    if(state_person === "OutMouse") {                   //
                        state_person = "InMouse"                        //
                    }
                    if(state_person !== "OutMouse") {                   //
                        state_person = "OutMouse"                       //
                    }
                }
            }
        }
        // =============================
                Text {
                    id: person_text
                    text: string_menu3                                  //
                    color: "white"
                    x: 70
                    y: 105
                    font.pointSize: 20

                }
    }
    // ========================================================================
    // ===========================[ 4 ]========================================
    Item {

        id: right_stat                                               //
        x: _system_right.x - 50
        y: 350                              // here can be changed
        width: _system_right.width
        height: 100
        // =============================
        Rectangle {
            id: menu_stat                                             //
            color: {

                if((state_stat === "OutMouse" ) && (state_s === "")){
                    return "transparent"
                } else if(state_stat === "InMouse"){
                    return "#6c5ce7"
                } else if(state_s === "Clicked") {
                    return "#806c5ce7"
                }
            }
            width: root.width * (1 - 0.87)
            height: 100
            y: 70
            x: 50
            MouseArea {
                anchors.fill: menu_stat                               //
                hoverEnabled: true
                onEntered: {
                    state_stat = "InMouse";                           //
                }
                onClicked: {
                    state_h = ""
                    state_c = ""
                    state_p = ""
                    state_s = "Clicked"

                    user.visible = false
                    bareme.visible = false
                }

                onExited: {
                    if(state_stat === "OutMouse") {                   //
                        state_stat = "InMouse"                        //
                    }
                    if(state_stat !== "OutMouse") {                   //
                        state_stat = "OutMouse"                       //
                    }
                }
            }
        }
        // =============================
                Text {
                    id: stat_text
                    text: string_menu4                                  //
                    color: "white"
                    x: 70
                    y: 105
                    font.pointSize: 20

                }
    }
    // ========================================================================


}
