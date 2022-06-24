import QtQuick 2.6
import Toou2D 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1

Item {
    id: consoleMsg
    property ListModel mode
    property var color: Qt.rgba(40/255,40/255,40/255, 0.6);
    property var borderColor: "#304156"
    property var borderWidth: 1
    property var radius: 10
    Rectangle {
        height: parent.height;
        width: parent.width;
        color: parent.color;
        border.color: consoleMsg.borderColor
        border.width: consoleMsg.borderWidth
        radius: consoleMsg.radius

        Rectangle {
            height: parent.height * 0.12;
            width: parent.width * 0.14;
            color: Qt.rgba(0/255,0/255,0/255, 0.6);
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 5
            Label {
                z:2
                text: qsTr("系统消息")
                color: "#9BB3C7"
                font.pixelSize: 14
                font.family: "微软雅黑"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            TIconButton{
                icon.position: TPosition.Only;
                icon.source: TAwesomeType.FA_train;
                icon.color: "#9BB3C7"
                anchors.verticalCenter: parent.verticalCenter
                backgroundComponent: null;
                anchors.right: parent.right;
                anchors.rightMargin: 10
                onClicked: mode.clear();
            }
        }

        ListView {
            id: msgconsole
            height: parent.height * 0.75
            width: parent.width * 0.95
            anchors.centerIn: parent;
            model: mode
            delegate: Row {
                z:1
                spacing: 10
                Label {
                    text: msg
                    color: "#9BB3C7"
                    font.pixelSize: 14
                    font.family: "微软雅黑"

                }
            }
            //滚动条
            ScrollBar.vertical: ScrollBar {
                anchors.right: msgconsole.right
                width: 6
                active: true
                clip: true
                background: Item {            //滚动条的背景样式
                    Rectangle {
                        anchors.centerIn: parent
                        height: parent.height
                        width: parent.width * 0.1
                        color: '#606266'
                        radius: 3
                    }
                }

                contentItem: Rectangle {
                    radius: 2        //bar的圆角
                    color: '#9BB3C7'
                }
            }
        }
    }
}
