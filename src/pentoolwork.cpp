#include "pentoolwork.h"
Work::Work(QObject *parent) : QObject(parent)
{
}

//卫星轨迹任务构造
Work::Work(QVariant project, QVariantList sateListData, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 0;
	this->nowProject = project.value<projectClass>();
	for (int i = 0; i < sateListData.size(); i++) {
		nowSateList.push_back(sateListData[i].value<sateClass>());
	}
}
//目标轨迹任务构造
Work::Work(QVariant project, QVariant mbData, QVariantList sateListData, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 1;//生成目标轨迹
	this->nowProject = project.value<projectClass>();
	this->nowMb = mbData.value<mbClass>();
	for (int i = 0; i < sateListData.size(); i++) {
		nowSateList.push_back(sateListData[i].value<sateClass>());
	}
}
//项目预处理构造
Work::Work(QVariant project, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 2;
	this->nowProject = project.value<projectClass>();
}
//后续计算构造
Work::Work(QVariant project, QVariant sate, QVariantList sateListData, QVariantList mbList, QVariantMap map)
{
	this->proMap = map;
	this->TaskId = 3;//生成RC
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
		//修正采样时延和频移
		task2(nowMbList[i]);
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name + "-" + nowMbList[i].name);
		outTip.insert("info", "计算任务1完毕");
		emit sendMsg(outTip);
		if (nowSate.fixPD && nowSate.name.split("卫星")[1].toInt() == 1) {
			//修正相差
			task3(nowMbList[i]);
			outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
			outTip["sateName"] = nowSate.name + "-" + nowMbList[i].name;
			outTip["info"] =  "计算任务2完毕";
			emit sendMsg(outTip);
		}
	}
	//混合加噪
	task4();
	outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
	outTip["sateName"] = nowSate.name + "-" + "所有目标";
	outTip["info"] = "计算任务3完毕";
	emit sendMsg(outTip);
}

void Work::run() {
	qDebug() << "the ThreadId of do Task work:" << QThread::currentThreadId();
	QVariantMap outTip;
	if (this->TaskId == 0) {
		Sate_Mutex.lock();
		createSatesGJ();
		outTip.insert("flag", QString("卫星轨迹准备成功"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
		Sate_Mutex.unlock();
	}
	else if (this->TaskId == 1) {
		Sate_Mutex.lock();
		Sate_Mutex.unlock();
		createMbGJ();
		outTip.insert("flag", QString(nowMb.name + "目标轨迹生成完毕"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
	}
	else if (this->TaskId == 2) {
		ExtendReSample_Mutex.lock();
		task1();
		outTip.insert("flag", QString("项目预处理完毕"));
		outTip.insert("info", proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		emit sendOutTip(outTip);
		ExtendReSample_Mutex.unlock();
	}
	else if (this->TaskId == 3) {
		ExtendReSample_Mutex.lock();
		ExtendReSample_Mutex.unlock();
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name);
		outTip.insert("info", "的计算任务开始启动******");
		emit sendMsg(outTip);
		runProject();
		outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
		outTip.insert("sateName", nowSate.name);
		outTip.insert("info", "所有计算任务完成******");
		emit sendMsg(outTip);
	}
}