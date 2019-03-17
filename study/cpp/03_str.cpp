/* str.cpp */

#include <iostream>
#include <string>
#include <sstream>
#include <vector>

using namespace std;

// 判断字符串包含
bool has_contain(const string &main_str, const string &str)
{
    string::size_type idx;

    idx = main_str.find(str);   //在a中查找b.
    if (idx == string::npos) //不存在。
        return false;
    else
        return true;
}

//string split 字符串分割
vector<string> split(const string &in, const string &delim)
{
    stringstream tran(in.c_str());
    vector<string> out;

    if (has_contain(in, delim))
    {
        string tmp;
        out.clear();
        while (std::getline(tran, tmp, *(delim.c_str())))
        {
            out.push_back(tmp);
        }
        return out;
    }
    else{
        // string jjjjj;
        // tran >> out;
        out.push_back(in.c_str());
        return out;
    }
}


// 2019-01-02 3 MachineID  MachineSN

int main(int argc, char *argv[])
{
    // std::cout << "hello, world" << std::endl;
    std::cout << "size: " << argc << std::endl;    //参数个数
    std::cout << "run : " << argv[0] << std::endl;  //和shell相同， 第一个参数是运行命令行本身

    std::cout << "input1: " << argv[1] << std::endl;

    string input_date = argv[1];
    string input_year = argv[2];
    string input_MachineID = argv[3];
    string input_MachineSN = argv[4];

    string start_at = "2019-01-02";

    if (input_date != "")
    {
        start_at = input_date;
    }
    else{
        cout << ">>>>>>>>>>>>>" << endl;
    }

    vector<string> date_str = split(start_at, "-");

    cout << date_str[0] << endl;
    cout << date_str[1] << endl;
    cout << date_str[2] << endl;

    int StartTimeyear = atoi(date_str[0].c_str());
    int StartTimemonth = atoi(date_str[1].c_str());
    int StartTimeday = atoi(date_str[2].c_str());

    // StartTimeyear=2017
    // StartTimemonth=4
    // StartTimeday=16
    // EndTimeyear=2022
    // EndTimemonth=5
    // EndTimeday=29
    // Version=1.0.0.3
    // UUID=GPU-b6ba1ccf-79b3-6ce8-3a4e-af132aadda96
    // SN=0119010200005-00:50:c2:41:94:e2
    // LicID=1

    // char ID[64];
    // strcpy(ID, "GPU-b6ba1ccf-79b3-6ce8-3a4e-af132aadda96xxxxxxxxxxxxxxxxxxxxxxx");

    // LIC_TIME ts;
    // ts.dwYear = 2019;
    // ts.dwMonth = 3;
    // ts.dwDay = 17;
    // ts.dwHour = 17;
    // ts.dwMinute = 7;
    // ts.dwSecond = 25;

    // LicDara lcD;
    // lcD.tCur = ts;
    // lcD.tEnd = ts;
    // lcD.tStart = ts;

    // strcpy(lcD.szLicID, "1");
    // strcpy(lcD.szMachineID, "GPU-b6ba1ccf-79b3-6ce8-3a4e-af132aadda96");
    // strcpy(lcD.szMachineSN, "0118050200009-00:50:c2:40:14:a4");
    // strcpy(lcD.szVersion, "1.0.0.3");

    // char *license = "XXX.txt";

    return 0;
}