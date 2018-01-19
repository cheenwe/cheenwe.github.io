from PyQt5 import QtCore, QtGui, QtWidgets
from db import Db
from main import Ui_MainWindow
from signup import Ui_Signup


class Ui_Login(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.setFixedSize(600, 300)

        self.label_name = QtWidgets.QLabel(Dialog)
        self.label_name.setGeometry(QtCore.QRect(130, 160, 131, 21))
        self.label_name.setObjectName("label_name")

        self.label_password = QtWidgets.QLabel(Dialog)
        self.label_password.setGeometry(QtCore.QRect(130, 200, 151, 21))
        self.label_password.setObjectName("label_password")

        self.txtUsername = QtWidgets.QLineEdit(Dialog)
        self.txtUsername.setGeometry(QtCore.QRect(300, 160, 191, 27))
        self.txtUsername.setObjectName("txtUsername")

        self.txtPassword = QtWidgets.QLineEdit(Dialog)
        ################## make the password invisible ############
        self.txtPassword.setEchoMode(QtWidgets.QLineEdit.Password)
        ###########################################################
        self.txtPassword.setGeometry(QtCore.QRect(300, 200, 191, 27))
        self.txtPassword.setObjectName("txtPassword")

        self.btnLogin = QtWidgets.QPushButton(Dialog)
        self.btnLogin.setGeometry(QtCore.QRect(210, 250, 71, 41))
        self.btnLogin.setObjectName("btnLogin")

        #################### Login Button funtion #######################
        self.btnLogin.clicked.connect(self.loginCheck)
        #################################################################

        self.btnSignup = QtWidgets.QPushButton(Dialog)
        self.btnSignup.setGeometry(QtCore.QRect(290, 250, 81, 41))
        self.btnSignup.setObjectName("btnSignup")

        #################### SignUp Button #############################
        self.btnSignup.clicked.connect(self.signupButton)
        ################################################################

        self.label_Heading = QtWidgets.QLabel(Dialog)
        self.label_Heading.setGeometry(QtCore.QRect(150, 90, 381, 51))
        self.label_Heading.setObjectName("label_Heading")

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)


    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "XXX系统"))
        self.label_name.setText(_translate("Dialog", "用户名:"))
        self.label_password.setText(_translate("Dialog", "密码:"))
        self.btnLogin.setText(_translate("Dialog", "登录"))
        self.btnSignup.setText(_translate("Dialog", "注册"))
        self.label_Heading.setText(_translate("Dialog", "登录页"))

    def welcomePage(self):
        self.homWindow = QtWidgets.QMainWindow()
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self.homWindow)
        self.homWindow.show()

    def loginCheck(self):
        username = self.txtUsername.text()
        password = self.txtPassword.text()
        getDb = Db()
        result = getDb.loginCheck(username,password)
        if(result):
            self.welcomePage()
            self.clearField()
            print(result)
        else:
            print("password wrong")
            self.showMessage("Warning","Invalid Username and Password")

    def showMessage(self,title,msg):
        msgBox = QtWidgets.QMessageBox()
        msgBox.setIcon(QtWidgets.QMessageBox.Warning)
        #msgBox.setTitle(title)
        msgBox.setText(msg)
        msgBox.setStandardButtons(QtWidgets.QMessageBox.Ok)
        msgBox.exec_()

    def signupButton(self):
        self.signDialog = QtWidgets.QDialog()
        self.ui = Ui_Signup()
        self.ui.setupUi(self.signDialog)
        self.signDialog.show()

    def clearField(self):
        self.txtUsername.setText(None)
        self.txtPassword.setText(None)


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    Dialog = QtWidgets.QDialog()
    ui = Ui_Login()
    ui.setupUi(Dialog)
    Dialog.show()
    sys.exit(app.exec_())

