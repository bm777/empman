#! /usr/bin/python3

import pymysql

ip              = "127.0.0.1"
username        = "art"
password        = "plokplok"

db              = "jc"
charSet        = "utf8mb4"
cursorType      = pymysql.cursors.DictCursor

def create_DB():
    con = pymysql.connect(host=ip,
                          user=username,
                          password=password,
                          charset=charSet,
                          cursorclass=cursorType)

    try:
        cursor = con.cursor()               # create cursor
        sql = "CREATE DATABASE " + db       # sql statement
        cursor.execute(sql)

        query = "SHOW DATABASES"
        cursor.execute(query)
        databases = cursor.fetchall()

        for database in databases:
            print(database)

    except Exception as e:
        raise e
    finally:
        con.close()

def sql_execute(sql, data=None, _db=None):
    last = None
    con = pymysql.connect(host=ip,
                          user=username,
                          password=password,
                          db= _db if _db != None else db,
                          charset=charSet,
                          cursorclass=cursorType)
    try:
        cursor = con.cursor()       # cursor
        sqlQuery = sql              # create table, insert row
        cursor.execute(sqlQuery)
        if data == "insertion":
            last = cursor.lastrowid
            for r in rows
    except Exception as e:
        raise e
    finally:
        con.close()





if __name__ == '__main__':
    # create_DB() # databse already created
