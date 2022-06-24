#include "pentoolwork.h"
Work::Work(QObject *parent) : QObject(parent)
{
}

//���ǹ켣������
Work::Work(QVariant project, QVariantList sateListData, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 0;
	this->nowProject = project.value<projectClass>();
	for (int i = 0; i < sateListData.size(); i++) {
		nowSateList.push_back(sateListData[i].value<sateClass>());
	}
}
//Ŀ��켣������
Work::Work(QVariant project, QVariant mbData, QVariantList sateListData, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 1;//����Ŀ��켣
	this->nowProject = project.value<projectClass>();
	this->nowMb = mbData.value<mbClass>();
	for (int i = 0; i < sateListData.size(); i++) {
		nowSateList.push_back(sateListData[i].value<sateClass>());
	}
}
//��ĿԤ������
Work::Work(QVariant project, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 2;
	this->nowProject = project.value<projectClass>();
}
//�������㹹��
Work::Work(QVariant project, QVariant sate, QVariantList sateListData, QVariantList mbList, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 3;//����RC
	this->nowProject = project.value<projectClass>();
	this->nowSate = sate.value<sateClass>();

	nowSateList.clear();
	for (int i = 0; i < sateListData.size(); i++) {
		nowSateList.push_back(sateListData[i].value<sateClass>());
	}
	nowMbList.clear();
	for (int i = 0; i < mbList.size(); i++) {
		nowMbList.push_back(mbList[i].value<mbClass>());
	}
}

void Work::runProject()
{
	QVariantMap outTip;
	for (int i = 0; i < nowMbList.size(); i++) {
		//��������ʱ�Ӻ�Ƶ��
		task2(nowMbList[i]);
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name + "-" + nowMbList[i].name);
		outTip.insert("info", "��������1���");
		emit sendMsg(outTip);
		if (nowSate.fixPD && nowSate.name.split("����")[1].toInt() == 1) {
			//�������
			task3(nowMbList[i]);
			outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
			outTip["sateName"] = nowSate.name + "-" + nowMbList[i].name;
			outTip["info"] =  "��������2���";
			emit sendMsg(outTip);
		}
	}
	//��ϼ���
	task4();
	outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
	outTip["sateName"] = nowSate.name + "-" + "����Ŀ��";
	outTip["info"] = "��������3���";
	emit sendMsg(outTip);
}

void Work::run() {
	qDebug() << "the ThreadId of do Task work:" << QThread::currentThreadId();
	QVariantMap outTip;
	if (this->TaskId == 0) {
		Sate_Mutex.lock();
		createSatesGJ();
		outTip.insert("flag", QString("���ǹ켣׼���ɹ�"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
		Sate_Mutex.unlock();
	}
	else if (this->TaskId == 1) {
		Sate_Mutex.lock();
		Sate_Mutex.unlock();
		createMbGJ();
		outTip.insert("flag", QString(nowMb.name + "Ŀ��켣�������"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
	}
	else if (this->TaskId == 2) {
		ExtendReSample_Mutex.lock();
		task1();
		outTip.insert("flag", QString("��ĿԤ�������"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
		ExtendReSample_Mutex.unlock();
	}
	else if (this->TaskId == 3) {
		ExtendReSample_Mutex.lock();
		ExtendReSample_Mutex.unlock();
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name);
		outTip.insert("info", "�ļ�������ʼ����******");
		emit sendMsg(outTip);
		runProject();
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name);
		outTip.insert("info", "���м����������******");
		emit sendMsg(outTip);
	}
}