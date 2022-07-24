#ifndef LINCESECREATOR_H
#define LINCESECREATOR_H
#pragma execution_character_set("utf-8")
#include <string>
#pragma once
#include <QtWidgets/QWidget>

class LinceseCreator
{
public:
	LinceseCreator();
	~LinceseCreator();

	char base64char[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	int num_strchr(const char* str, char c);
	void decode(const char* base64, unsigned char* dedata);
private:
};

LinceseCreator::LinceseCreator()
{
}

LinceseCreator::~LinceseCreator()
{
}

/* 在字符串中查询特定字符位置索引
* const char *str ，字符串
* char c，要查找的字符
*/
int LinceseCreator::num_strchr(const char* str, char c)
{
	const char* pindex = strchr(str, c);
	if (NULL == pindex) {
		return -1;
	}
	return pindex - str;
}

/* 解码
* const char * base64 码字
* unsigned char * dedata， 解码恢复的数据
*/
void LinceseCreator::decode(const char* base64, unsigned char* dedata) {
	int i = 0, j = 0;
	int trans[4] = { 0,0,0,0 };
	for (; base64[i] != '\0'; i += 4) {
		// 每四个一组，译码成三个字符
		trans[0] = num_strchr(base64char, base64[i]);
		trans[1] = num_strchr(base64char, base64[i + 1]);
		// 1/3
		dedata[j++] = ((trans[0] << 2) & 0xfc) | ((trans[1] >> 4) & 0x03);

		if (base64[i + 2] == '=') {
			continue;
		}
		else {
			trans[2] = num_strchr(base64char, base64[i + 2]);
		}
		// 2/3
		dedata[j++] = ((trans[1] << 4) & 0xf0) | ((trans[2] >> 2) & 0x0f);

		if (base64[i + 3] == '=') {
			continue;
		}
		else {
			trans[3] = num_strchr(base64char, base64[i + 3]);
		}

		// 3/3
		dedata[j++] = ((trans[2] << 6) & 0xc0) | (trans[3] & 0x3f);
	}
	dedata[j] = '\0';
}

#endif // LINCESECREATOR_H
