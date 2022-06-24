#include "pentoolsql.h"

void PenToolSql::addProject(QVariantMap data)
{
    //mbIndexList           TEXT,
    QSqlQuery queryAdd;
    QVariantMap outTip;
    QString addString = QString(R"(INSERT INTO PROJECT(name,sateName,modulation,nosurearg,outputSamplingRate,allTime,editTime) VALUES('%1','%2','%3',%4, %5, %6,'%7');)")
        .arg(data["name"].toString())
        .arg(data["sateName"].toString())
        .arg(data["modulation"].toString())
        .arg(data["nosurearg"].toDouble())
        .arg(data["outputSamplingRate"].toDouble())
        .arg(data["allTime"].toDouble())
        .arg(data["editTime"].toString());

    if (queryAdd.exec(addString)) {
        outTip.insert("flag", QString("添加成功"));
        outTip.insert("info", data["name"].toString());
    }
    else {
        outTip.insert("flag", QString("添加失败"));
        outTip.insert("info", data["name"].toString() + queryAdd.lastError().text());
    }
    emit sendOutTip(outTip);
    queryAdd.finish();
}

void PenToolSql::createProject(QVariantMap data)
{
    QSqlQuery queryAdd;
    QVariantMap outTip;
    QString addString = QString(R"(INSERT INTO PROJECT(name,sateName,modulation,nosurearg,outputSamplingRate,allTime,editTime) VALUES('%1','%2','%3',%4, %5, %6,'%7');)")
        .arg(data["name"].toString())
        .arg(data["sateName"].toString())
        .arg(data["modulation"].toString())
        .arg(data["nosurearg"].toDouble())
        .arg(data["outputSamplingRate"].toDouble())
        .arg(data["allTime"].toDouble())
        .arg(data["editTime"].toString());

    if (queryAdd.exec(addString)) {
        outTip.insert("flag", QString("创建成功"));
        outTip.insert("info", data["name"].toString());
        emit sendOutTip(outTip);
    }
    else {
        outTip.insert("flag", QString("创建失败"));
        outTip.insert("info", data["name"].toString()+ queryAdd.lastError().text());
        emit sendOutTip(outTip);
    }
    queryAdd.finish();
}

void PenToolSql::editProject(QVariantMap data)
{
    QSqlQuery query;
    QVariantMap outTip;
    QString editstring = QString(R"(UPDATE PROJECT SET name='%2', sateName='%3', modulation='%4',nosurearg=%5, outputSamplingRate=%6, allTime=%7, editTime='%8' WHERE projectId=%1;)")
        .arg(data["projectId"].toInt())
        .arg(data["name"].toString())
        .arg(data["sateName"].toString())
        .arg(data["modulation"].toString())
        .arg(data["nosurearg"].toDouble())
        .arg(data["outputSamplingRate"].toDouble())
        .arg(data["allTime"].toDouble())
        .arg(data["editTime"].toString());

    if (query.exec(editstring)) {
        outTip.insert("flag", QString("修改成功"));
        outTip.insert("info", data["name"].toString());
    }
    else {
        outTip.insert("flag", QString("修改失败"));
        outTip.insert("info", data["name"].toString()+ query.lastError().text());
    }
    query.finish();
    emit sendOutTip(outTip);
}

void PenToolSql::deleteProject(QVariantMap data)
{
    QVariantMap outTip;
    QSqlQuery queryDelete;
    QString deleteString = QString(R"(DELETE FROM PROJECT WHERE projectId=%1;)")
        .arg(data["projectId"].toInt());

    if (queryDelete.exec(deleteString)) outTip.insert("flag", data["name"].toString() + QString("删除成功"));
    else outTip.insert("flag", data["name"].toString() + QString("删除失败") + queryDelete.lastError().text());
    queryDelete.finish();
    emit sendOutTip(outTip);
}

void PenToolSql::getProjectById(QVariantMap data) {
    QSqlQuery query;
    query.exec(QString(R"(SELECT * FROM PROJECT WHERE projectId=%1;)").arg(data["projectId"].toInt()));
    QVariantMap itemMap;
    while (query.next())
    {
        itemMap.insert("projectId",         query.value(query.record().indexOf("projectId")).toInt());
        itemMap.insert("name",              query.value(query.record().indexOf("name")).toString());
        itemMap.insert("sateName",          query.value(query.record().indexOf("sateName")).toString());
        itemMap.insert("modulation",        query.value(query.record().indexOf("modulation")).toString());
        itemMap.insert("nosurearg",         query.value(query.record().indexOf("nosurearg")).toDouble());
        itemMap.insert("outputSamplingRate",query.value(query.record().indexOf("outputSamplingRate")).toDouble());
        itemMap.insert("allTime",           query.value(query.record().indexOf("allTime")).toDouble());
        itemMap.insert("editTime",          query.value(query.record().indexOf("editTime")).toString());
    }
    query.finish();
    emit sendProject(itemMap);
}

void PenToolSql::getProjectList() {
    QSqlQuery query("SELECT * FROM PROJECT");
    QVariantList dataVarList;
    while (query.next())
    {
        QVariantMap itemMap;
        itemMap.insert("projectId",         query.value(query.record().indexOf("projectId")).toInt());
        itemMap.insert("name",              query.value(query.record().indexOf("name")).toString());
        itemMap.insert("sateName",          query.value(query.record().indexOf("sateName")).toString());
        itemMap.insert("modulation",        query.value(query.record().indexOf("modulation")).toString());
        itemMap.insert("nosurearg",         query.value(query.record().indexOf("nosurearg")).toDouble());
        itemMap.insert("outputSamplingRate",query.value(query.record().indexOf("outputSamplingRate")).toDouble());
        itemMap.insert("allTime",           query.value(query.record().indexOf("allTime")).toDouble());
        itemMap.insert("editTime",          query.value(query.record().indexOf("editTime")).toString());
        dataVarList.push_back(itemMap);
    }
    emit sendProjectList(dataVarList);
    query.finish();
}
