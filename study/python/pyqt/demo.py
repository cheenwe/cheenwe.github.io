from PyQt5.QtWidgets import QMainWindow, QPushButton , QWidget , QMessageBox, QApplication, QHBoxLayout
import sys, sqlite3

class WinForm(QMainWindow):
    def __init__(self, parent=None):
        super(WinForm, self).__init__(parent)
        button1 = QPushButton('插入数据')
        button2 = QPushButton('显示数据')

        button1.clicked.connect(lambda: self.onButtonClick(1))
        button2.clicked.connect(lambda: self.onButtonClick(2))

        layout = QHBoxLayout()
        layout.addWidget(button1)
        layout.addWidget(button2)

        main_frame = QWidget()
        main_frame.setLayout(layout)
        self.setCentralWidget(main_frame)

    def onButtonClick(self, n):
        if n == 1:
            query = 'INSERT INTO users(name, phone, age, remark) VALUES(?, ?, ?, ?)'

            curs.execute(query, ("test", "12312312312", 12, "text" ))
            conn.commit()

            print('Button {0} 被按下了'.format(n))
            QMessageBox.information(self, "信息提示框", 'Button {0} clicked'.format(n))

        if n == 2:
            print('hhhh {0} 被按下了'.format(n))
            QMessageBox.information(self, "信息提示框", 'Button {0} clicked'.format(n))



if __name__ == "__main__":
    app = QApplication(sys.argv)

    conn  = sqlite3.connect("user.db")
    curs = conn.cursor()

    curs.execute('''
        CREATE TABLE IF NOT EXISTS users(
            id      INTEGER  PRIMARY KEY   AUTOINCREMENT,
            name    TEXT,
            phone   TEXT,
            age     INTEGER,
            remark  TEXT
        )
        ''')

    conn.commit()

    form = WinForm()
    form.show()
    sys.exit(app.exec_())
