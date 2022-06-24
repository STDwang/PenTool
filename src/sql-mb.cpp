#include "pentoolsql.h"

void PenToolSql::addMb(QVariantMap data)
{
    QSqlQuery queryAdd;
    QVariantMap outTip;
    QString addString = QString(R"(INSERT INTO MB(name,longitude,latitude,height,Vx,Vy,Vz,timeStep,numberTimes,tuningFrequency,signalFrequency,snr) VALUES('%1',%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12);)")
        .arg(data["name"].toString())
        .arg(data["longitude"].toDouble())
        .arg(data["latitude"].toDouble())
        .arg(data["height"].toDouble())
        .arg(data["Vx"].toDouble())
        .arg(data["Vy"].toDouble())
        .arg(data["Vz"].toDouble())
        .arg(data["timeStep"].toDouble())
        .arg(data["numberTimes"].toInt())
        .arg(data["tuningFrequency"].toDouble())
        .arg(data["signalFrequency"].toDouble())
        .arg(data["snr"].toDouble());

    if(queryAdd.exec(addString)){
        outTip.insert("flag", data["name"].toString() + "添加成功");
    }else{
        outTip.insert("flag", data["name"].toString() + "添加失败:" + queryAdd.lastError().text());
    }
    emit sendOutTip(outTip);
    queryAdd.finish();
}

void PenToolSql::deleteMb(QVariantMap data)
{
    QVariantMap outTip;
    QSqlQuery queryDelete;
    QString deleteString = QString(R"(DELETE FROM MB WHERE mbId=%1;)")
        .arg(data["mbId"].toInt());

    if(queryDelete.exec(deleteString)){
        outTip.insert("flag", data["name"].toString() + "删除成功");
    }else{
        outTip.insert("flag", data["name"].toString() + "删除失败:" + queryDelete.lastError().text());
    }
    emit sendOutTip(outTip);
    queryDelete.finish();
}

void PenToolSql::editMb(QVariantMap data)
{
    QSqlQuery query;
    QVariantMap outTip;
    QString editstring = QString(R"(UPDATE MB SET name='%2',longitude=%3,latitude=%4,height=%5,Vx=%6,Vy=%7,Vz=%8,timeStep=%9,numberTimes=%10,tuningFrequency=%11,signalFrequency=%12,snr=%13 WHERE mbId=%1;)")
        .arg(data["mbId"].toInt())
        .arg(data["name"].toString())
        .arg(data["longitude"].toDouble())
        .arg(data["latitude"].toDouble())
        .arg(data["height"].toDouble())
        .arg(data["Vx"].toDouble())
        .arg(data["Vy"].toDouble())
        .arg(data["Vz"].toDouble())
        .arg(data["timeStep"].toDouble())
        .arg(data["numberTimes"].toInt())
        .arg(data["tuningFrequency"].toDouble())
        .arg(data["signalFrequency"].toDouble())
        .arg(data["snr"].toDouble());

    if(query.exec(editstring)){
        outTip.insert("flag", data["name"].toString() + "修改成功");
    }else{
        outTip.insert("flag", data["name"].toString() + "修改失败:" + query.lastError().text());
    }
    emit sendOutTip(outTip);
    query.finish();
}

void PenToolSql::getMbById(QVariantMap data) {
    QSqlQuery query;
    QVariantMap outTip;
    if(query.exec(QString(R"(SELECT * FROM MB WHERE mbId=%1;)").arg(data["mbId"].toInt()))){
        outTip.insert("flag", data["name"].toString() + "查找成功");
    }else{
        outTip.insert("flag", data["name"].toString() + "查找失败:" + query.lastError().text());
        return;
    }
    emit sendOutTip(outTip);
    QVariantMap itemMap;
    while (query.next())
    {
        itemMap.insert("mbId",              query.value(query.record().indexOf("mbId")).toInt());
        itemMap.insert("name",              query.value(query.record().indexOf("name")).toString());
        itemMap.insert("longitude",         query.value(query.record().indexOf("longitude")).toDouble());
        itemMap.insert("latitude",          query.value(query.record().indexOf("latitude")).toDouble());
        itemMap.insert("height",            query.value(query.record().indexOf("height")).toDouble());
        itemMap.insert("Vx",                query.value(query.record().indexOf("Vx")).toDouble());
        itemMap.insert("Vy",                query.value(query.record().indexOf("Vy")).toDouble());
        itemMap.insert("Vz",                query.value(query.record().indexOf("Vz")).toDouble());
        itemMap.insert("timeStep",          query.value(query.record().indexOf("timeStep")).toDouble());
        itemMap.insert("numberTimes",       query.value(query.record().indexOf("numberTimes")).toInt());
        itemMap.insert("tuningFrequency",   query.value(query.record().indexOf("tuningFrequency")).toDouble());
        itemMap.insert("signalFrequency",   query.value(query.record().indexOf("signalFrequency")).toDouble());
        itemMap.insert("snr",               query.value(query.record().indexOf("snr")).toDouble());
    }
    emit sendMb(itemMap);
    query.finish();
}

void PenToolSql::getMbList() {
    QSqlQuery query("SELECT * FROM MB");
    QVariantList dataVarList;
    while (query.next())
    {
        QVariantMap itemMap;
        itemMap.insert("mbId",              query.value(query.record().indexOf("mbId")).toInt());
        itemMap.insert("name",              query.value(query.record().indexOf("name")).toString());
        itemMap.insert("longitude",         query.value(query.record().indexOf("longitude")).toDouble());
        itemMap.insert("latitude",          query.value(query.record().indexOf("latitude")).toDouble());
        itemMap.insert("height",            query.value(query.record().indexOf("height")).toDouble());
        itemMap.insert("Vx",                query.value(query.record().indexOf("Vx")).toDouble());
        itemMap.insert("Vy",                query.value(query.record().indexOf("Vy")).toDouble());
        itemMap.insert("Vz",                query.value(query.record().indexOf("Vz")).toDouble());
        itemMap.insert("timeStep",          query.value(query.record().indexOf("timeStep")).toDouble());
        itemMap.insert("numberTimes",       query.value(query.record().indexOf("numberTimes")).toInt());
        itemMap.insert("tuningFrequency",   query.value(query.record().indexOf("tuningFrequency")).toDouble());
        itemMap.insert("signalFrequency",   query.value(query.record().indexOf("signalFrequency")).toDouble());
        itemMap.insert("snr",               query.value(query.record().indexOf("snr")).toDouble());
        dataVarList.push_back(itemMap);
    }
    emit sendMbList(dataVarList);
    query.finish();
}
