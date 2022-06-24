import QtQuick 2.6
import Toou2D 1.0
import QtQuick.Window 2.2

TRectangle{
    signal showMenu();
    color: "#2D333B"
    property string title: "Home";
    theme.groupName: "topbar"


    Row {
        anchors.centerIn: parent;
        spacing: 10
        TImage {
            width: 20
            height: 20
            source: "qrc:/res/png/sate(1).png"
            anchors.verticalCenter: parent.verticalCenter
        }
        TLabel {
            text: title
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: TPixelSizePreset.PH4
            color: "#CDD9D5"
            font.bold: true
        }
    }

    //记录鼠标移动的位置，此处变量过多会导致移动界面变卡
    property point clickPos: "0,0"

    //处理鼠标移动后窗口坐标逻辑
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton  //只处理鼠标左键
        onDoubleClicked: {
            if(root.visibility === Window.Maximized){
                root.showNormal();          //窗口平时态
                maxWinButton.icon.source = "qrc:/res/svg/max.svg";
            }else {
                root.showMaximized()        //窗口最大化
                maxWinButton.icon.source = "qrc:/res/svg/min.svg";
            }
        }

        onPressed: {    //鼠标左键按下事件
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: {    //鼠标位置改变
            //计算鼠标移动的差值
            var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
            //设置窗口坐标
            root.setX(root.x + delta.x)
            root.setY(root.y + delta.y)
        }
    }

    TIconButton{
        width: height;
        height: parent.height -1;
        anchors.left: parent.left;
        icon.source: TAwesomeType.FA_list;
        icon.position: TPosition.Only;
        icon.color: "#CDD9D5"
        backgroundComponent: null;
        theme.groupName: "topbarbtn"
        onClicked: showMenu();
    }

    Row {
        spacing: 10
//        anchors.right: parent.right;
        x: leftmenu.isopen ? parent.width * 0.8 : parent.width * 0.9;
        Behavior on x {
            NumberAnimation {
                duration: 100
            }
        }
        //最小化窗口按钮
        TIconButton{
            id:minWinButton
            icon.position: TPosition.Only;
            icon.source: "qrc:/res/svg/hide.svg";
            icon.color: "#9BB3C7"
            backgroundComponent: null;
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                root.showMinimized()        //窗口最小化
            }
        }
        //最大化窗口按钮
        TIconButton{
            id:maxWinButton
            icon.position: TPosition.Only;
            icon.source: "qrc:/res/svg/max.svg";
            icon.color: "#9BB3C7"
            backgroundComponent: null;
            anchors.verticalCenter: minWinButton.verticalCenter
            onClicked: {
                if(root.visibility === Window.Maximized){
                    root.showNormal();          //窗口平时态
                    maxWinButton.icon.source = "qrc:/res/svg/max.svg";
                }else {
                    root.showMaximized()        //窗口最大化
                    maxWinButton.icon.source = "qrc:/res/svg/min.svg";
                }
            }
        }
        //关闭窗口按钮
        TIconButton{
            id:closeWinButton
            icon.position: TPosition.Only;
            icon.source: "qrc:/res/svg/close.svg";
            icon.color: "#9BB3C7"
            backgroundComponent: null;
            anchors.verticalCenter: minWinButton.verticalCenter
            onClicked: {
                Qt.quit();               //退出程序
            }
        }
    }
}
