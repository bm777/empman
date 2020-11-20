function getRandom(previousValue) {
    return Math.floor(previousValue + Math.random() * 90) % 360;

}

// ============== onclicked fill ============================

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
    print(list_employe)
    return list_employe;
}

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
    print("====", list_bareme)
    return list_bareme;
}
