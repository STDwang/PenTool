#include "pentoolwork.h"

//�������ǹ켣�����ļ�
void Work::createSatesGJ() {
	QVariantMap outTip;
	outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
	outTip.insert("sateName", nowProject.sateName);
	outTip.insert("info", "��ʼ���ɹ켣����");
	emit sendMsg(outTip);
	QDir dir1;
	if (!dir1.mkdir(proMap["temporaryFilesDir"].toString() + "/" + nowProject.name) && !dir1.exists()) {
		QVariantMap outTip;
		outTip.insert("flag", QString("�½���Ŀ�ļ���ʧ�ܣ�"));
		outTip.insert("info", "���������ֶ�����Ŀ¼��" + proMap["temporaryFilesDir"].toString() + "/" + nowProject.name);
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
		outTip["info"] = "�켣�����������";
		emit sendMsg(outTip);
	}
}