# run command
import os

password="123"

def sudo_command(command):
  return "echo '"+ password + "' | sudo -S sh -c '" + command  +"'"

def run_command(command):
  tmp = os.popen(command)
  res = tmp.read()
  return "command is run: "+res


command = sudo_command("sudo mkdir /123")
print(command)
print(run_command(command))
