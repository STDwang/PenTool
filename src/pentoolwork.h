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

//����ģ��
class Work :public QObject, public QRunnable {
    Q_OBJECT
public:
    explicit Work(QObject *parent = 0);
	
	Work(QVariant project, QVariantList sateListData, QVariantMap map);//0�������Ǽ��������
	Work(QVariant project, QVariant mbData, QVariantList sateListData, QVariantMap map);//1����Ŀ�꼰�������
	Work(QVariant project, QVariantMap map);//2�ز���
	Work(QVariant project, QVariant sate, QVariantList sateListData, QVariantList mbList, QVariantMap map);//3ʣ�๦�ܼ���

	int TaskId;
	int datalen;//ͨ����
	projectClass nowProject;
	sateClass nowSate;
	mbClass nowMb;
	QVector<sateClass> nowSateList;
	QVector<mbClass> nowMbList;

	QVariantMap proMap;
	virtual void run() override;

signals:
    //������Ϣ�����߳�
	void sendOutTip(QVariantMap data);
    void sendMsg(QVariantMap data);
	void sendProgress(QVariantMap data);

	//��������ʱ�̵ľ�γ����Ϣ������������Ϣ
	void sendSateTrail(QVariantMap data);
	void sendMbTrail(QVariantMap data);
	//���ز�����ͼ����
	void sendInputRsData(QVariantMap data);
	void sendOutputRsData(QVariantMap data);

private slots:
	//�������ǹ켣
	void createSatesGJ();
	//����Ŀ��켣
	void createMbGJ();

	void task1();
	void task2(mbClass);
	void task3(mbClass);
	void task4();

    //���м���
    void runProject();
private:
	QMutex FP_Mutex;

	comFuntions comfunc;
	mathFuntions mathfunc;
};

#endif // WORK_H
