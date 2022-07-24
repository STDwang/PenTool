#ifndef COMFUTION_H
#define COMFUTION_H
#include "./pentooldatatype.h"
#include <QObject>
#include <QString>
#include <QVariant>
#include <QMetaObject>
#include <QSettings>
#include <QCoreApplication>
#include <QDir>
class comFuntions {

public:
	template <typename T>
	T ReverseBytes(T oldValue)
	{
		T newValue;
		int size = sizeof(T);
		memset(&newValue, 0, size);
		for (int i = 0; i < size; i++) {
			//挨个取字节
			char value = (oldValue >> (i * 8)) & 0xFF;
			memset((char*)&newValue + size - i - 1, value, 1);
		}
		return newValue;
	}

	QVariantMap readPro() {
		QSettings* sIniSetting = new QSettings("config.ini", QSettings::IniFormat);
		sIniSetting->setIniCodec("UTF-8");

		QVariantMap proMap;
		proMap.insert("about", sIniSetting->value("Common/about", QString("NULL")).toString());
		proMap.insert("version", sIniSetting->value("Common/version", QString("NULL")).toString());
		proMap.insert("author", sIniSetting->value("Common/author", QString("NULL")).toString());
		proMap.insert("rootDir", QDir::currentPath());
		proMap.insert("txtDir", sIniSetting->value("FilesConfig/txtDir", QString("NULL")).toString());
		proMap.insert("xlsxDir", sIniSetting->value("FilesConfig/xlsxDir", QString("NULL")).toString());
		proMap.insert("logDir", sIniSetting->value("FilesConfig/logDir", QString("NULL")).toString());
		proMap.insert("temporaryFilesDir", sIniSetting->value("FilesConfig/temporaryFilesDir", QString("NULL")).toString());

		proMap.insert("theme", sIniSetting->value("themeConfig/theme", QString("NULL")).toString());
		proMap.insert("language", sIniSetting->value("languageConfig/language", QString("NULL")).toString());
		proMap.insert("tuflag", sIniSetting->value("FunctionConfig/tuflag", QString("NULL")).toBool());
		proMap.insert("lincese", sIniSetting->value("safeConfig/lincese", QString("NULL")).toString());
		delete sIniSetting;
		return proMap;
	}

	bool setPro(QVariantMap data) {
		QSettings* sIniSetting = new QSettings("config.ini", QSettings::IniFormat);
		sIniSetting->setIniCodec("UTF-8");

		sIniSetting->setValue("FilesConfig/logDir", data["logDir"].toString());
		sIniSetting->setValue("FilesConfig/txtDir", data["txtDir"].toString());
		sIniSetting->setValue("FilesConfig/xlsxDir", data["xlsxDir"].toString());
		sIniSetting->setValue("FilesConfig/temporaryFilesDir", data["temporaryFilesDir"].toString());

		sIniSetting->setValue("themeConfig/theme", data["theme"].toString());
		sIniSetting->setValue("languageConfig/language", data["language"].toString());
		sIniSetting->setValue("FunctionConfig/tuflag", data["tuflag"].toBool());
		sIniSetting->setValue("safeConfig/lincese", data["lincese"].toString());
		delete sIniSetting;
		return true;
	}
};


#endif // COMFUTION_H
