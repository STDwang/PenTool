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

	QString computerId = "";//主机id
	QVariantMap proMap;//参数配置map

	projectClass nowProject;
	QVariantList nowSateList;
	QVariantList nowMbList;

	void addRedegit();//软件注册表
	
signals:
    //发给UI
	//发消息
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

    //发给sql
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
	//消息中介函数-----------------------------------------------
	//接收子线程的消息，转发给UI
	void receiveMsg(QVariantMap tip);
	//接收子线程的运行结果提醒，转发给UI
	void receiveOutTip(QVariantMap tip);
	//接收子线程的运行结果提醒，转发给UI
	void receiveProgress(QVariantMap tip);
	//sql
	void receiveSate(QVariantMap data);
	void receiveMb(QVariantMap data);
	void receiveProject(QVariantMap data);

	void receiveSateList(QVariantList data);
	void receiveMbList(QVariantList data);
	void receiveProjectList(QVariantList data);

	//结果数据接收函数--------------------------------------------
	//接收work发来的轨迹数据
	void receiveMbTrail(QVariantMap data);
	void receiveSateTrail(QVariantMap data);
	//接收work发来的重采样数据
	void receiveInputOfRS(QVariantMap data);
	void receiveOutputOfRS(QVariantMap data);

    //ui直接调用----------------------------------------
	// 主线程方法
	//拿到保存的sql账号密码
	QVariantMap getSqlApMap();
	//复制ID到剪贴板
	void copyID(QString str);
    //获得主机ID
	QString getID();
	//lincese是不是已经是有且对的
	bool isUser();
    //Lincese验证
    bool linceseVerify(QString str);
    //获得基带文件目录下的所有调制方法文件文件名
	QVariantList getModulationList();
    //获得测向阵文件目录下所有xlsx文件
	QVariantList getCxzList();
	//获得所有表名
	QVariantList getTableNameList();
	//读取配置参数文件
	QVariantMap readPro();
	//设置配置属性
	bool setPro(QVariantMap data);

	//拿对应的轨迹数据
	//void getSateTrail(QVariantMap data);
	//拿对应的轨迹数据
	void getMbTrail(QVariantMap data);
	//创建项目 
	void createProject(QVariantMap project, QVariantList sateList);
	//打开项目 
	void openProject(QVariantMap project, QVariantList sateList);
	//执行任务
	void runProject(QVariantList sateList, QVariantList mbList);
	
    //mysql登录 登录并调用getSqlDataFromSql给UI数据
    bool mysqlLogin(QVariantMap data);
    //sqlite登录  qucikBegin
    bool sqliteLogin();
    //从数据库拿更新后的数据
    void getSateList();
	void getMbList();
	void getProjectList();
	//添加
	void addSate(QVariantMap data);
	void addMb(QVariantMap data);
	void addProject(QVariantMap data);
	//删除
	void deleteSate(QVariantMap data);
	void deleteMb(QVariantMap data);
	void deleteProject(QVariantMap data);
	//修改
	void editSate(QVariantMap data);
	void editMb(QVariantMap data);
	void editProject(QVariantMap data);
	//查找
	void getSateById(QVariantMap data);
	void getMbById(QVariantMap data);
	void getProjectById(QVariantMap data);

private:
	QVariantMap softWareMap;
	comFuntions severComFunction;

    QThread *sqlThread;
    PenToolSql *penToolSql;

	//work线程池
	QThreadPool workPool;
};

#endif // PENTOOLSEVER_H
