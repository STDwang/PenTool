#include "pentoolwork.h"

//生成卫星轨迹保存文件
void Work::createSatesGJ() {
	QVariantMap outTip;
	outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
	outTip.insert("sateName", nowProject.sateName);
	outTip.insert("info", "开始生成轨迹数据");
	emit sendMsg(outTip);
	QDir dir1;
	if (!dir1.mkdir(proMap["temporaryFilesDir"].toString() + "/" + nowProject.name) && !dir1.exists()) {
		QVariantMap outTip;
		outTip.insert("flag", QString("新建项目文件夹失败！"));
		outTip.insert("info", "但允许您手动创建目录：" + proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
		return;
		emit sendOutTip(outTip);
	}

	for (int i = 0; i < nowSateList.size();i++) {
		int beginJd = (rand() % (360 + 1)) - 180;
		int beginWd = (rand() % (360 + 1)) - 180;
		QVariantList tiTrail, jdTrail, wdTrail;
		for (int j = 0; j <= 10; j++)
		{
			tiTrail.append(QVariant::fromValue(j * 60));
			jdTrail.append(QVariant::fromValue(beginJd + j * 10));
			wdTrail.append(QVariant::fromValue(beginWd + j * 10));
		}
		QVariantMap sateTrailMap;
		sateTrailMap.insert("name", QVariant(nowSateList[i].name));
		
		sateTrailMap.insert("longitude", jdTrail);
		sateTrailMap.insert("dimension", wdTrail);
		sateTrailMap.insert("height", nowSateList[0].height * 1e3);
		sateTrailMap.insert("time", tiTrail);
		emit sendSateTrail(sateTrailMap);

		outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
		outTip["sateName"] = nowSateList[i].name;
		outTip["info"] = "轨迹数据生成完毕";
		emit sendMsg(outTip);
	}
}