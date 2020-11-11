#! /usr/bin/python3
from PySide2.QtCore import *
import sqlite3

class Worker(QObject):

    d1  = Signal(str) # employes
    d2  = Signal(float) # data for percentage
    d3  = Signal(str) # data for text

    def __init__(self):
        QObject.__init__(self)
        self._d1 = "..."
        self._d2 = []
        self._d3 = ""

    def getD1(self):
        return self._d1
    def getD2(self):
        return self._d2
    def getD3(self):
        return self._d3

    def setD1(self, data):
        if self._d1 != data:
            self._d1 = data
            self.d1.emit(str(data))
    def setD2(self, data):
        if self._d2 != data:
            self._d2 = data
            self.d2.emit(float(data))
    def setD3(self, data):
        if self._d3 != data:
            self._d3 = data
            self.d3.emit(str(data))

    data1 = Property(str, fget=getD1, fset=setD1, notify=d1)
    data2 = Property(float, fget=getD2, fset=setD2, notify=d2)
    data3 = Property(str, fget=getD3, fset=setD3, notify=d3)

    @Slot(str, str)
    def load(self, link, data):
        if link == "insert":
            sql =  "INSERT INTO employes (noms, tel, ville, naissance, cni, s_fixe) VALUES ('{}', '{}', '{}', '{}', '{}', {})".format(data[0],data[1],data[2],data[3],data[4],data[5])
            sql_execute(sql, db="jc")
            print("added")
        if link == "read":
            req = "SELECT * FROM '{}'".format(data)
            tmp = sql_read(req, db="/home/bm7/qt/project/jc/jc")
            
            self.setD1(tmp)


def sql_execute(sql, data=None, db=None):
    last = None
    con = sqlite3.connect(db)
    try:
        cursor = con.cursor()       # cursor
        sqlQuery = sql              # create table, insert row
        cursor.execute(sqlQuery)
        print(cursor.lastrowid)

    except Exception as e:
        print(e)
    finally:
        con.commit()
        con.close()

def sql_read(sql, data=None, db=None):

    rows = []
    con = sqlite3.connect(db)
    try:
        cursor = con.cursor()       # cursor
        sqlQuery = sql              # create table, insert row
        cursor.execute(sqlQuery)
        items = cursor.fetchall()
        # print(items)
        for row in items:
            rows.append(list(row))
            print(list(row))

    except Exception as e:
        print(e)
    finally:
        con.commit()
        con.close()
    return rows





if __name__ == '__main__':
    # create atble emplooyes
    sql1 = "CREATE TABLE employes(id INTEGER PRIMARY KEY AUTOINCREMENT, noms varchar, tel varchar, ville varchar, naissance varchar, cni varchar, s_fixe INTEGER)"
    # sql_execute(sql1, db="jc")

    # insert 3 employe in table emeployes
    sql2 = "INSERT INTO employes (noms, tel, ville, naissance, cni, s_fixe) VALUES ('{}', '{}', '{}', '{}', '{}', {})".format('Jean-Claude', '695583699', 'yde', '2020', '114477', 50000)
    sql3 = "INSERT INTO employes (noms, tel, ville, naissance, cni, s_fixe) VALUES ('{}', '{}', '{}', '{}', '{}', {})".format('Jean-Anne', '695583677', 'dla', '2020', '118877', 50000)
    sql4 = "INSERT INTO employes (noms, tel, ville, naissance, cni, s_fixe) VALUES ('{}', '{}', '{}', '{}', '{}', {})".format('Jean', '695583119', 'ndere', '2020', '185477', 50000)
    print(sql2)
    # sql_execute(sql2, db="jc")
    # sql_execute(sql3, db="jc")
    # sql_execute(sql4, db="jc")

    cond = "Jean"

    sql6 = "UPDATE employes SET noms='{}', tel='{}', ville='{}', naissance='{}', cni='{}', s_fixe='{}' WHERE noms='{}'".format("Jean", "695583119", 'ndere', "2020", "111111", 50000, cond)
    sql_execute(sql6, db="jc")

    sql7 = "DELETE FROM employes WHERE cni='{}'".format("111111")
    sql_execute(sql7, db="jc")
    #selection from employe table
    sql5 = "SELECT * FROM employes"
    tmp = sql_read(sql5, db="jc")
    # print(tmp)
