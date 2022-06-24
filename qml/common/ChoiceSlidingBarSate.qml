import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Toou2D 1.0

Item {
    signal suresate(var name, var index);
    signal canclesate(var name, var index);

    property ListModel mode;

    property var labelColor: "#9BB3C7";
    property var iconColor: "#9BB3C7";
    property var heardColor: "#0075FF";
    property var backgroundColor: "#21222C";

    ListView {
        id: satechoiceBar
        height: parent.height;
        width: parent.width;
        model: mode;

        delegate: Row {
            spacing: 20
            TCheckBox {
                id: satechecked
                label.text: ""
                checked: _checked;
                onCheckedChanged: {
                    if(satechecked.checked) {
                        mode.setProperty(index, "_checked", true);
                        suresate(name, index);
                    }else {
                        mode.setProperty(index, "_checked", false);
                        canclesate(name, index);
                    }
                }
            }
            TButton{
                id:a2
                backgroundComponent: null;
                label.text: name
                label.font_size: 18
                label.color: "#9BB3C7"
                anchors.verticalCenter: satechecked.verticalCenter
                onClicked: sateAtt.openToGlobal(a2,0,a2.height)
            }
            TPopoverMenu {
                id:sateAtt
                TPopoverElement{
                    text: "目标名称:" + name;
                }
                TPopoverElement{
                    text: "轨道高度(km):" + _height;
                }
                TPopoverElement{
                    text: "时间步进(s/次):" + timeStep;
                }
                TPopoverElement{
                    text: "次数:" + times;
                }
                TPopoverElement{
                    text: "距离(km):" + distance;
                }
            }
        }
        ScrollBar.vertical: ScrollBar {
            anchors.right: satechoiceBar.right
            width: 6
            active: true
            clip: true
            background: Item {
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width * 0.1
                    color: '#606266'
                    radius: 3
                }
            }
            contentItem: Rectangle {
                radius: 2
                color: '#9BB3C7'
            }
        }
    }
}
