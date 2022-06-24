#include "pentoolsever.h"

//接收work发来的目标轨迹数据
void PenToolSever::receiveMbTrail(QVariantMap data) {
	emit sendMbTrail(data);
}

//接收work发来的卫星轨迹数据
void PenToolSever::receiveSateTrail(QVariantMap data) {
	emit sendSateTrail(data);
}

//接收work发来的重采样基带输入数据
void PenToolSever::receiveInputOfRS(QVariantMap data) {
	emit sendInputOfRS(data);
}

//接收work发来的重采样结果数据
void PenToolSever::receiveOutputOfRS(QVariantMap data) {
	emit sendOutputOfRS(data);
}

//创建项目
void PenToolSever::createProject(QVariantMap project, QVariantList sateList) {
	emit createProjectTo(project);
	this->nowSateList.clear();
	this->nowMbList.clear();

	this->nowProject.projectId = project["projectId"].toInt();
	this->nowProject.name = project["name"].toString();
	this->nowProject.editTime = project["editTime"].toString();
	this->nowProject.sateName = project["sateName"].toString();
	//this->nowProject.mbNameList = project["mbNameList"].toString();
	this->nowProject.modulation = project["modulation"].toString();
	this->nowProject.allTime = project["allTime"].toDouble();
	this->nowProject.nosurearg = project["nosurearg"].toDouble();
	this->nowProject.outputSamplingRate = project["outputSamplingRate"].toDouble();

	for (int i = 0; i < sateList.size(); i++) {
		QVariantMap tempSateMap = sateList[i].value<QVariantMap>();
		sateClass sate;
		//id都是一样的，没必要存
		//sate.sateId = tempSateMap["sateId"].toInt();
		sate.name = tempSateMap["name"].toString();
		sate.height = tempSateMap["height"].toDouble();
		sate.distance = tempSateMap["distance"].toDouble();
		sate.numberTimes = tempSateMap["numberTimes"].toInt();
		sate.sateNumbers = tempSateMap["satenumbers"].toInt();
		sate.timeStep = tempSateMap["timeStep"].toInt();
		sate.fixPD = tempSateMap["fixPD"].toBool();
		sate.xlsx = tempSateMap["xlsx"].toString();

		QVariant varSate;
		varSate.setValue(sate);
		this->nowSateList.push_back(varSate);
	}
	//生成卫星轨迹
	QVariant varProject;
	varProject.setValue(nowProject);
	Work* creTask = new Work(varProject, this->nowSateList, readPro());
	creTask->setAutoDelete(true);
	connect(creTask, SIGNAL(sendOutTip(QVariantMap)), this, SLOT(receiveOutTip(QVariantMap)));
	connect(creTask, SIGNAL(sendMsg(QVariantMap)), this, SLOT(receiveMsg(QVariantMap)));
	connect(creTask, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	connect(creTask, SIGNAL(sendSateTrail(QVariantMap)), this, SLOT(receiveSateTrail(QVariantMap)));
	workPool.start(creTask);

	//for (int i = 0; i < mbList.size(); i++) {
	//	QVariantMap tempMbMap = mbList[i].value<QVariantMap>();
	//	mbClass mb;
	//	mb.mbId = tempMbMap["mbId"].toInt();
	//	mb.name = tempMbMap["name"].toString();
	//	mb.longitude = tempMbMap["longitude"].toDouble();
	//	mb.latitude = tempMbMap["latitude"].toDouble();
	//	mb.height = tempMbMap["height"].toDouble();
	//	mb.Vx = tempMbMap["Vx"].toDouble();
	//	mb.Vy = tempMbMap["Vy"].toDouble();
	//	mb.Vz = tempMbMap["Vz"].toDouble();
	//	mb.timeStep = tempMbMap["timeStep"].toDouble();
	//	mb.numberTimes = tempMbMap["numberTimes"].toInt();
	//	mb.tuningFrequency = tempMbMap["tuningFrequency"].toDouble();
	//	mb.signalFrequency = tempMbMap["signalFrequency"].toDouble();
	//	mb.snr = tempMbMap["snr"].toDouble();
	//	this->nowMbList.push_back(mb);
	//	//多线程生成轨迹
	//	QVariant mbQVar;
	//	mbQVar.setValue<mbClass>(mb);
	//	Work* creTask = new Work(0, mbQVar);
	//	creTask->setAutoDelete(true);
	//	connect(creTask, SIGNAL(sendOutTip(QVariantMap)),	this, SLOT(receiveOutTip(QVariantMap)));
	//	connect(creTask, SIGNAL(sendMsg(QVariantMap)),		this, SLOT(receiveMsg(QVariantMap)));
	//	connect(creTask, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	//	connect(creTask, SIGNAL(sendMbTrail(QVariantMap)),	this, SLOT(receiveMbTrail(QVariantMap)));
	//	workPool.start(creTask);
	//}

	QVariant projectVar; projectVar.setValue<projectClass>(nowProject);
	Work* rsTask = new Work(projectVar, readPro());
	rsTask->setAutoDelete(true);
	connect(rsTask, SIGNAL(sendOutTip(QVariantMap)), this, SLOT(receiveOutTip(QVariantMap)));
	connect(rsTask, SIGNAL(sendMsg(QVariantMap)), this, SLOT(receiveMsg(QVariantMap)));
	connect(rsTask, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	connect(rsTask, SIGNAL(sendInputRsData(QVariantMap)), this, SLOT(receiveInputOfRS(QVariantMap)));
	connect(rsTask, SIGNAL(sendOutputRsData(QVariantMap)), this, SLOT(receiveOutputOfRS(QVariantMap)));
	workPool.start(rsTask);
}

//打开项目
void PenToolSever::openProject(QVariantMap project, QVariantList sateList) {
	this->nowSateList.clear();
	this->nowMbList.clear();

	this->nowProject.projectId = project["projectId"].toInt();
	this->nowProject.name = project["name"].toString();
	this->nowProject.editTime = project["editTime"].toString();
	this->nowProject.sateName = project["sateName"].toString();
	//this->nowProject.mbNameList = project["mbNameList"].toString();
	this->nowProject.modulation = project["modulation"].toString();
	this->nowProject.allTime = project["allTime"].toDouble();
	this->nowProject.nosurearg = project["nosurearg"].toDouble();
	this->nowProject.outputSamplingRate = project["outputSamplingRate"].toDouble();

	for (int i = 0; i < sateList.size(); i++) {
		QVariantMap tempSateMap = sateList[i].value<QVariantMap>();
		sateClass sate;
		//id都是一样的，没必要存
		//sate.sateId = tempSateMap["sateId"].toInt();
		sate.name = tempSateMap["name"].toString();
		sate.height = tempSateMap["height"].toDouble();
		sate.distance = tempSateMap["distance"].toDouble();
		sate.numberTimes = tempSateMap["numberTimes"].toInt();
		sate.sateNumbers = tempSateMap["satenumbers"].toInt();
		sate.timeStep = tempSateMap["timeStep"].toInt();
		sate.fixPD = tempSateMap["fixPD"].toBool();
		sate.xlsx = tempSateMap["xlsx"].toString();

		QVariant varSate;
		varSate.setValue(sate);
		this->nowSateList.push_back(varSate);
	}
	//生成卫星轨迹
	QVariant varProject; varProject.setValue(nowProject);
	Work* creTask = new Work(varProject, this->nowSateList, readPro());
	creTask->setAutoDelete(true);
	connect(creTask, SIGNAL(sendOutTip(QVariantMap)), this, SLOT(receiveOutTip(QVariantMap)));
	connect(creTask, SIGNAL(sendMsg(QVariantMap)), this, SLOT(receiveMsg(QVariantMap)));
	connect(creTask, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	connect(creTask, SIGNAL(sendSateTrail(QVariantMap)), this, SLOT(receiveSateTrail(QVariantMap)));
	workPool.start(creTask);

	QVariant projectVar; projectVar.setValue<projectClass>(nowProject);
	Work* task1 = new Work(projectVar, readPro());
	task1->setAutoDelete(true);
	connect(task1, SIGNAL(sendOutTip(QVariantMap)), this, SLOT(receiveOutTip(QVariantMap)));
	connect(task1, SIGNAL(sendMsg(QVariantMap)), this, SLOT(receiveMsg(QVariantMap)));
	connect(task1, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	connect(task1, SIGNAL(sendInputRsData(QVariantMap)), this, SLOT(receiveInputOfRS(QVariantMap)));
	connect(task1, SIGNAL(sendOutputRsData(QVariantMap)), this, SLOT(receiveOutputOfRS(QVariantMap)));
	workPool.start(task1);
}

void PenToolSever::getMbTrail(QVariantMap data)
{
	mbClass mb;
	mb.mbId = data["mbId"].toInt();
	mb.name = data["name"].toString();
	mb.longitude = data["longitude"].toDouble();
	mb.latitude = data["latitude"].toDouble();
	mb.height = data["height"].toDouble();
	mb.Vx = data["Vx"].toDouble();
	mb.Vy = data["Vy"].toDouble();
	mb.Vz = data["Vz"].toDouble();
	mb.timeStep = data["timeStep"].toDouble();
	mb.numberTimes = data["numberTimes"].toInt();
	mb.tuningFrequency = data["tuningFrequency"].toDouble();
	mb.signalFrequency = data["signalFrequency"].toDouble();
	mb.snr = data["snr"].toDouble();

	//多线程生成轨迹
	QVariant mbQVar;
	mbQVar.setValue<mbClass>(mb);
	QVariant projectQVar;
	projectQVar.setValue<projectClass>(nowProject);
	Work* creTask = new Work(projectQVar, mbQVar, nowSateList, readPro());
	creTask->setAutoDelete(true);
	connect(creTask, SIGNAL(sendOutTip(QVariantMap)), this, SLOT(receiveOutTip(QVariantMap)));
	connect(creTask, SIGNAL(sendMsg(QVariantMap)), this, SLOT(receiveMsg(QVariantMap)));
	connect(creTask, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
	connect(creTask, SIGNAL(sendMbTrail(QVariantMap)), this, SLOT(receiveMbTrail(QVariantMap)));
	workPool.start(creTask);
}

//执行任务
void PenToolSever::runProject(QVariantList sateList, QVariantList mbList) {
	QVariantList mbTaskList;
	for (int i = 0; i < mbList.size(); i++) {
		QVariantMap tempMbMap = mbList[i].value<QVariantMap>();
		mbClass mb;
		mb.mbId = tempMbMap["mbId"].toInt();
		mb.name = tempMbMap["name"].toString();
		mb.longitude = tempMbMap["longitude"].toDouble();
		mb.latitude = tempMbMap["latitude"].toDouble();
		mb.height = tempMbMap["height"].toDouble();
		mb.Vx = tempMbMap["Vx"].toDouble();
		mb.Vy = tempMbMap["Vy"].toDouble();
		mb.Vz = tempMbMap["Vz"].toDouble();
		mb.timeStep = tempMbMap["timeStep"].toDouble();
		mb.numberTimes = tempMbMap["numberTimes"].toInt();
		mb.tuningFrequency = tempMbMap["tuningFrequency"].toDouble();
		mb.signalFrequency = tempMbMap["signalFrequency"].toDouble();
		mb.snr = tempMbMap["snr"].toDouble();

		QVariant mbQVar; 
		mbQVar.setValue<mbClass>(mb);
		mbTaskList.append(mbQVar);
	}
	for (int i = 0; i < sateList.size(); i++) {
		QVariantMap tempSateMap = sateList[i].value<QVariantMap>();
		sateClass sate;
		sate.sateId = tempSateMap["sateId"].toInt();
		sate.name = tempSateMap["name"].toString();
		sate.height = tempSateMap["height"].toDouble();
		sate.distance = tempSateMap["distance"].toDouble();
		sate.numberTimes = tempSateMap["numberTimes"].toInt();
		sate.sateNumbers = tempSateMap["sateNumbers"].toInt();
		sate.timeStep = tempSateMap["timeStep"].toInt();
		sate.fixPD = tempSateMap["fixPD"].toBool();
		sate.xlsx = tempSateMap["xlsx"].toString();

		QVariant taskSate; 
		taskSate.setValue<sateClass>(sate);
		QVariant project;
		project.setValue<projectClass>(nowProject);
		Work* task = new Work(project, taskSate, nowSateList, mbTaskList, readPro());
		task->setAutoDelete(true);
		connect(task, SIGNAL(sendOutTip(QVariantMap)),	 this, SLOT(receiveOutTip(QVariantMap)));
		connect(task, SIGNAL(sendMsg(QVariantMap)),		 this, SLOT(receiveMsg(QVariantMap)));
		connect(task, SIGNAL(sendProgress(QVariantMap)), this, SLOT(receiveProgress(QVariantMap)));
		workPool.start(task);
	}
}