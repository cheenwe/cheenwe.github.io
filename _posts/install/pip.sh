# install pip

sudo apt-get install python-pip python-dev

# sudo apt-get install python3-pip

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U

pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple



## 升级后报错 修改如下:

ImportError: cannot import name main when running pip

>nano /usr/bin/pip


```
from pip import __main__
if __name__ == '__main__':
    sys.exit(__main__._main())

```
