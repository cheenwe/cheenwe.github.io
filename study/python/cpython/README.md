#将python代码编译成.so文件
在维护GPU集群过程中，发现供应商提供的程序都是 .so 文件， 便查了下python 是如何生成 .so 并调用的

[文档](https://moonlet.gitbooks.io/cython-document-zh_cn/content/ch1-basic_tutorial.html)

通过cpython把python的文件转换为二进制文件，达到代码保护的目的

1、下载Cython-0.28.2.tar.gz
    python setup.py install安装

2、创建你需要打包成二进制的python文件
    test.py
    def hello(s):
        print(s)

3、创建一个setup.py文件，内如如下：
    from distutils.core import setup
    from Cython.Build import cythonize

    setup(
        name = "test",
        ext_modules = cythonize("test.py")
    )

4、运行编译程序
    python setup.py build_ext --inplace

5、得到的test.so文件可以直接用当成模块，通过python调用

	>>> import fib
	>>> fib.fib(2000)