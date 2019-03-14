## hello world

```
/* helloworld.cpp */
#include <iostream>
int main(int argc,char *argv[])
{
    std::cout << "hello, world" << std::endl;
    return(0);
}
```


> g++ helloworld.cpp


## input data

```
/* helloworld.cpp */
#include <iostream>
int main(int argc, char *argv[])
{
    // std::cout << "hello, world" << std::endl;
    std::cout << "size: " << argc  << std::endl; //参数个数
    std::cout << "run : " << argv[0] << std::endl; //和shell相同， 第一个参数是运行命令行本身
    std::cout << "input1: " << argv[1] << std::endl;
    std::cout << "input2: " <<  argv[2] << std::endl;
    return(0);
}
```



## datetime

```
/* datetime.cpp */
#include <iostream>
#include <string>
using namespace std;

static string  getCurrentTimeStr()
{
	time_t t = time(NULL);
	char ch[64] = {0};
	strftime(ch, sizeof(ch) - 1, "%Y-%m-%d %H:%M:%S", localtime(&t));     //年-月-日 时-分-秒
	return ch;
}

int main()
{
	cout << getCurrentTimeStr() << endl;
	return 0;
}
```

