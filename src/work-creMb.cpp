#include "pentoolwork.h"

//生成目标轨迹保存文件
void Work::createMbGJ() 
{
    QVariantMap outTip;
    outTip.insert("time", QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss"));
    outTip.insert("sateName", nowMb.name);
    outTip.insert("info", "开始生成轨迹数据");
    emit sendMsg(outTip);

    QVariantList timeMap, fangweijiao, fuyangjiao, shicha, pincha, pinyi;
    QVariantList mb_L, mb_B;
    QVariantMap sateNameMap;
    for (int i = 0; i < nowSateList.size(); i++) {
        
    }
    for (int i = 0; i <= nowMb.numberTimes; i++) {
        timeMap.append(i * 10);
        mb_L.append(QVariant::fromValue(nowMb.longitude + i * 0.1));
        mb_B.append(QVariant::fromValue(nowMb.latitude + i * 0.1));

        for (int j = 0; j < nowSateList.size(); j++) {
            QVariantMap sateConfigMap;
            sateConfigMap.insert("fangweijiao", 0);
            sateConfigMap.insert("fuyangjiao", 0);
            sateConfigMap.insert("shicha", 0);
            sateConfigMap.insert("pincha", 0);
            sateConfigMap.insert("pinyi", 0);
            sateNameMap.insert(nowSateList[j].name, sateConfigMap);
        }
    }
    QVariantMap map;
    map.insert("name", nowMb.name);
    map.insert("mbId", nowMb.mbId);
    map.insert("height", nowMb.height);
    map.insert("longitude", mb_L);
    map.insert("dimension", mb_B);
    map.insert("time", timeMap);

    map.insert("sateName", sateNameMap);
    emit sendMbTrail(map);

    outTip["time"] = QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss");
    outTip["sateName"] = nowMb.name;
    outTip["info"] = "轨迹数据生成完毕";
    emit sendMsg(outTip);
}