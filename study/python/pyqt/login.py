#!/usr/bin/env python
import sys
from PyQt5.QtCore import *
from PyQt5.QtWidgets import (QWidget, QVBoxLayout, QMainWindow, QDialog, QMessageBox, QLabel, QFormLayout, QToolTip, QPushButton, QLineEdit, QApplication, QSizePolicy)
from PyQt5.QtGui import QIcon


class login_window(QDialog):
    def __init__(self, parent=None):
        super(login_window, self).__init__(parent)

        # Login window setup
        self.setWindowTitle('Login window')
        self.setGeometry(500, 250,0,0)
        self.setMinimumSize(300, 180)
        self.setMaximumSize(300, 180)
        self.setToolTip('')
        self.setWindowIcon(QIcon(''))   # write here the path of the system icon


        # Login layout setup
        self._usernamelabel = QLabel('Username:')
        self._usernamelabel.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self._usernamelabel.setAlignment(Qt.AlignCenter)
        self._istrusername = QLineEdit()
        self._istrusername.setAlignment(Qt.AlignCenter)
        self._istrusername.setToolTip('Type here your username.')
        self._istrusername.setWhatsThis('This is the username field.\nYou can type here your username.\nTake care of the correct format.')
        self._passwordlabel = QLabel('Password:')
        self._passwordlabel.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)
        self._passwordlabel.setAlignment(Qt.AlignCenter)
        self._istrpassword = QLineEdit()
        self._istrpassword.setEchoMode(QLineEdit.Password)
        self._istrpassword.setAlignment(Qt.AlignCenter)
        self._istrpassword.setToolTip('Type here your password.')
        self._istrpassword.setWhatsThis('This is the password field.\nYou can type here your password.\nTake care of the correct format.')


        self._ibloginbutton = QPushButton()
        self._ibloginbutton.setMaximumWidth(80)
        self._ibloginbutton.setText("Sign in")
        self._ibloginbutton.setToolTip('Press this button if you want to Sign in.')
        self._ibloginbutton.clicked.connect(self.login_handling)

        loginlayout = QVBoxLayout(self)
        loginlayout.addWidget(self._usernamelabel)
        loginlayout.addWidget(self._istrusername)
        loginlayout.addWidget(self._passwordlabel)
        loginlayout.addWidget(self._istrpassword)
        loginlayout.addWidget(self._ibloginbutton, 0, Qt.AlignCenter)

        self.setLayout(loginlayout)

    def login_handling(self):
        _istrusername = self._istrusername.text()
        _istrpassword = self._istrpassword.text()
        if not _istrusername:
            QMessageBox.warning(self, 'Error', 'The "username" field is empty.')
        elif not _istrpassword:
            QMessageBox.warning(self, 'Error', 'The "password" field is empty.')
        elif _istrusername == 'username' and _istrpassword == 'password':
            self.accept()
        else:
            QMessageBox.warning(self, 'Error', 'Incorrect credentials.')

class main_window(QMainWindow):
    def __init__(self, parent=None):
        super(main_window, self).__init__(parent)

        #Window setup
        self.setWindowTitle('')
        self.setGeometry(500, 250,0,0)
        self.setMinimumSize(800, 700)
        self.setWindowIcon(QIcon(''))  # write here the path of the system icon



if __name__ == '__main__':

    app = QApplication(sys.argv)
    login = login_window()

    if login.exec_() == QDialog.Accepted:
        main_window = main_window()
        main_window.show()
        sys.exit(app.exec_())