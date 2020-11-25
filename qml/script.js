function getRandom(previousValue) {
    return Math.floor(previousValue + Math.random() * 90) % 360;

}

// ============== onclicked fill =========================================================================

function fillEmployes() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_employe = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT * FROM employes');
            for (var i = 0; i < result.rows.length; i++) {
                list_employe.push([result.rows.item(i).noms, result.rows.item(i).tel, result.rows.item(i).ville, result.rows.item(i).naissance, result.rows.item(i).cni, result.rows.item(i).s_fixe])
               }
        })
    } catch (err) {
        console.log("Error while creating table in database: " + err)
    };
//    print(list_employe)
    return list_employe;
}
// ========================================================================================================
function fillBaremes() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_bareme = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT * FROM baremes');
            for (var i = 0; i < result.rows.length; i++) {
                list_bareme.push([result.rows.item(i).operation, result.rows.item(i).valeur])
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
//    print("====", list_bareme)
    return list_bareme;
}

// ========================================================================================================
function fillNoms() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_noms = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT noms FROM employes');
            for (var i = 0; i < result.rows.length; i++) {
                list_noms.push(result.rows.item(i).noms)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    return list_noms;
}
// ======================================================================================================
function comboBaremes() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_bareme = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT operation FROM baremes');
            for (var i = 0; i < result.rows.length; i++) {
                list_bareme.push(result.rows.item(i).operation)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
//    print("====", list_bareme)
    return list_bareme;
}
// ======================================================================================================
function salaire_fixe(noms) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_bareme = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT s_fixe FROM employes WHERE noms=?', [noms]);
            for (var i = 0; i < result.rows.length; i++) {
                list_bareme.push(result.rows.item(i).s_fixe)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
//    print("====", list_bareme)
    return list_bareme;
}
// ========================================================================================================
function fillPointages(noms) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_pointages = [];
    var somme = 0
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT p.id, p.jour, b.operation, p.quantite, b.valeur, p.observation FROM pointages p INNER JOIN employes e ON (p.fk_employe=e.id) INNER JOIN baremes b ON (p.fk_operation=b.id) WHERE e.noms=?', [noms]);
            for (var i = 0; i < result.rows.length; i++) {
                somme = result.rows.item(i).quantite * result.rows.item(i).valeur
                list_pointages.push([result.rows.item(i).id, result.rows.item(i).jour, result.rows.item(i).operation, result.rows.item(i).quantite, result.rows.item(i).valeur, somme ,result.rows.item(i).observation])
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    return list_pointages;
}
// ========================================================================================================
// ========================================================================================================
function fillStatistic(mois, annee) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var employes = "";
    var months = ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
    var index_month = months.indexOf(mois) + 1
    var list_stat = [];
    var pt = []
    var tmp = 0
    var somme = 0
    try {
        db.transaction(function (tx) {
            employes = tx.executeSql('SELECT noms, s_fixe FROM employes');

            for (var i = 0; i < employes.rows.length; i++) {
                    pt = fillVisualisation(employes.rows.item(i).noms, mois, annee)

                    for(var j=0; j<pt.length; j++){
                        tmp += pt[j][5]
//                        print("debug:: ",employes.rows.item(i).noms, pt[j][5])
                    }

                    somme = employes.rows.item(i).s_fixe + tmp
                    var a = avance(employes.rows.item(i).noms, mois, annee)[0]
                    var r = avance(employes.rows.item(i).noms, mois, annee)[1]
                    print("debug: r=", r)
                    list_stat.push([i, employes.rows.item(i).noms, employes.rows.item(i).s_fixe, tmp, somme, parseInt(a), parseInt(r), parseInt(a)+parseInt(r), parseInt(somme) - parseInt(a)-parseInt(r)])
               }
        })
//        print(index_month, annee)
//        print(list_stat)
    } catch (err) {
        console.log("Error while filling recap model in database: " + err)
    };
    return list_stat;
}
// ========================================================================================================
// ========================================================================================================
function fillVisualisation(noms, mois, annee) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_pointages = [];
    var months = ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
    var index_month = months.indexOf(mois) + 1
    if(index_month < 10){
        index_month = "0"+index_month.toString()
    }else{
        index_month = index_month.toString()
    }

    var somme = 0
    try {
        db.transaction(function (tx) {
//            var tmp = tx.executeSql("SELECT jour FROM pointages WHERE SUBSTR(jour, 4, 10) = '22/2021'")
//            print(date("11/11/2020"))
            result = tx.executeSql("SELECT p.id, p.jour, b.operation, p.quantite, b.valeur, p.observation FROM pointages p INNER JOIN employes e ON (p.fk_employe=e.id) INNER JOIN baremes b ON (p.fk_operation=b.id) WHERE e.noms=? AND SUBSTR(p.jour, 7, 10)=? AND SUBSTR(p.jour, 1, 2)=?", [noms, annee, index_month]);
            for (var i = 0; i < result.rows.length; i++) {
                somme = result.rows.item(i).quantite * result.rows.item(i).valeur
                list_pointages.push([result.rows.item(i).id, result.rows.item(i).jour, result.rows.item(i).operation, result.rows.item(i).quantite, result.rows.item(i).valeur, somme ,result.rows.item(i).observation])
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
//    print("list_pointages", list_pointages, index_month)
    return list_pointages;
}

// ========================================================================================================
function employe_to_id(noms) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_id = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT id FROM employes WHERE noms=?', [noms]);
            for (var i = 0; i < result.rows.length; i++) {
                list_id.push(result.rows.item(i).id)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    return list_id;
}
// ========================================================================================================
function id_to_employe(id) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_id = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT noms FROM employes WHERE id=?', [id]);
            for (var i = 0; i < result.rows.length; i++) {
                list_id.push(result.rows.item(i).noms)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    return list_id;
}
// ========================================================================================================
function bareme_to_id(operation) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_id = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT id FROM baremes WHERE operation=?', operation);
            for (var i = 0; i < result.rows.length; i++) {
                list_id.push(result.rows.item(i).id)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    return list_id;
}

// ========================================================================================================
function price_from_bareme(bareme) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_valeur = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT valeur FROM baremes WHERE operation=?', bareme);
            for (var i = 0; i < result.rows.length; i++) {
                list_valeur.push(result.rows.item(i).valeur)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };

    return list_valeur;
}

function variable(pointages){
    var tmp = pointages
    var total = 0
    for(var i=0; i <tmp.length; i++){
        total += tmp[i][5]
    }

    return total
}
function avance(noms, mois, annee){
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var months = ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
    var index_month = months.indexOf(mois) + 1
    if(index_month < 10){
        index_month = "0"+index_month
    }

    var list_avance = [];
    try {
        db.transaction(function (tx) {
            var data_employe = Code.employe_to_id(noms)[0]
            result = tx.executeSql("SELECT avance, mois, retenue FROM retenues WHERE fk_employe=?", [data_employe]);
//            result = tx.executeSql('SELECT retenue FROM retenues');
            for (var i = 0; i < result.rows.length; i++) {
                list_avance.push([result.rows.item(i).avance, result.rows.item(i).mois, result.rows.item(i).retenue])
               }
        })
    } catch (err) {
        console.log("Error while selecting avance from pointage and retenues table in database: " + err)
    };
    if (list_avance.length==0){
        return [0, 0]
    }else{
        for(var i=0; i<list_avance.length; i++){
            var tmp = list_avance[i][1]
            if(tmp.slice(0,2) == index_month && tmp.slice(6,10) == annee){
                var final =  [list_avance[i][0], list_avance[i][2]]
            }
        }
        return final
    }

//    return list_avance
}

function brute(val1, val2){
    return parseInt(val1) + parseInt(val2)
}

function net(val1, val2){
    return parseInt(val1) - parseInt(val2)
}
