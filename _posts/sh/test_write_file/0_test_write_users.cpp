//  test write file for cpp
// usage: g++  0_test_write_users.cpp -o w.o
//   by cheenwe 2017-03-24

#include <fstream>
#include <iostream>
#include <sys/time.h>

using namespace std;

long getCurrentTime()
{
   struct timeval tv;
   gettimeofday(&tv,NULL);
   return tv.tv_sec * 1000 + tv.tv_usec / 1000;
}

int main(){
    int i;
    ofstream ofile;               //定义输出文件

    long start_at = getCurrentTime();

    ofile.open("user.cpp.txt");     //作为输出文件打开

    long open_at = getCurrentTime();

    for(i=0;i<=1000000;i++){
      ofile<<i<< ", wahaha"<<",12312312323"<< ",12"<< ",texzt" <<endl;   //数据写入文件
    }

    long end_at = getCurrentTime();

    ofile.close();                //关闭文件

    long close_at = getCurrentTime();

    cout << "total: "<< close_at - start_at << endl;
    cout << "open file: "<< open_at - start_at << endl;
    cout << "for 100000 times : "<< end_at - open_at << endl;

    return 0;
}

// total: 123
// open file: 1
// for 100000 times : 122

// total: 112
// open file: 0
// for 100000 times : 111