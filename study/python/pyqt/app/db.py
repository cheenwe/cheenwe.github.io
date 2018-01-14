import sqlite3

class Db:
    def __init__(self):
            self.connection = sqlite3.connect("user.db")
            self.createTable()

    def createTable(self):

        self.connection.execute("CREATE TABLE IF NOT EXISTS clients(id      INTEGER  PRIMARY KEY   AUTOINCREMENT, name    TEXT, phone   TEXT, age     INTEGER, remark  TEXT)")

        self.connection.execute("CREATE TABLE IF NOT EXISTS users(name TEXT NOT NULL,email TEXT, password TEXT)")
        self.connection.commit()

    def insertTable(self,name,user,email,password):
        print(name)
        print(user)
        print(email)
        print(password)
        self.connection.execute("INSERT INTO users VALUES(?,?,?,?)",(name,email,password))
        self.connection.commit()


    def loginCheck(self,name,password):
        result = self.connection.execute("SELECT * FROM users WHERE name = ? AND password = ?",(name,password))
        count = len(result.fetchall())
        print(count)
        #print(result.fetchall())
        for data in result:
            print("Username : ", data[1])
            print("Email : ", data[2])
            print("Password : ", data[3])

        if(count > 0):
            print("Login Successfully")
            return True

        else:
            print("You havent registered yet")
            return False


