#include "pentoolsql.h"

void PenToolSql::addSate(QVariantMap data)
{
    QSqlQuery queryAdd;
    QVariantMap outTip;
    QString addString = QString(R"(INSERT INTO SATE(name,height,timeStep,numberTimes,distance,satenumbers,fixPD,xlsx) VALUES('%1',%2,%3,%4,%5,%6,%7,'%8');)")
        .arg(data["name"].toString())
        .arg(data["height"].toDouble())
        .arg(data["timeStep"].toDouble())
        .arg(data["numberTimes"].toInt())
        .arg(data["distance"].toInt())
        .arg(data["satenumbers"].toInt())
        .arg(data["fixPD"].toBool())
        .arg(data["xlsx"].toString());
    
    if (queryAdd.exec(addString)) outTip.insert("flag", data["name"].toString() + "添加成功");
    else outTip.insert("flag", data["name"].toString() + "添加失败" + queryAdd.lastError().text());
    queryAdd.finish();
    emit sendOutTip(outTip);
}

void PenToolSql::editSate(QVariantMap data)
{
    QSqlQuery query;
    QVariantMap outTip;
    QString editstring = QString(R"(UPDATE SATE SET name='%2',height=%3,timeStep=%4,numberTimes=%5,distance=%6,satenumbers=%7,fixPD=%8,xlsx='%9' WHERE sateId=%1;)")
        .arg(data["sateId"].toInt())
        .arg(data["name"].toString())
        .arg(data["height"].toDouble())
        .arg(data["timeStep"].toDouble())
        .arg(data["numberTimes"].toInt())
        .arg(data["distance"].toInt())
        .arg(data["satenumbers"].toInt())
        .arg(data["fixPD"].toBool())
        .arg(data["xlsx"].toString());
    
    if (query.exec(editstring)) outTip.insert("flag", data["name"].toString() + "修改成功");
    else outTip.insert("flag", data["name"].toString() + "修改失败" + query.lastError().text());
    query.finish();
    emit sendOutTip(outTip);
}

void PenToolSql::deleteSate(QVariantMap data)
{
    QVariantMap outTip;
    QSqlQuery queryDelete;
    QString deleteString = QString(R"(DELETE FROM SATE WHERE sateId=%1;)")
        .arg(data["sateId"].toInt());
    
    if (queryDelete.exec(deleteString)) outTip.insert("flag", data["name"].toString() + "删除成功");
    else outTip.insert("flag", data["name"].toString() + "删除失败" + queryDelete.lastError().text());
    queryDelete.finish();
    emit sendOutTip(outTip);
}

void PenToolSql::getSateById(QVariantMap data) {
    QSqlQuery query;
    query.exec(QString(R"(SELECT * FROM SATE WHERE sateId=%1;)").arg(data["sateId"].toInt()));
    QVariantList dataVarList;
    while (query.next())
    {
        QVariantMap itemMap;
        itemMap.insert("sateId",        query.value(query.record().indexOf("sateId")).toInt());
        itemMap.insert("name",          query.value(query.record().indexOf("name")).toString());
        itemMap.insert("height",        query.value(query.record().indexOf("height")).toDouble());
        itemMap.insert("timeStep",      query.value(query.record().indexOf("timeStep")).toDouble());
        itemMap.insert("numberTimes",   query.value(query.record().indexOf("numberTimes")).toInt());
        itemMap.insert("distance",      query.value(query.record().indexOf("distance")).toDouble());
        itemMap.insert("satenumbers",   query.value(query.record().indexOf("satenumbers")).toInt());
        itemMap.insert("fixPD",         query.value(query.record().indexOf("fixPD")).toBool());
        itemMap.insert("xlsx",          query.value(query.record().indexOf("xlsx")).toString());

        dataVarList.push_back(itemMap);
    }
    query.finish();
    emit sendSateList(dataVarList);
}

void PenToolSql::getSateList() {
    QSqlQuery query("SELECT * FROM SATE");
    QVariantList dataVarList;
    while (query.next())
    {
        QVariantMap itemMap;
        itemMap.insert("sateId",        query.value(query.record().indexOf("sateId")).toInt());
        itemMap.insert("name",          query.value(query.record().indexOf("name")).toString());
        itemMap.insert("height",        query.value(query.record().indexOf("height")).toDouble());
        itemMap.insert("timeStep",      query.value(query.record().indexOf("timeStep")).toDouble());
        itemMap.insert("numberTimes",   query.value(query.record().indexOf("numberTimes")).toInt());
        itemMap.insert("distance",      query.value(query.record().indexOf("distance")).toDouble());
        itemMap.insert("satenumbers",   query.value(query.record().indexOf("satenumbers")).toInt());
        itemMap.insert("fixPD",         query.value(query.record().indexOf("fixPD")).toBool());
        itemMap.insert("xlsx",          query.value(query.record().indexOf("xlsx")).toString());

        dataVarList.push_back(itemMap);
    }
    query.finish();
    emit sendSateList(dataVarList);
}
