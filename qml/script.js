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
    print("====", list_noms)
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
// ========================================================================================================
function fillPointages() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_pointages = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT * FROM pointages');
            for (var i = 0; i < result.rows.length; i++) {
                list_pointages.push([result.rows.item(i).noms, result.rows.item(i).valeur])
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    print("====", list_pointages)
    return list_pointages;
}
// ========================================================================================================
function fill() {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_pointages = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT * FROM pointages');
            for (var i = 0; i < result.rows.length; i++) {
                list_pointages.push([result.rows.item(i).noms])
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    print("====", list_pointages)
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
    print("====", list_id)
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
    print("====", list_id)
    return list_id;
}

// ========================================================================================================
function price_from_bareme(bareme) {
    var db = LocalStorage.openDatabaseSync("jc", "", "Employe management", 1000000);
    var result = "";
    var list_valeur = [];
    try {
        db.transaction(function (tx) {
            result = tx.executeSql('SELECT valeur FROM baremes WHERE operation=?', [bareme]);
            for (var i = 0; i < result.rows.length; i++) {
                list_valeur.push(result.rows.item(i).id)
               }
        })
    } catch (err) {
        console.log("Error while updating table in database: " + err)
    };
    print("====", list_valeur)
    return list_valeur;
}
