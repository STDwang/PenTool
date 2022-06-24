import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Toou2D 1.0

Item {
    signal sureMb(var mb);
    signal cancleMb(var mb);

    property ListModel mode;

    property var labelColor: "#9BB3C7";
    property var iconColor: "#9BB3C7";
    property var heardColor: "#0075FF";
    property var backgroundColor: "#21222C";

//    property ListModel formModel;

//    Component.onCompleted: {
//        formModel.clear();
//        for(var i=0;i<mode.count;i++){
//            formModel.append(mode.get(i));
//            formModel.setProperty(i, "checked", false)
//        }
//    }

    ListView {
        id: attform1
        height: parent.height * 0.96
        width: parent.width
        model: mode

        delegate: Row {
            spacing: 20
            TCheckBox {
                id: mbchecked
                label.text: ""
                checked: _checked;

                onCheckedChanged: {
                    if(mbchecked.checked) {
                        mode.setProperty(index, "_checked", true)
                        sureMb(mode.get(index));
                    }else{
                        mode.setProperty(index, "_checked", false)
                        cancleMb(mode.get(index));
                    }
                }
            }

            TButton{
                id:b2
                backgroundComponent: null;
                label.text: name
                label.font_size: 18
                label.color: labelColor
                anchors.verticalCenter: mbchecked.verticalCenter
                onClicked: mbAtt.openToGlobal(b2,0,b2.height)
            }

            TPopoverMenu {
                id:mbAtt
                TPopoverElement{
                    text: "目标名称:" + name;
                }
                TPopoverElement{
                    text: "初始经纬度(°):(" + longitude + "," + latitude + ")";
                }
                TPopoverElement{
                    text: "高度(m):" + _height;
                }
                TPopoverElement{
                    text: "VxVyVz(m/s):(" + Vx + "," + Vy + "," + Vz + ")";
                }
                TPopoverElement{
                    text: "时间步进(s/次):" + timeStep;
                }
                TPopoverElement{
                    text: "次数:" + times;
                }
                TPopoverElement{
                    text: "调谐频率:" + tuningFrequency;
                }
                TPopoverElement{
                    text: "信号频率:" + signalFrequency;
                }
                TPopoverElement{
                    text: "信噪比:" + snr;
                }
            }
        }

        //滚动条
        ScrollBar.vertical: ScrollBar {
            anchors.right: attform1.right
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
