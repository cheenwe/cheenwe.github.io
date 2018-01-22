import sys
from PyQt5.QtWidgets import QWidget, QMainWindow,QPushButton, QLabel, QLineEdit, QTextEdit, QGridLayout, QVBoxLayout, QApplication, QMessageBox

from db import Db

class MainPage(QWidget):

    # def __init__(self):
    #     super().__init__()
    #     self.initUI()

    def setupUi(self, MainWindow):
    # def initUI(self):

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
        name = self.nameEdit.text()
        phone = self.phoneEdit.text()
        age = self.ageEdit.text()
        remark = self.remarkEdit.toPlainText()

        if self.checkFields(name,phone,age, remark):
            self.showMessage("Error", "All fields must be filled")
        else:
            # insertDb = Db()
            Db().insertClient(name,phone,age, remark)
            self.showMessage("Success","Insert successul")
            self.clearField()

    def cancelButtonClick(self):
        self.clearField()

    def showMessage(self,title,msg):
        msgBox = QMessageBox()
        msgBox.setIcon(QMessageBox.Information)
        #msgBox.setTitle(title)
        msgBox.setText(msg)
        msgBox.setStandardButtons(QMessageBox.Ok)
        msgBox.exec_()


    ##################### clear fields ##################
    def clearField(self):
        self.nameEdit.setText(None)
        self.phoneEdit.setText(None)
        self.ageEdit.setText(None)
        self.remarkEdit.setText(None)

    def checkFields(self,name,phone,age, remark):
        if(name=="" or phone == "" or age== "" or remark== ""):
            return True

if __name__ == '__main__':

    # app = QApplication(sys.argv)
    # ex = MainPage()
    # sys.exit(app.exec_())

    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = MainPage()
    ui.setupUi(MainWindow)
    # MainWindow.show()
    sys.exit(app.exec_())
