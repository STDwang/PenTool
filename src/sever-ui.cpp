#include "pentoolsever.h"
#include "lincesecreator.h"
#include <QApplication>
#include <QClipboard>
LinceseCreator lincese;
/*
	发数据给UI
*/
void PenToolSever::receiveMsg(QVariantMap data)
{
	emit sendMessage(data);
}

void PenToolSever::receiveOutTip(QVariantMap data)
{
	emit sendOutTip(data);
}

void PenToolSever::receiveProgress(QVariantMap data)
{
	emit sendProgress(data);
}

void PenToolSever::receiveSate(QVariantMap data)
{
	emit sendSate(data);
}

void PenToolSever::receiveMb(QVariantMap data)
{
	emit sendMb(data);
}

void PenToolSever::receiveProject(QVariantMap data)
{
	emit sendProject(data);
}

void PenToolSever::receiveSateList(QVariantList data)
{
	emit sendSateList(data);
}

void PenToolSever::receiveMbList(QVariantList data)
{
	emit sendMbList(data);
}

void PenToolSever::receiveProjectList(QVariantList data)
{
	emit sendProjectList(data);
}

QVariantMap PenToolSever::getSqlApMap()
{
	/*
		读取参数文件，得到保存的账号密码给UI
	*/
	QVariantMap data;
	data.insert("account", "root");
	data.insert("password", "123456");
	return data;
}

void PenToolSever::copyID(QString str) {
	QClipboard* clip = QApplication::clipboard();
	clip->setText(str);
}

QString PenToolSever::getID()
{
	return computerId;
}

bool PenToolSever::linceseVerify(QString str)
{
	QStringList list = str.split("iq");
	QString idstr = list[0];
	QString timestr = list[1];

	char idbase64[128];
	char timebase64[128];
	QByteArray idba = idstr.toLatin1();
	QByteArray timeba = timestr.toLatin1();
	char* idptr = idba.data();
	char* timeptr = timeba.data();
	memcpy(idbase64, idptr, 128);
	memcpy(timebase64, timeptr, 128);

	char iddedata[128];
	char timededata[128];
	lincese.decode(idbase64, (unsigned char*)iddedata);
	lincese.decode(timebase64, (unsigned char*)timededata);

	QString timeTemp(timededata);
	QDateTime timeEnd = QDateTime::fromString(timeTemp, "yyyy-MM-dd");
	QDateTime timeNow = QDateTime::currentDateTime();

	QSettings reg("HKEY_CURRENT_USER\\Software\\IQCreator", QSettings::NativeFormat);
	QString regTimeStr = reg.value("InstallTime", QVariant()).toString();
	QDateTime regTime = QDateTime::fromString(regTimeStr, "yyyy-MM-dd");

	int tRet = timeEnd.toTime_t() - timeNow.toTime_t();
	int rRet = timeEnd.toTime_t() - regTime.toTime_t();
	if (tRet < 0 && rRet < 0) {
		return false;
	}
	if (computerId == iddedata) {
		QSettings* sIniSetting = new QSettings("config.ini", QSettings::IniFormat);
		sIniSetting->setIniCodec("UTF-8");
		QString writeStr = QString(idbase64 + QString("iq") + QString(timebase64));
		sIniSetting->setValue("safeConfig/lincese", writeStr);
		delete sIniSetting;
		return true;
	}
	else {
		return false;
	}
	return true;
}

bool PenToolSever::isUser() {
	QStringList list = softWareMap["lincese"].toString().split("iq");
	if (list.size() < 2) {
		return false;
	}
	QString idstr = list[0];
	QString timestr = list[1];

	char idbase64[128];
	char timebase64[128];
	QByteArray idba = idstr.toLatin1();
	QByteArray timeba = timestr.toLatin1();
	char* idptr = idba.data();
	char* timeptr = timeba.data();
	memcpy(idbase64, idptr, 128 * sizeof(char));
	memcpy(timebase64, timeptr, 128 * sizeof(char));

	char iddedata[128];
	char timededata[128];
	lincese.decode(idbase64, (unsigned char*)iddedata);
	lincese.decode(timebase64, (unsigned char*)timededata);

	QString timeTemp(timededata);
	QDateTime timeEnd = QDateTime::fromString(timeTemp, "yyyy-MM-dd");
	QDateTime timeNow = QDateTime::currentDateTime();

	QString strEnd = timeEnd.toString("yyyy-MM-dd");
	QString strNow = timeNow.toString("yyyy-MM-dd");

	int tRet = timeEnd.toTime_t() - timeNow.toTime_t();
	if (tRet < 0) {
		return false;
	}
	if (computerId == iddedata && tRet >= 0) {
		return true;
	}
	else {
		return false;
	}
}

QVariantList PenToolSever::getModulationList()
{
	QVariantList data;
	QDir* dir = new QDir(readPro()["txtDir"].toString());
	QStringList filter;
	QList<QFileInfo>* fileInfo = new QList<QFileInfo>(dir->entryInfoList(filter));
	for (int i = 0; i < fileInfo->count(); ++i)
	{
		const QFileInfo info_tmp = fileInfo->at(i);
		QString path_tmp = info_tmp.fileName();
		if (info_tmp.isFile()) {
			data.append(path_tmp);
		}
	}
	return data;
}

QVariantList PenToolSever::getCxzList()
{
	QVariantList data;
	QDir* dir = new QDir(readPro()["xlsxDir"].toString());
	QStringList filter;
	QList<QFileInfo>* fileInfo = new QList<QFileInfo>(dir->entryInfoList(filter));
	for (int i = 0; i < fileInfo->count(); ++i)
	{
		const QFileInfo info_tmp = fileInfo->at(i);
		QString path_tmp = info_tmp.fileName();
		if (info_tmp.isFile()) {
			data.append(path_tmp);
		}
	}
	return data;
}

QVariantList PenToolSever::getTableNameList()
{
	QVariantList data;
    data.append("场景管理");
    data.append("目标管理");
	data.append("项目管理");
	return data;
}

QVariantMap PenToolSever::readPro() {
	this->proMap = severComFunction.readPro();
	emit sendPro(this->proMap);
	return this->proMap;
}

bool PenToolSever::setPro(QVariantMap data)
{
	bool setBool = severComFunction.setPro(data);

	this->proMap = severComFunction.readPro();
	emit sendPro(this->proMap);
	return setBool;
}
