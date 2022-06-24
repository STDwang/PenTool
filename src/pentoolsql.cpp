#include "pentoolsql.h"
#include <exception>

PenToolSql::PenToolSql(QObject *parent) : QObject(parent)
{
    //db = QSqlDatabase::addDatabase("QMYSQL");
}

bool PenToolSql::createSateTable()
{
    const QString sql = R"(
                      CREATE TABLE IF NOT EXISTS  SATE (
                      sateId        INTEGER     PRIMARY KEY AUTOINCREMENT NOT NULL,
                      name          TEXT        NOT NULL,
                      height        DOUBLE,
                      timeStep      DOUBLE,
                      numberTimes   INTEGER,
                      distance      DOUBLE,
                      satenumbers   INTEGER,
                      fixPD         BOOLEAN,
                      xlsx          TEXT
                      );)";
    QSqlQuery query;
    if(query.exec(sql)){
        query.finish();
        return true;
    }else{
        query.finish();
        QVariantMap outTip;
        outTip.insert("flag", QString("databaseError"));
        outTip.insert("info", query.lastError().text());
        emit sendOutTip(outTip);
        return false;
    }
}

bool PenToolSql::createMbTable()
{
    const QString sql = R"(
                      CREATE TABLE IF NOT EXISTS  MB (
                      mbId              INTEGER   PRIMARY KEY AUTOINCREMENT NOT NULL,
                      name              TEXT      NOT NULL,
                      longitude         DOUBLE,
                      latitude          DOUBLE,
                      height            DOUBLE,
                      Vx                DOUBLE,
                      Vy                DOUBLE,
                      Vz                DOUBLE,
                      timeStep          DOUBLE,
                      numberTimes       INTEGER,
                      tuningFrequency   DOUBLE,
                      signalFrequency   DOUBLE,
                      snr               DOUBLE
                      );)";
    QSqlQuery query;
    if(query.exec(sql)){
        query.finish();
        return true;
    }else{
        query.finish();
        QVariantMap outTip;
        outTip.insert("flag", QString("databaseError"));
        outTip.insert("info", query.lastError().text());
        emit sendOutTip(outTip);
        return false;
    }
}

bool PenToolSql::createProjectTable()
{
    //mbIndexList           TEXT,
    const QString sql = R"(
                      CREATE TABLE IF NOT EXISTS  PROJECT (
                      projectId             INTEGER   PRIMARY KEY AUTOINCREMENT NOT NULL,
                      name                  TEXT      NOT NULL,
                      sateName              TEXT,
                      modulation            TEXT,
                      nosurearg             DOUBLE,
                      outputSamplingRate    DOUBLE,
                      allTime               DOUBLE,
                      editTime              TEXT
                      );)";
    QSqlQuery query;
    if(query.exec(sql)){
        query.finish();
        return true;
    }else{
        query.finish();
        QVariantMap outTip;
        outTip.insert("flag", QString("databaseError"));
        outTip.insert("info", query.lastError().text());
        emit sendOutTip(outTip);
        return false;
    }
}

bool PenToolSql::mysqlLogin(QVariantMap data){
    /*if(db.isopen()){
        db.close();
    }
    db.sethostname(data["ip"].tostring());
    db.setport(data["port"].toint());
    db.setdatabasename(data["databasename"].tostring());
    db.setusername(data["account"].tostring());
    db.setpassword(data["passward"].tostring());
    return db.open();*/
    return false;
}

bool PenToolSql::sqliteLogin()
{
    path = "pentool.db";
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(path);
    bool isOpen = m_db.open();
    if (!isOpen)
    {
        QVariantMap outTip;
        outTip.insert("flag", QString("databaseError"));
        outTip.insert("info", m_db.lastError().text());
        emit sendOutTip(outTip);
        qDebug() << "Error: Failed to connect database." << m_db.lastError();
    }
    return (isOpen && createSateTable() && createMbTable() && createProjectTable());
}
