#ifndef PENTOOLSEVER_H
#define PENTOOLSEVER_H

#pragma execution_character_set("utf-8")
#include <qthread.h>
#include <QObject>
#include <QString>
#include <QDebug>
#include <QVariant>
#include <QMetaObject>
#include <QCoreApplication>
#include <QVariantMap>
#include <QThreadPool>

#include "pentooldatatype.h"
#include "pentoolsql.h"
#include "pentoolwork.h"
#include "comfution.h"

#define PI acos(-1)

class PenToolSever : public QObject
{
	Q_OBJECT
public:
	explicit PenToolSever(QObject *parent = 0);
	~PenToolSever();

	QString computerId = "";//����id
	QVariantMap proMap;//��������map

	projectClass nowProject;
	QVariantList nowSateList;
	QVariantList nowMbList;

	void addRedegit();//���ע���
	
signals:
    //����UI
	//����Ϣ
    void sendMessage(QVariantMap data);
	void sendOutTip(QVariantMap data);
	void sendProgress(QVariantMap data);
	void sendPro(QVariantMap data);

	void sendSate(QVariantMap data);
	void sendMb(QVariantMap data);
	void sendProject(QVariantMap data);
	void sendSateList(QVariantList data);
	void sendMbList(QVariantList data);
	void sendProjectList(QVariantList data);

	void sendSateTrail(QVariantMap data);
	void sendMbTrail(QVariantMap data);

	void sendInputOfRS(QVariantMap data);
	void sendOutputOfRS(QVariantMap data);

    //����sql
	bool mysqlLoginTo(QVariantMap data);
    bool sqliteLoginTo();

    void getSateListTo();
	void getMbListTo();
	void getProjectListTo();

	void getSateByIdTo(QVariantMap data);
	void getMbByIdTo(QVariantMap data);
	void getProjectByIdTo(QVariantMap data);

	void addSateTo(QVariantMap data);
	void addMbTo(QVariantMap data);
	void addProjectTo(QVariantMap data);
	bool createProjectTo(QVariantMap data);

	void deleteSateTo(QVariantMap data);
	void deleteMbTo(QVariantMap data);
	void deleteProjectTo(QVariantMap data);

	void editSateTo(QVariantMap data);
	void editMbTo(QVariantMap data);
	void editProjectTo(QVariantMap data);

public slots:
	//��Ϣ�н麯��-----------------------------------------------
	//�������̵߳���Ϣ��ת����UI
	void receiveMsg(QVariantMap tip);
	//�������̵߳����н�����ѣ�ת����UI
	void receiveOutTip(QVariantMap tip);
	//�������̵߳����н�����ѣ�ת����UI
	void receiveProgress(QVariantMap tip);
	//sql
	void receiveSate(QVariantMap data);
	void receiveMb(QVariantMap data);
	void receiveProject(QVariantMap data);

	void receiveSateList(QVariantList data);
	void receiveMbList(QVariantList data);
	void receiveProjectList(QVariantList data);

	//������ݽ��պ���--------------------------------------------
	//����work�����Ĺ켣����
	void receiveMbTrail(QVariantMap data);
	void receiveSateTrail(QVariantMap data);
	//����work�������ز�������
	void receiveInputOfRS(QVariantMap data);
	void receiveOutputOfRS(QVariantMap data);

    //uiֱ�ӵ���----------------------------------------
	// ���̷߳���
	//�õ������sql�˺�����
	QVariantMap getSqlApMap();
	//����ID��������
	void copyID(QString str);
    //�������ID
	QString getID();
	//lincese�ǲ����Ѿ������ҶԵ�
	bool isUser();
    //Lincese��֤
    bool linceseVerify(QString str);
    //��û����ļ�Ŀ¼�µ����е��Ʒ����ļ��ļ���
	QVariantList getModulationList();
    //��ò������ļ�Ŀ¼������xlsx�ļ�
	QVariantList getCxzList();
	//������б���
	QVariantList getTableNameList();
	//��ȡ���ò����ļ�
	QVariantMap readPro();
	//������������
	bool setPro(QVariantMap data);

	//�ö�Ӧ�Ĺ켣����
	//void getSateTrail(QVariantMap data);
	//�ö�Ӧ�Ĺ켣����
	void getMbTrail(QVariantMap data);
	//������Ŀ 
	void createProject(QVariantMap project, QVariantList sateList);
	//����Ŀ 
	void openProject(QVariantMap project, QVariantList sateList);
	//ִ������
	void runProject(QVariantList sateList, QVariantList mbList);
	
    //mysql��¼ ��¼������getSqlDataFromSql��UI����
    bool mysqlLogin(QVariantMap data);
    //sqlite��¼  qucikBegin
    bool sqliteLogin();
    //�����ݿ��ø��º������
    void getSateList();
	void getMbList();
	void getProjectList();
	//���
	void addSate(QVariantMap data);
	void addMb(QVariantMap data);
	void addProject(QVariantMap data);
	//ɾ��
	void deleteSate(QVariantMap data);
	void deleteMb(QVariantMap data);
	void deleteProject(QVariantMap data);
	//�޸�
	void editSate(QVariantMap data);
	void editMb(QVariantMap data);
	void editProject(QVariantMap data);
	//����
	void getSateById(QVariantMap data);
	void getMbById(QVariantMap data);
	void getProjectById(QVariantMap data);

private:
	QVariantMap softWareMap;
	comFuntions severComFunction;

    QThread *sqlThread;
    PenToolSql *penToolSql;

	//work�̳߳�
	QThreadPool workPool;
};

#endif // PENTOOLSEVER_H
