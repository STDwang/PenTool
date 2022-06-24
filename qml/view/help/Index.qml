import QtQuick 2.6
import Toou2D 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1
import QtWebView 1.1
import QtWebEngine 1.4

Item {
    Rectangle {
        height: parent.height * 0.94
        width: parent.width * 0.98
        radius: 10
        color: "#282A36"
        anchors.centerIn: parent;

        Rectangle {
            id: configtitle
            height: parent.height * 0.12
            width: parent.width - 40
            color: "#303240"
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top: parent.top;
            anchors.topMargin: 20
            TLabel {
                text: "帮助文档"
                color: "#9BB3C7"
                font.pixelSize: 28
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 20
            }

            TButton{
                width: 90;
                height: 36;
                label.text: "返回"
                label.font.family: "微软雅黑"
                label.color: "white"
                anchors.verticalCenter: parent.verticalCenter;
                anchors.right: parent.right;
                anchors.rightMargin: 20
                visible: helpView.url == "qrc:/doc/PenTool.html"||helpView.url == "qrc:/doc/README.html" ? false:true
                backgroundComponent: Rectangle{
                    anchors.fill: parent
                    color: "#0075FF"
                    radius: 10
                }
                onClicked: {
                    if(global.language == "english"){
                        helpView.url = "qrc:/doc/README.html"
                    }else{
                        helpView.url = "qrc:/doc/PenTool.html"
                    }
                }
            }
        }

        TBusyIndicator{
            id:bi;
            anchors.centerIn: parent;
        }

        WebEngineView {
            id: helpView
            anchors{
                left:  parent.left;
                leftMargin: 20;
                right: parent.right;
                rightMargin: 20;
                top: configtitle.bottom;
                topMargin: 20;
                bottom: parent.bottom;
                bottomMargin: 20;
            }
            url: global.language == "english" ? "qrc:/doc/README.html":"qrc:/doc/PenTool.html"
        }
    }
}
