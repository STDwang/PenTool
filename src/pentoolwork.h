#ifndef WORK_H
#define WORK_H
#pragma execution_character_set("utf-8")
#include <QThread>
#include <QVariant>
#include <QAxObject>
#include <QRunnable>
#include <QTextCodec>
#include<QDateTime>
#include <qdir.h>
#include <QtCore/qexception.h>
#include "qdebug.h"
#include "comfution.h"
#include "mathfution.h"
#include "pentooldatatype.h"

//工作模块
class Work :public QObject, public QRunnable {
    Q_OBJECT
public:
    explicit Work(QObject *parent = 0);
	
	Work(QVariant project, QVariantList sateListData, QVariantMap map);//0生成卫星及相关数据
	Work(QVariant project, QVariant mbData, QVariantList sateListData, QVariantMap map);//1生成目标及相关数据
	Work(QVariant project, QVariantMap map);//2重采样
	Work(QVariant project, QVariant sate, QVariantList sateListData, QVariantList mbList, QVariantMap map);//3剩余功能计算

	int TaskId;
	int datalen;//通道数
	projectClass nowProject;
	sateClass nowSate;
	mbClass nowMb;
	QVector<sateClass> nowSateList;
	QVector<mbClass> nowMbList;

	QVariantMap proMap;
	virtual void run() override;

signals:
    //发送消息给主线程
	void sendOutTip(QVariantMap data);
    void sendMsg(QVariantMap data);
	void sendProgress(QVariantMap data);

	//包括各个时刻的经纬度信息和其他附加信息
	void sendSateTrail(QVariantMap data);
	void sendMbTrail(QVariantMap data);
	//发重采样绘图数据
	void sendInputRsData(QVariantMap data);
	void sendOutputRsData(QVariantMap data);

private slots:
	//生成卫星轨迹
	void createSatesGJ();
	//生成目标轨迹
	void createMbGJ();

	void task1();
	void task2(mbClass);
	void task3(mbClass);
	void task4();

    //进行计算
    void runProject();
private:
	QMutex FP_Mutex;

	comFuntions comfunc;
	mathFuntions mathfunc;
};

#endif // WORK_H
