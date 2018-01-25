import sys
from PyQt5.QtWidgets import QWidget, QPushButton, QLabel, QLineEdit, QTextEdit, QGridLayout, QVBoxLayout, QApplication



class Example(QWidget):

    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):


        okButton = QPushButton("添加")
        cancelButton = QPushButton("取消")


        name = QLabel('姓名')
        phone = QLabel('电话')
        age = QLabel('年龄')
        remark = QLabel('备注')

        self.nameEdit = QLineEdit()
        self.phoneEdit = QLineEdit()
        self.ageEdit = QLineEdit()
        self.remarkEdit = QTextEdit()


        grid = QGridLayout()
        grid.setSpacing(10)

        grid.addWidget(name, 1, 0)
        grid.addWidget(self.nameEdit, 1, 1)

        grid.addWidget(phone, 2, 0)
        grid.addWidget(self.phoneEdit, 2, 1)

        grid.addWidget(age, 3, 0)
        grid.addWidget(self.ageEdit, 3, 1)

        grid.addWidget(age, 4, 0)
        grid.addWidget(self.remarkEdit, 4, 1, 4, 1)


        grid.addWidget(remark, 4, 0)
        grid.addWidget(self.remarkEdit, 4, 1, 4, 1)

        grid.addWidget(cancelButton)
        grid.addWidget(okButton)

        self.setLayout(grid)

        self.setGeometry(300, 300, 300, 150)
        self.setWindowTitle('信息添加')
        self.show()

        okButton.clicked.connect(self.okButtonClick)
        cancelButton.clicked.connect(self.cancelButtonClick)

    def okButtonClick(self):
        print("okButtonClick")

        input_name = self.nameEdit.text()

        print(input_name)

        input_phone = self.phoneEdit.text()

        print(input_phone)

        input_age = self.ageEdit.text()

        print(input_age)

        input_remark = self.remarkEdit.toPlainText()

        print(input_remark)

    def cancelButtonClick(self):
        print("cancelButtonClick...")

if __name__ == '__main__':

    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())
