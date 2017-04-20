#include <boost/xpressive/xpressive.hpp>
#include <locale>
#include <fstream>
#include <iostream>
#include <iterator>

#include "codecvt_cp866.hpp"
#include "codecvt_cp1251.hpp"
#include "unicyr_ctype.hpp"

//
using namespace std;
using namespace boost::xpressive;

int main()
{
	// ����� ������� ���� input.txt � ��������� cp1251, ���������� ���������
	// "������, ���!"
	ofstream ofile("input.txt", std::ios::binary);
	ostreambuf_iterator<char> writer(ofile);
	writer = 0xCF; // �
	++writer = 0xF0; // �
	++writer = 0xE8; // �
	++writer = 0xE2; // �
	++writer = 0xE5; // �
	++writer = 0xF2; // �
	++writer = 0x2C; // ,
	++writer = 0x20; //  
	++writer = 0xEC; // �
	++writer = 0xE8; // �
	++writer = 0xF0; // �
	++writer = 0x21; // !
	ofile.close();

	// ������ ����
	wifstream ifile("input.txt");
	// ������ ��� �����
	locale cp1251(locale(""), new codecvt_cp1251<wchar_t, char, mbstate_t>);
	ifile.imbue(cp1251);
	wchar_t wstr[14];
	ifile.getline(wstr, 13);

	// �������� C++ ������������ ���������������� cout, cin, cerr �
	// clog, ��� � �� ����������� �������� � stdio, ������� �����������
	// ��� ���� ������� ����� �� ����� ������������ (�� ������ ������ ��� 
	// ���������� gcc, msvc 7 �� ����� �������������� ����������). ������� 
	// �������� ios, ��� �� �� ����� ������������������ � stdio.
	ios_base::sync_with_stdio(false);
	// ������ ��� ������
	locale cp866(locale(""), new codecvt_cp866<wchar_t, char, mbstate_t>);
	// �������� ������, ��� ����� ������� ���������� ���������
	// ��������������
	wcout.imbue(cp866);

	// ������ � ���������� ctype
	locale cyrr(locale(""), new unicyr_ctype);
	wsregex_compiler xpr_compiler;
	xpr_compiler.imbue(cyrr);
	wsregex xpr = xpr_compiler.compile(L"���", regex_constants::icase);
	wsmatch match;
	if (regex_search(wstring(wstr), match, xpr))
		wcout << L"icase ��������" << endl;
	else
		wcout << L"icase �� ��������" << endl;

	return 0;
}






























/*// ������ ������ ������ fstream

#include <iostream>
#include <fstream>
#include <cstring>
#include <cstdio>
#include <string>
#include <Windows.h>

using namespace std;

std::locale::global(std::locale(""));
std::locale l_utf8(std::locale(), new std::codecvt_utf8<wchar_t, 0x10ffffUL, std::codecvt_mode::consume_header>);
std::wifstream wifs(L"d:\\data.txt");
wifs.imbue(l_utf8);

int main()
{
SetConsoleCP(1251);
SetConsoleOutputCP(1251);
/*
cout << "������� �������� �����: ";
char file[80];
char text[80];
string out_s;
gets(file);

// ����� 3 ������
ofstream o(file);
cout << "������� 3 ������ � ���� " << file << "\n" << endl;
for (int i = 0; i < 3; ++i) {
gets(text);
o << text << endl;
}

// ��������� ����������
ifstream i(file);
cout << "\n��������� ���������� ����� " << file << endl;
while (true) {
getline(i, out_s);
if (!i.eof())
cout << out_s << endl;
else break;
}

string line;
char cFile[60] = "C:\\Users\\Ganji\\AppData\\Roaming\\ruscraft\\logs\\latest.log";
ifstream file(cFile);
while (true){
getline(file, line);
if (!file.eof())
wcout << line << endl;
else break;
}
return 0;
}*/