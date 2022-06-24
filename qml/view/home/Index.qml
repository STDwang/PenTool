import QtQuick 2.6
import QtQuick.Window 2.0
import QtGraphicalEffects 1.0
import Toou2D 1.0

Item {

    Component.onCompleted: {
        if(global.databaseLogin){
            penToolSever.getProjectList();
            penToolSever.getSateList();
            penToolSever.getMbList();
        }
    }

    property var labelColor: "#CDD9D5"
    //背景视频
    AnimatedImage {
        anchors.fill: parent
        source: "qrc:/res/gif/homeVideo.gif"
    }
    //上方Menu按钮
    TopbarHome {
        id: homeTopMenu
        width: parent.width * 0.7
        height: parent.height * 0.08
        x: (parent.width - width) /2
        y: parent.height * 0.05
    }

    //中间部分
    Column{
        spacing: 30
        anchors.centerIn: parent;

        TLabel{
            text: "Hello PenTool";
            color: "#316DCA"
            font.pixelSize: 40;
            font.bold: true;
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        TButton{
            width: 150;
            label.text: "Start"
            label.font.pixelSize: 18;
            label.font.bold: true;
            label.color: labelColor

            backgroundComponent: Rectangle{
                anchors.fill: parent
                color: "#316DCA"
                radius: 10
            }
            label.font_size: 24
            anchors.horizontalCenter: parent.horizontalCenter;
            onClicked: begin();
        }
    }

    //右侧卡片背景载体
    Rectangle{
        id: rightCard
        anchors.verticalCenter: parent.verticalCenter
        x: leftmenu.isopen ? parent.width * 0.6 : parent.width * 0.7;
        width: parent.width * 0.26
        height: parent.height * 0.64
        color: Qt.rgba(40/255,42/255,54/255, 0.6)
        radius: 10
        visible: topbar.title === "Home" ? true : false
        MouseArea{
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered: {
                parent.border.color = Qt.rgba(1,1,1, 0.6);
                parent.border.width = 1
            }
            onExited: {
                parent.border.width = 0
            }
        }

        Behavior on x {
            NumberAnimation {
                duration: 100
            }
        }
    }

    //阴影
    DropShadow {
        color: "#1E1E1E"
        anchors.fill: rightCard
        //生成阴影的源的源项
        source: rightCard
        //半径定义了阴影的柔和度。 较大的半径会导致阴影的边缘显得更加模糊。
        radius: 32
        //指定生成阴影时阴影的每个像素由多少个采样点产生，采样点越多阴影效果越好，不过也越慢。一般可以把这个值设置为 radius的2倍。
        samples: 32
        //在源边缘附近增强了多少阴影颜色。值范围从 0.0 到 1.0。 默认为 0.5。
        spread: 0
        //水平偏移 / 垂直偏移。值范围从 -inf 到 inf。默认为 0。
        horizontalOffset: 10
        verticalOffset: 10
        visible: topbar.title === "Home" ? true : false
    }

    //登录卡片
    CardLogin {
        anchors.fill: rightCard
        visible: (topbar.title === "Home" && global.databaseLogin === false) ? true:false;
        onSubmit: {
            if(penToolSever.sqliteLogin()){
                penToolSever.getProjectList();
                penToolSever.getSateList();
                penToolSever.getMbList();
                global.databaseLogin = true;
                TToast.showSuccess("登录成功",TTimePreset.LongTime4s, "please begin project or use sqlite database.");
            }else{
                TToast.showWarning("登录失败",TTimePreset.ShortTime2s);
            }
        }
        onQuickBegin: {
            if(penToolSever.sqliteLogin()){
                penToolSever.getProjectList();
                penToolSever.getSateList();
                penToolSever.getMbList();
                global.databaseLogin = true;
                TToast.showSuccess("登录成功",TTimePreset.LongTime4s, "please begin project or use sqlite database.");
            }else{
                TToast.showWarning("登录失败",TTimePreset.ShortTime2s);
            }
        }

        Component.onCompleted: {
            if(global.databaseLogin){
                penToolSever.getProjectList();
                penToolSever.getSateList();
                penToolSever.getMbList();
                return;
            }
        }
    }

    //项目卡片
    CardProject {
        anchors.fill: rightCard
        visible: (topbar.title === "Home" && global.databaseLogin === true) ? true:false;

        //选中项目后前往View界面
        onToView: {
            toPage("qrc:/qml/view/play/Index.qml", projectName);
        }
        //返回登录
        onBack: {
            global.databaseLogin = false;
        }
    }
}
