import QtQuick 2.6
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import QtWebSockets 1.1
import QtWebChannel 1.0
import an.qml.PenToolSever 1.0
import Toou2D 1.0
import './qml/common'

Window {
    id: root
    visible: true
    minimumWidth: 1398
    minimumHeight: 861
    width: 1398
    height: 861
    opacity: 0.96
    flags: Qt.Window | Qt.FramelessWindowHint   //去标题栏

    T2DWorld{
        mouseAreaCursorShape: Qt.PointingHandCursor
//        appStartupTheme: "Dark"
//        appThemePaths: [
//            "qrc:/themes/"
//        ]
    }
    Timer{
        id: appTimer
        function appTimersetTimeout(cb, delayTime) {
            appTimer.interval = delayTime;
            appTimer.repeat = false;
            appTimer.triggered.connect(cb);
            appTimer.triggered.connect(function release () {
                appTimer.triggered.disconnect(cb); // This is important
                appTimer.triggered.disconnect(release); // This is important as well
            });
            appTimer.start();
        }
    }
    Timer{
        id: mapTimer
        function setTimeout(cb, delayTime) {
            mapTimer.interval = delayTime;
            mapTimer.repeat = false;
            mapTimer.triggered.connect(cb);
            mapTimer.triggered.connect(function release () {
                mapTimer.triggered.disconnect(cb); // This is important
                mapTimer.triggered.disconnect(release); // This is important as well
            });
            mapTimer.start();
        }
    }
    WebSocketTransport {
        id: transport
    }
    QtObject {
        id: mapObject
        WebChannel.id: "backend"
        property string someProperty: "qml data"
        signal satePlay(var name, var sate, var playTimes);
        signal mbPlay(var name, var mb, var playTimes);

        signal sateDisplay(var id);
        signal mbDisplay(var id);
    }
    WebChannel {
        id: channel
        registeredObjects: [mapObject]
    }
    WebSocketServer {
        id: server
        listen: true
        port: 55222
        onClientConnected: {
            if(webSocket.status === WebSocket.Open) {
                channel.connectTo(transport)
                webSocket.onTextMessageReceived.connect(transport.textMessageReceive)
                transport.onMessageChanged.connect(webSocket.sendTextMessage)
            }
        }
        onErrorStringChanged: {
            console.log(qsTr("Server error: %1").arg(errorString));
        }
        Component.onCompleted: {
            console.log(server.url + "已连接");
        }
    }

    //存储全局变量。
    property TObject global: TObject{
        property bool haveLincese: true;
        property bool databaseLogin: false;

        property var modulationList: [];
        property var cxzList: [];
        property var tableNameList: [];

        property var progress: 0;
        property string projectingName: "";
        property bool runEnabled: true;

        property var sateTrails: ({});
        property var mbTrails: ({});
        property var inputIQ: ({});
        property var outputIQ: ({});

        property string rootDir: "";
        property string txtDir: "";
        property string xlsxDir: "";
        property string logDir: "";
        property string temporaryFilesDir: "";
        property bool tuflag: true;
        property var theme: "";
        property var language: "";
        property string lincese: "";
    }

    //整个界面
    TRectangle{
        width: parent.width;
        height: parent.height;
        color: "#1C2128"
        x:leftmenu.isopen ? parent.width * 0.1 : 0;

        //头
        Topbar{
            id:topbar;
            width: parent.width;
            height: 45;
            onShowMenu: leftmenu.open();
        }

        //加载页面
        Loader{
            id:pageloader;

            anchors{
                left:  parent.left;
                right: parent.right;
                top:   topbar.bottom;
                bottom: parent.bottom;
            }
            source: "qrc:/qml/view/home/Index.qml"

            function begin(){
                leftmenu.open();
            }

            function toPage(uri,title){
                if(uri === "qrc:/qml/view/play/Index.qml" && global.projectingName===""){
                    TToast.showWarning("请先创建或选择项目", TTimePreset.LongTime4s)
                    uri = "qrc:/qml/view/play/NoProjectErrorIndex.qml"
                }
                source = uri;
                topbar.title = title;
            }
        }

        //左边导航栏
        Menubar{
            id:leftmenu
            width: 240;
            height: root.height;

            onTopage: {
                if(title === "Github" || title === "myBlog"){
                    openurl_dialog.url = uri;
                    openurl_dialog.open();
                }else{
                    pageloader.toPage(uri,title);
                }
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 100
            }
        }
    }

    TDialog{
        id:openurl_dialog
        titleText: "是否打开Url连接";
        contentText: "前往查看更多详细的内容";

        property string url;
        onTriggered: {
            Qt.openUrlExternally(url);
            openurl_dialog.close();
        }
    }

    Component.onCompleted: {
        TToast.layoutY = 20;
    }

    //数据模型
    ListModel { id: satedata }
    ListModel { id: mbdata }
    ListModel { id: projectdata }
    ListModel { id: sateChoiceModel }
    ListModel { id: msgconsolemodel }
    ListModel { id: searchtimedata }

    PenToolSever {
        id: penToolSever
        Component.onCompleted: {
            if(isUser()){
                global.haveLincese = true;
            }else{
                global.haveLincese = false;
                appTimer.appTimersetTimeout(function(){
                    Qt.quit();               //退出程序
                }, 300000);
            }
            readPro();
            global.modulationList = getModulationList();
            global.cxzList = getCxzList();
            global.tableNameList = getTableNameList();
        }

        onSendPro: {
            global.tuflag = data["tuflag"];
            global.rootDir = data["rootDir"];
            global.logDir = data["logDir"];
            global.txtDir = data["txtDir"];
            global.xlsxDir = data["xlsxDir"];
            global.temporaryFilesDir = data["temporaryFilesDir"];
            global.theme = data["theme"];
            global.language = data["language"];
            global.lincese = data["lincese"];
        }
        onSendOutTip: {
            TToast.showSuccess(data["flag"],TTimePreset.LongTime4s, data["info"]);
        }
        onSendMessage: {
            msgconsolemodel.append({ "msg": data["time"] + " " + data["sateName"] + " " + data["info"]})
        }
        onSendProgress: {
            global.progress = data["progress"];
        }
        onSendProject: {
            projectdata.clear();
            projectdata.append({ "projectId": data["projectId"].toString(),
                                   "name": data["name"],
                                   "sateName": data["sateName"],
                                   "modulation": data["modulation"],
                                   "nosurearg": data["nosurearg"].toString(),
                                   "outputSamplingRate": data["outputSamplingRate"].toString(),
                                   "allTime": data["allTime"].toString(),
                                   "editTime": data["editTime"]});
        }
        onSendProjectList: {
            projectdata.clear();
            for(var i=0;i<data.length;i++){
                var project = data[i];
                projectdata.append({ "projectId": project["projectId"].toString(),
                                       "name": project["name"],
                                       "sateName": project["sateName"],
                                       "modulation": project["modulation"],
                                       "nosurearg": project["nosurearg"].toString(),
                                       "outputSamplingRate": project["outputSamplingRate"].toString(),
                                       "allTime": project["allTime"].toString(),
                                       "editTime": project["editTime"]});
            }
        }
        onSendSate: {
            satedata.clear();
            satedata.append({ "sateId": data["sateId"].toString(),
                                "name": data["name"],
                                "_height": data["height"].toString(),
                                "timeStep": data["timeStep"].toString(),
                                "times": data["numberTimes"].toString(),
                                "distance": data["distance"].toString(),
                                "satenumbers": data["satenumbers"].toString(),
                                "fixPD": data["fixPD"].toString(),
                                "xlsx": data["xlsx"],
                                "_checked": false});
        }
        onSendSateList: {
            satedata.clear();
            for(var i=0;i<data.length;i++){
                var sate = data[i];
                satedata.append({ "sateId": sate["sateId"].toString(),
                                    "name": sate["name"],
                                    "_height": sate["height"].toString(),
                                    "timeStep": sate["timeStep"].toString(),
                                    "times": sate["numberTimes"].toString(),
                                    "distance": sate["distance"].toString(),
                                    "satenumbers": sate["satenumbers"].toString(),
                                    "fixPD": sate["fixPD"].toString(),
                                    "xlsx": sate["xlsx"],
                                    "_checked": false});
            }
        }
        onSendMb: {
            mbdata.clear();
            mbdata.append({ "mbId": data["mbId"].toString(),
                              "name": data["name"],
                              "longitude": data["longitude"].toString(),
                              "latitude": data["latitude"].toString(),
                              "_height": data["height"].toString(),
                              "Vx": data["Vx"].toString(),
                              "Vy": data["Vy"].toString(),
                              "Vz": data["Vz"].toString(),
                              "timeStep": data["timeStep"].toString(),
                              "times": data["numberTimes"].toString(),
                              "tuningFrequency": data["tuningFrequency"].toString(),
                              "signalFrequency": data["signalFrequency"].toString(),
                              "snr": data["snr"].toString(),
                              "_checked": false})
        }
        onSendMbList: {
            mbdata.clear();
            for(var i=0;i<data.length;i++){
                var mb = data[i];
                mbdata.append({ "mbId": mb["mbId"].toString(),
                                  "name": mb["name"],
                                  "longitude": mb["longitude"].toString(),
                                  "latitude": mb["latitude"].toString(),
                                  "_height": mb["height"].toString(),
                                  "Vx": mb["Vx"].toString(),
                                  "Vy": mb["Vy"].toString(),
                                  "Vz": mb["Vz"].toString(),
                                  "timeStep": mb["timeStep"].toString(),
                                  "times": mb["numberTimes"].toString(),
                                  "tuningFrequency": mb["tuningFrequency"].toString(),
                                  "signalFrequency": mb["signalFrequency"].toString(),
                                  "snr": mb["snr"].toString(),
                                  "_checked": false})
            }
        }
        onSendSateTrail: {
            var sate = [];
            for(var i=0;i<data["time"].length;i++){
                var temp = {
                    "longitude": data["longitude"][i],
                    "dimension": data["dimension"][i],
                    "height": data["height"],
                    "time": data["time"][i]
                }
                sate.push(temp);
            }
            global.sateTrails[data["name"]] = sate;
            mapTimer.setTimeout(function(){
                mapObject.satePlay(data["name"], sate, data["time"][data["time"].length-1]/10);
            }, 3000);
        }
        onSendMbTrail: {
            var mb = [];
            for(var i=0;i<data["time"].length;i++){
                var temp = {
                    "longitude": data["longitude"][i],
                    "dimension": data["dimension"][i],
                    "height": data["height"],
                    "time": data["time"][i],
                    "sateName": data["sateName"],
                }
                mb.push(temp);
            }
            mapObject.mbPlay(data["name"], mb, data["time"][data["time"].length-1] / 10);
            global.mbTrails[data["name"] + data["mbId"]] = mb;
        }
        onSendInputOfRS: {
            for(var key in data){
                global.inputIQ[key] = data[key];
            }
        }
        onSendOutputOfRS: {
            for(var key in data){
                global.outputIQ[key] = data[key];
            }
        }
    }
}
