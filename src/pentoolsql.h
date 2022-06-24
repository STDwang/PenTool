#ifndef PENTOOLSQL_H
#define PENTOOLSQL_H
#pragma execution_character_set("utf-8")
#include "QSqlQuery"
#include "QString"
#include "QTimer"
#include <QStandardItemModel>
#include <QtSql/QSqlQueryModel>
#include <QSqlTableModel>
#include <QDateTime>
#include <QMenu>
#include <QVariantMap>
#include <qdebug.h>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlRecord>
#include "pentooldatatype.h"

class PenToolSql:public QObject
{
	Q_OBJECT
public:
	explicit PenToolSql(QObject *parent = 0);
    
	QString path;
	//QSqlDatabase db;
	QSqlDatabase m_db;

	bool createSateTable();
	bool createMbTable();
	bool createProjectTable();
signals:
	//发给sever
	//发消息
	void sendOutTip(QVariantMap data);

	void sendSateList(QVariantList data);
	void sendMbList(QVariantList data);
	void sendProjectList(QVariantList data);

	void sendProject(QVariantMap data);
	void sendSate(QVariantMap data);
	void sendMb(QVariantMap data);

public slots:
    bool mysqlLogin(QVariantMap data);
    bool sqliteLogin();

	//添加
	void addSate(QVariantMap data);
	void addMb(QVariantMap data);
	void addProject(QVariantMap data);
	void createProject(QVariantMap data);
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
	//查找所有
	void getSateList();
	void getMbList();
	void getProjectList();
};

#endif // PENTOOLSQL_H
