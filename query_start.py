import sqlite3


def execute_query(db: str, script:str) -> list:
    with open(script, 'r') as sql_file:
        sql_code = sql_file.read()
    with sqlite3.connect(db) as con:
        cur = con.cursor()
        cur.execute(sql_code)
        rows = cur.fetchall()
        for row in rows:
            print(row)


db_name = 'students_db.sqlite'
sql_script = r'query_1.sql'

execute_query(db_name, sql_script)

