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
	// Пусть имеется файл input.txt в кодировке cp1251, содержащий банальный
	// "Привет, мир!"
	ofstream ofile("input.txt", std::ios::binary);
	ostreambuf_iterator<char> writer(ofile);
	writer = 0xCF; // П
	++writer = 0xF0; // р
	++writer = 0xE8; // и
	++writer = 0xE2; // в
	++writer = 0xE5; // е
	++writer = 0xF2; // т
	++writer = 0x2C; // ,
	++writer = 0x20; //  
	++writer = 0xEC; // м
	++writer = 0xE8; // и
	++writer = 0xF0; // р
	++writer = 0x21; // !
	ofile.close();

	// Читаем файл
	wifstream ifile("input.txt");
	// Локаль для ввода
	locale cp1251(locale(""), new codecvt_cp1251<wchar_t, char, mbstate_t>);
	ifile.imbue(cp1251);
	wchar_t wstr[14];
	ifile.getline(wstr, 13);

	// Стандарт C++ предписывает синхронизировать cout, cin, cerr и
	// clog, как и их расширенные варианты с stdio, поэтому поумолчанию
	// для этих потоков фасет не будет задействован (во всяком случае при 
	// компиляции gcc, msvc 7 не особо придерживается стандартов). Следует 
	// сообщить ios, что мы не будем синхронизироваться с stdio.
	ios_base::sync_with_stdio(false);
	// Локаль для вывода
	locale cp866(locale(""), new codecvt_cp866<wchar_t, char, mbstate_t>);
	// Сообщаем потоку, что перед выводом необходимо выполнять
	// преобразование
	wcout.imbue(cp866);

	// Локаль с правильным ctype
	locale cyrr(locale(""), new unicyr_ctype);
	wsregex_compiler xpr_compiler;
	xpr_compiler.imbue(cyrr);
	wsregex xpr = xpr_compiler.compile(L"МИР", regex_constants::icase);
	wsmatch match;
	if (regex_search(wstring(wstr), match, xpr))
		wcout << L"icase сработал" << endl;
	else
		wcout << L"icase не сработал" << endl;

	return 0;
}






























/*// Пример работы класса fstream

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
cout << "Введите название файла: ";
char file[80];
char text[80];
string out_s;
gets(file);

// Введём 3 строки
ofstream o(file);
cout << "Введите 3 строки в файл " << file << "\n" << endl;
for (int i = 0; i < 3; ++i) {
gets(text);
o << text << endl;
}

// Прочитаем содержимое
ifstream i(file);
cout << "\nПрочитаем содержимое файла " << file << endl;
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