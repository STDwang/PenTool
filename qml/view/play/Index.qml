import QtQuick 2.6
import Toou2D 1.0
import an.qml.PenToolSever 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import QtWebView 1.1
import QtWebEngine 1.4
import "../../common"

Item {
    id: controlplay
    property int index: 0;
    property int count: 1;
    property bool dataPlaied: false;

    Rectangle {
        anchors.fill: parent
        color: "black"
        radius: 10

        Page {
            height: parent.height
            width: parent.width
            //背景图片
//            Image {
//                id: backgroundImag
//                anchors.fill: parent
//                source: "qrc:/res/jpg/earth.jpg"
//                visible: tuIndex.currentIndex === 0
//            }
            Rectangle {
                anchors.fill: parent
                visible: tuIndex.currentIndex === 0
                WebEngineView {
                    id: webView
                    anchors.fill: parent
                    url: "qrc:/map/newmbmap.html"
                    Component.onCompleted: {
                        msgconsolemodel.append({"msg": Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss") + " " + global.projectingName + " " + "地图资源导入成功"});
                    }
                }
                //显示工具栏按钮
                TIconButton{
                    icon.position: TPosition.Only;
                    icon.source: allToolRec.visible ? "qrc:/res/svg/min.svg" : "qrc:/res/svg/max.svg"
                    icon.color: "#9BB3C7"
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    backgroundComponent: null;
                    onClicked: {
                        if(allToolRec.visible){
                            allToolRec.visible = false;
                        }else{
                            allToolRec.visible = true;
                        }
                    }
                }
                Row {
                    id: allToolRec
                    width: parent.width * 0.99
                    height: parent.height * 0.98
                    anchors.centerIn: parent
                    Column {
                        id: leftColumn
                        width: parent.width * 0.8
                        height: parent.height
                        spacing: 10
                        Item {
                            width: parent.width;
                            height: parent.height * 0.75
                        }

                        Msgconsole {
                            height: parent.height * 0.24;
                            width: parent.width;
                            color: Qt.rgba(40/255,40/255,40/255, 0.6);
                            borderColor: "#304156"
                            borderWidth: 1
                            radius: 10
                            mode: msgconsolemodel
                        }
                    }

                    Item {
                        width: parent.width - leftColumn.width - rightTool.width;
                        height: 1
                    }

                    Rectangle {
                        id: rightTool
                        width: parent.width - leftColumn.width - 10
                        height: parent.height;
                        color: Qt.rgba(40/255,40/255,40/255, 0.6)
                        border.color: "#304156"
                        border.width: 1
                        radius: 10

                        Rectangle {
                            id: satechoiceRec
                            height: parent.height * 0.22
                            width: parent.width * 0.94;
                            color: Qt.rgba(0/255,0/255,0/255, 0)
                            border.color: "#304156"
                            border.width: 1
                            anchors.top:parent.top
                            anchors.topMargin: parent.height * 0.01;
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 5

                            Rectangle {
                                height: parent.height * 0.1;
                                width: parent.width * 0.3
                                color: Qt.rgba(40/255,40/255,40/255, 0.8);//Qt.rgba(40/255,40/255,40/255, 0.6)
                                anchors.horizontalCenter: parent.horizontalCenter
                                Label {
                                    text: qsTr("卫星选取")
                                    color: "#9BB3C7"
                                    font.pixelSize: 12
                                    font.family: "微软雅黑"
                                    anchors.centerIn: parent
                                }
                                radius: 5
                            }
                            ChoiceSlidingBarSate {
                                id: satechoiceBar
                                height: parent.height * 0.7;
                                width: parent.width * 0.94;
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                mode: sateChoiceModel;
                                onSuresate: {
                                    for(var key in global.sateTrails){
                                        if(key == name){
                                            mapObject.satePlay(name, global.sateTrails[name], Number(mode.get(index).times) * Number(mode.get(index).timeStep));
                                            return;
                                        }
                                    }
                                }
                                onCanclesate: {
                                    mapObject.sateDisplay(name);
                                }
                            }
                        }

                        Rectangle {
                            id: mbchoiceRec
                            height: parent.height * 0.22
                            width: parent.width * 0.94;
                            color: Qt.rgba(0/255,0/255,0/255, 0)
                            border.color: "#304156"
                            border.width: 1
                            anchors.top: satechoiceRec.bottom
                            anchors.topMargin: parent.height * 0.01;
                            anchors.horizontalCenter: parent.horizontalCenter
                            radius: 5

                            Rectangle {
                                height: parent.height * 0.1;
                                width: parent.width * 0.3
                                color: Qt.rgba(40/255,40/255,40/255, 0.8);//Qt.rgba(40/255,40/255,40/255, 0.6)
                                anchors.horizontalCenter: parent.horizontalCenter
                                Label {
                                    text: qsTr("目标选取")
                                    color: "#9BB3C7"
                                    font.pixelSize: 12
                                    font.family: "微软雅黑"
                                    anchors.centerIn: parent
                                }
                                radius: 5
                            }

                            ChoiceSlidingBarMb {
                                id: mbchoiceBar
                                height: parent.height * 0.7;
                                width: parent.width * 0.94;
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                mode: mbdata;
                                onSureMb: {
                                    for(var key in global.mbTrails){
                                        if(key == mb.name + mb.mbId){
                                            mapObject.mbPlay(key, global.mbTrails[key], Number(mb.times) * Number(mb.timeStep));
                                            return;
                                        }
                                    }
                                    var mbForm = {
                                        "mbId": mb.mbId,
                                        "name": mb.name,
                                        "longitude": mb.longitude,
                                        "latitude": mb.latitude,
                                        "height": mb._height,
                                        "Vx": mb.Vx,
                                        "Vy": mb.Vy,
                                        "Vz": mb.Vz,
                                        "timeStep": mb.timeStep,
                                        "numberTimes": mb.times,
                                        "tuningFrequency": mb.tuningFrequency,
                                        "signalFrequency": mb.signalFrequency,
                                        "snr": mb.snr,
                                    }
                                    penToolSever.getMbTrail(mbForm);
                                }
                                onCancleMb: {
                                    mapObject.mbDisplay(mb.name + mb.mbId);
                                    return;
                                }
                            }
                        }

                        PenComboBox {
                            id: searchName
                            height: parent.height * 0.04;
                            width: rightTool.width * 0.9
                            anchors.top: mbchoiceRec.bottom
                            anchors.topMargin: parent.height * 0.01;
                            anchors.horizontalCenter: parent.horizontalCenter
                            backgoundColor: Qt.rgba(40/255,40/255,40/255, 0.8);
                            borderColor: "#304156";
                            borderWidth: 1;
                            backgoundRadius: 5;
                            model: getallname()
                            function getallname(){
                                var out = [];
                                var i=0;
                                for(i=0;i<sateChoiceModel.count;i++){
                                    out.push(sateChoiceModel.get(i).name)
                                }
                                for(i=0;i<mbdata.count;i++){
                                    out.push(mbdata.get(i).name)
                                }
                                return out;
                            }
                        }

                        TInputField{
                            id:searchTime;
                            height: parent.height * 0.04;
                            width: rightTool.width * 0.9
                            background.radius: 5;
                            background.color: Qt.rgba(40/255,40/255,40/255, 0.8);
                            label.color: "#9BB3C7";
                            cursorColor: "#9BB3C7";
                            text: "0"

                            placeholderPosition: TPosition.Left;
                            placeholderLabel.text: "请按时间步进输入正确的时刻";
                            placeholderLabel.color: "#9BB3C7"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.top: searchName.bottom;
                            anchors.topMargin: parent.height * 0.01;
                            border.color: "#304156"
                            border.width: 1
                            theme.enabled: false;
                        }

                        function getSearchData(){
                            var i=0;
                            var j=0;
                            var findMb = false;
                            var findSate = false;
                            var key;
                            for(i=0;i<sateChoiceModel.count;i++){
                                if(sateChoiceModel.get(i).name == searchName.displayText) {
                                    key = sateChoiceModel.get(i).name;
                                    for(j=0;j<global.sateTrails[key].length;j++){
                                        if(global.sateTrails[key][j]["time"] == Number(searchTime.text)){
                                            findSate = true;
                                            searchtimedata.clear();
                                            searchtimedata.append({
                                                                      "attribute": "时刻(s):",
                                                                      "value": global.sateTrails[key][j]["time"].toString(),
                                                                      "team": searchName.displayText
                                                                  });
                                            searchtimedata.append({
                                                                      "attribute": "经度(°):",
                                                                      "value": global.sateTrails[key][j]["longitude"].toString(),
                                                                      "team": searchName.displayText
                                                                  });
                                            searchtimedata.append({
                                                                      "attribute": "维度(°):",
                                                                      "value": global.sateTrails[key][j]["dimension"].toString(),
                                                                      "team": searchName.displayText
                                                                  });
                                            searchtimedata.append({
                                                                      "attribute": "高度(m):",
                                                                      "value": global.sateTrails[key][j]["height"].toString(),
                                                                      "team": searchName.displayText
                                                                  });
                                            return;
                                        }
                                    }
                                    TToast.showWarning("不存在该时刻的数据",TTimePreset.LongTime4s, "请确保您输入的时刻未越界设置的总时间")
                                    return;
                                }
                            }
                            for(i=0;i<mbdata.count;i++){
                                if(mbdata.get(i).name == searchName.displayText) {
                                    key = mbdata.get(i).name + mbdata.get(i).mbId;
                                    if(!global.mbTrails.hasOwnProperty(key)){
                                        TToast.showWarning("不存在它的轨迹数据",TTimePreset.LongTime4s, "请确保您已经选择并生成该轨迹数据")
                                        return;
                                    }
                                    for(j=0;j<global.mbTrails[key].length;j++) {
                                        if(global.mbTrails[key][j]["time"] == Number(searchTime.text)){
                                            searchtimedata.clear();
                                            searchtimedata.append({
                                                                      "attribute": "经度(°):",
                                                                      "value": global.mbTrails[key][j]["longitude"].toString(),
                                                                      "team": global.mbTrails[key][j]["name"]
                                                                  });
                                            searchtimedata.append({
                                                                      "attribute": "维度(°):",
                                                                      "value": global.mbTrails[key][j]["dimension"].toString(),
                                                                      "team": global.mbTrails[key][j]["name"]
                                                                  });
                                            searchtimedata.append({
                                                                      "attribute": "高度(m):",
                                                                      "value": global.mbTrails[key][j]["height"].toString(),
                                                                      "team": global.mbTrails[key][j]["name"]
                                                                  });
                                            for(var k=0;k<sateChoiceModel.count;k++){
                                                searchtimedata.append({
                                                                          "attribute": "方位角(°):",
                                                                          "value": global.mbTrails[key][j]["sateName"][sateChoiceModel.get(k).name]["fangweijiao"].toString(),
                                                                          "team": sateChoiceModel.get(k).name
                                                                      });
                                                searchtimedata.append({
                                                                          "attribute": "俯仰角(°):",
                                                                          "value": global.mbTrails[key][j]["sateName"][sateChoiceModel.get(k).name]["fuyangjiao"].toString(),
                                                                          "team": sateChoiceModel.get(k).name
                                                                      });
                                                searchtimedata.append({
                                                                          "attribute": "时差:",
                                                                          "value": global.mbTrails[key][j]["sateName"][sateChoiceModel.get(k).name]["shicha"].toString(),
                                                                          "team": sateChoiceModel.get(k).name
                                                                      });
                                                searchtimedata.append({
                                                                          "attribute": "频差:",
                                                                          "value": global.mbTrails[key][j]["sateName"][sateChoiceModel.get(k).name]["pincha"].toString(),
                                                                          "team": sateChoiceModel.get(k).name
                                                                      });
                                                searchtimedata.append({
                                                                          "attribute": "频移:",
                                                                          "value": global.mbTrails[key][j]["sateName"][sateChoiceModel.get(k).name]["pinyi"].toString(),
                                                                          "team": sateChoiceModel.get(k).name
                                                                      });
                                            }
                                            return;
                                        }
                                    }
                                    TToast.showWarning("不存在该时刻的数据",TTimePreset.LongTime4s, "请确保您输入的时刻未越界设置的总时间")
                                    return;
                                }
                            }
                        }

                        TButton{
                            id: searchTimeButton
                            height: parent.height * 0.04;
                            width: parent.width * 0.4;
                            label.text: "搜索"
                            label.color: "white"
                            anchors.top: searchTime.bottom
                            anchors.topMargin: parent.height * 0.02;
                            anchors.horizontalCenter: parent.horizontalCenter
                            backgroundComponent: Rectangle {
                                anchors.fill: parent
                                color: "#347D39"
                                radius: 5
                            }
                            onClicked: {
                                parent.getSearchData();
                            }
                        }

                        SearchTimeAtt {
                            id: searchTimeAtt
                            height: parent.height * 0.27
                            width: parent.width * 0.94
                            anchors.top: searchTimeButton.bottom
                            anchors.topMargin: parent.height * 0.01;
                            anchors.horizontalCenter: parent.horizontalCenter
                            mode: searchtimedata
                            Component.onCompleted: {
                            }
                        }

                        TButton{
                            id: runButton
                            height: parent.height * 0.04;
                            width: parent.width * 0.4
                            label.text: "运行"
                            label.color: "white"//"#9BB3C7"
                            anchors.top: searchTimeAtt.bottom
                            anchors.topMargin: parent.height * 0.01;
                            anchors.horizontalCenter: parent.horizontalCenter
                            enabled: false
                            backgroundComponent: Rectangle {
                                anchors.fill: parent
                                color: "#347D39"
                                radius: 5
                            }
                            onClicked: {
                                if(progressbar.value < 100){
                                    TToast.showInfo("Wait",TTimePreset.LongTime4s, "请等待预处理完成");
                                    return;
                                }

                                var i=0;
                                var sateFormList = [];
                                var mbFormList = [];
                                for(i=0;i<sateChoiceModel.count;i++){
                                    if(sateChoiceModel.get(i)._checked) {
                                        var sate = sateChoiceModel.get(i);
                                        var sateForm = {
                                            "sateId": sate.sateId,
                                            "name": sate.name,
                                            "height": sate._height,
                                            "timeStep": sate.timeStep,
                                            "numberTimes": sate.times,
                                            "distance": sate.distance,
                                            "satenumbers": sate.satenumbers,
                                            "fixPD": sate.fixPD,
                                            "xlsx": sate.xlsx,
                                        }
                                        sateFormList.push(sateForm);
                                    }
                                }
                                for(i=0;i<mbdata.count;i++){
                                    if(mbdata.get(i)._checked) {
                                        var mb = mbdata.get(i);
                                        var mbForm = {
                                            "mbId": mb.mbId,
                                            "name": mb.name,
                                            "longitude": mb.longitude,
                                            "latitude": mb.latitude,
                                            "height": mb._height,
                                            "Vx": mb.Vx,
                                            "Vy": mb.Vy,
                                            "Vz": mb.Vz,
                                            "timeStep": mb.timeStep,
                                            "numberTimes": mb.times,
                                            "tuningFrequency": mb.tuningFrequency,
                                            "signalFrequency": mb.signalFrequency,
                                            "snr": mb.snr,
                                        }
                                        mbFormList.push(mbForm);
                                    }
                                }
                                if(sateFormList.length===0){
                                    TToast.showSuccess("无效",TTimePreset.LongTime4s, "所选卫星为空");
                                    return;
                                }
                                if(mbFormList.length===0){
                                    TToast.showSuccess("无效",TTimePreset.LongTime4s, "所选目标为空");
                                    return;
                                }
                                penToolSever.runProject(sateFormList, mbFormList);
                                runButton.enabled = false;
                                controlplay.count = 3;
                            }
                        }

                        TProgressBar{
                            id: progressbar
                            height: parent.height * 0.02;
                            width: parent.width * 0.9
                            maxValue: 100;
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            anchors.horizontalCenter: parent.horizontalCenter;
                            background.radius: 5;
                            foreground.color: "#316DCA"
                            theme.groupName: "pb_big"
                            format: "$p%"
                            value: global.progress;

                            TLabel{
                                theme.enabled: false;
                                text: parent.formatText;
                                anchors.centerIn: parent;
                                font.pixelSize: 12;
                                font.bold: true;
                                color: "#9BB3C7"
                            }

                            onValueChanged: {
                                if(value >= 100){
                                    runButton.enabled = true;
                                    if(controlplay.count === 1){
                                        controlplay.count = 2;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            //iq数据快速傅里叶展示
            Rectangle {
                anchors.fill: parent
                visible: tuIndex.currentIndex === 1
                Column {
                    height: parent.height
                    width: parent.width
                    CustomPlotItem {
                        id: iqInputCustomPlot
                        height: parent.height / 2
                        width: parent.width
                        Component.onCompleted: {
                            initIQCustomPlot();
                        }
                    }
                    CustomPlotItem {
                        id: bxInputCustomPlot
                        height: parent.height / 2
                        width: parent.width
                        Component.onCompleted: {
                            initBXCustomPlot();
                        }
                    }
                }
                onVisibleChanged: {
                    if(visible==true && !controlplay.dataPlaied){
                        controlplay.dataPlaied = true;
                        var iqForm = {
                            "min_ti": global.inputIQ["min_ti"],
                            "max_ti": global.inputIQ["max_ti"],
                            "min_IQ": global.inputIQ["min_IQ"],
                            "max_IQ": global.inputIQ["max_IQ"],
                            "ti": global.inputIQ["ti"],
                            "id": global.inputIQ["id"],
                            "qd": global.inputIQ["qd"]
                        }
                        var bxForm = {
                            "min_ft": global.inputIQ["min_ft"],
                            "max_ft": global.inputIQ["max_ft"],
                            "min_fp": global.inputIQ["min_fp"],
                            "max_fp": global.inputIQ["max_fp"],
                            "ft": global.inputIQ["ft"],
                            "fp": global.inputIQ["fp"]
                        }
                        iqInputCustomPlot.iqPlay(iqForm);
                        bxInputCustomPlot.bxPlay(bxForm);
                    }
                }
            }

            //背景视频
            Rectangle {
                anchors.fill: parent
                visible: tuIndex.currentIndex === 2
                AnimatedImage {
                    anchors.fill: parent
                    source: "qrc:/res/gif/homeVideo.gif"
                }
            }
        }
        //分页按钮
        TPagination{
            id: tuIndex
            theme.groupName: "first"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 10
            count: controlplay.count
            currentIndex: controlplay.index;
            onTriggered: controlplay.index = index;
        }
    }
}
