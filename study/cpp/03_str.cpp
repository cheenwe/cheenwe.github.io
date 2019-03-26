/* str.cpp */

#include <iostream>
#include <string>
#include <sstream>
#include <vector>
#include "MakeLic.h"

using namespace std;

// 判断字符串包含
bool has_contain(const string &main_str, const string &str)
{
    string::size_type idx;

    idx = main_str.find(str); //在a中查找b.
    if (idx == string::npos)  //不存在。
        return false;
    else
        return true;
}

//string split 字符串分割
vector<string> split(const string &str, const string &delim)
{
    vector<string> res;
    if ("" == str)
        return res;
    //先将要切割的字符串从string类型转换为char*类型
    char *strs = new char[str.length() + 1]; //不要忘了
    strcpy(strs, str.c_str());

    char *d = new char[delim.length() + 1];
    strcpy(d, delim.c_str());

    char *p = strtok(strs, d);
    while (p)
    {
        string s = p;    //分割得到的字符串转换为string类型
        res.push_back(s); //存入结果数组
        p = strtok(NULL, d);
    }
    return res;
}

static string getCurrentDateStr()
{
    time_t t = time(NULL);
    char ch[64] = {0};
    strftime(ch, sizeof(ch) - 1, "%Y-%m-%d", localtime(&t)); //年-月-日 时-分-秒
    return ch;
}

// UUID=GPU-b6ba1ccf-79b3-6ce8-3a4e-af132aadda96
// SN=0119010200005-00:50:c2:41:94:e2

//file Gpuid Mac  2019-01-02 3

int main(int argc, char *argv[])
{
    cout << " ===========  start :" << argv[0] << "  参数: " << argc << " =========== " << endl;
    cout << "file: " << argv[1] << endl;
    cout << "GPUID: " << argv[2] << endl;
    cout << "mac: " << argv[3] << endl;
    cout << "date: " << argv[4] << endl;
    cout << "num: " << argv[5] << endl;
    // cout << "input1: " << argv[4] << endl;
    // cout << "input2: " << argv[4] << endl;
    cout << " =========== end =========== " << endl;

    string start_at = getCurrentDateStr();

    // 判断输入是否是日期
    if (has_contain(argv[4], "-"))
    {
        start_at = argv[4];
    }
    else
    {
        cout << ">>>>>>>>>>>>>" << start_at  << endl;
    }

    // 判断输入是否是年
    if (argv[5] != "")
    {
        cout << argv[5] << endl;
    }
    else
    {
        cout << ">>>>>>>>>>>>>" << endl;
    }

    vector<string> date_str = split(start_at, "-");

    cout << date_str[0] << endl;
    cout << date_str[1] << endl;
    cout << date_str[2] << endl;

    int StartTimeyear = atoi(date_str[0].c_str());
    int StartTimemonth = atoi(date_str[1].c_str());
    int StartTimeday = atoi(date_str[2].c_str());
    int year_num = atoi(argv[3]) ;

    int EndTimeyear = StartTimeyear + year_num;

    cout << StartTimeyear << endl;
    cout << EndTimeyear << endl;

    // char ID[64];
    // strcpy(ID, "GPU-b6ba1ccf-79b3-6ce8-3a4e-af132aadda96xxxxxxxxxxxxxxxxxxxxxxx");

    LIC_TIME stime;
    stime.dwYear = StartTimeyear;
    stime.dwMonth = StartTimemonth;
    stime.dwDay = StartTimeday;
    stime.dwHour = 24;
    stime.dwMinute = 0;
    stime.dwSecond = 0;

    LIC_TIME etime;
    etime.dwYear = EndTimeyear;
    etime.dwMonth = StartTimemonth;
    etime.dwDay = StartTimeday;
    etime.dwHour = 24;
    etime.dwMinute = 0;
    etime.dwSecond = 0;

    LicDara lcD;
    lcD.tCur = stime;
    lcD.tStart = stime;
    lcD.tEnd = etime;

    strcpy(lcD.szLicID, "1");
    strcpy(lcD.szMachineID, argv[2]);
    strcpy(lcD.szMachineSN, argv[3]);
    strcpy(lcD.szVersion, "1.0.0.3");

    char *license = argv[0];

    // MakeLic(license, lcD);

    return 0;
}