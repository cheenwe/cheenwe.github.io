# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainwindow.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!
# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainwindow.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!
import sys

from PyQt5 import QtCore, QtGui, QtWidgets

from PyQt5.QtWidgets import QApplication, QMainWindow

class Ui_LoginWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(480, 360)
        MainWindow.setMinimumSize(QtCore.QSize(480, 360))
        MainWindow.setMaximumSize(QtCore.QSize(480, 360))
        MainWindow.setLayoutDirection(QtCore.Qt.LeftToRight)
        MainWindow.setAutoFillBackground(False)
        MainWindow.setStyleSheet("border-color: qconicalgradient(cx:0.5, cy:0.5, angle:0, stop:0 rgba(35, 40, 3, 255), stop:0.16 rgba(136, 106, 22, 255), stop:0.225 rgba(166, 140, 41, 255), stop:0.285 rgba(204, 181, 74, 255), stop:0.345 rgba(235, 219, 102, 255), stop:0.415 rgba(245, 236, 112, 255), stop:0.52 rgba(209, 190, 76, 255), stop:0.57 rgba(187, 156, 51, 255), stop:0.635 rgba(168, 142, 42, 255), stop:0.695 rgba(202, 174, 68, 255), stop:0.75 rgba(218, 202, 86, 255), stop:0.815 rgba(208, 187, 73, 255), stop:0.88 rgba(187, 156, 51, 255), stop:0.935 rgba(137, 108, 26, 255), stop:1 rgba(35, 40, 3, 255));")
        self.centralWidget = QtWidgets.QWidget(MainWindow)
        self.centralWidget.setObjectName("centralWidget")
        self.dial = QtWidgets.QDial(self.centralWidget)
        self.dial.setGeometry(QtCore.QRect(200, 10, 61, 64))
        self.dial.setObjectName("dial")
        self.layoutWidget = QtWidgets.QWidget(self.centralWidget)
        self.layoutWidget.setGeometry(QtCore.QRect(120, 120, 261, 124))
        self.layoutWidget.setObjectName("layoutWidget")
        self.gridLayout = QtWidgets.QGridLayout(self.layoutWidget)
        self.gridLayout.setContentsMargins(11, 11, 11, 11)
        self.gridLayout.setSpacing(6)
        self.gridLayout.setObjectName("gridLayout")
        self.password = QtWidgets.QLineEdit(self.layoutWidget)
        self.password.setWhatsThis("")
        self.password.setInputMethodHints(QtCore.Qt.ImhHiddenText|QtCore.Qt.ImhNoAutoUppercase|QtCore.Qt.ImhNoPredictiveText|QtCore.Qt.ImhSensitiveData)
        self.password.setEchoMode(QtWidgets.QLineEdit.Password)
        self.password.setClearButtonEnabled(True)
        self.password.setObjectName("password")
        self.gridLayout.addWidget(self.password, 1, 0, 1, 1)
        self.btnLogin = QtWidgets.QPushButton(self.layoutWidget)
        self.btnLogin.setObjectName("btnLogin")
        self.gridLayout.addWidget(self.btnLogin, 2, 0, 1, 1)
        self.username = QtWidgets.QLineEdit(self.layoutWidget)
        self.username.setToolTip("")
        self.username.setWhatsThis("")
        self.username.setAccessibleName("")
        self.username.setAccessibleDescription("")
        self.username.setAutoFillBackground(False)
        self.username.setClearButtonEnabled(True)
        self.username.setObjectName("username")
        self.gridLayout.addWidget(self.username, 0, 0, 1, 1)
        self.btnRegister = QtWidgets.QPushButton(self.centralWidget)
        self.btnRegister.setGeometry(QtCore.QRect(120, 250, 261, 32))
        self.btnRegister.setObjectName("btnRegister")
        MainWindow.setCentralWidget(self.centralWidget)
        self.statusBar = QtWidgets.QStatusBar(MainWindow)
        self.statusBar.setObjectName("statusBar")
        MainWindow.setStatusBar(self.statusBar)
        self.menuBar = QtWidgets.QMenuBar(MainWindow)
        self.menuBar.setGeometry(QtCore.QRect(0, 0, 480, 25))
        self.menuBar.setObjectName("menuBar")
        MainWindow.setMenuBar(self.menuBar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "登录界面"))
        self.password.setStatusTip(_translate("MainWindow", " 请输入密码"))
        self.password.setPlaceholderText(_translate("MainWindow", "密码"))
        self.btnLogin.setText(_translate("MainWindow", "登录"))
        self.username.setStatusTip(_translate("MainWindow", "请输入用户名"))
        self.username.setPlaceholderText(_translate("MainWindow", "账户名"))
        self.btnRegister.setText(_translate("MainWindow", "注册账号"))
        self.menuBar.setWhatsThis(_translate("MainWindow", "loginPage"))

if __name__ == '__main__':

    app = QApplication(sys.argv)
    MainWindow = QMainWindow()
    ui = Ui_LoginWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())

