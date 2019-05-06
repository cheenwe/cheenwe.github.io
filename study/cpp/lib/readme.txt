## .so文件的编译和调用

gcc test_a.cpp test_b.cpp -fPIC -shared -o libtest.so

gcc main.cpp -L. -ltest -o run