import QtQuick 2.6
import Toou2D 1.0

TFlickable{
    scrollBar.horizontal: false;
    scrollBar.autoHide: false;
    contentWidth: width;
    contentHeight: col.height;

    property var titleobj: {
        "name" :                "目标名称",
        "longitude" :           "经度(°)",
        "latitude" :            "纬度(°)",
        "_height" :              "高度(m)",
        "Vx" :                  "x轴速度(m/s)",
        "Vy" :                  "y轴速度(m/s)",
        "Vz" :                  "z轴速度(m/s)",
        "timeStep" :            "时间步进(s/次)",
        "times" :               "次数",
        "tuningFrequency" :     "调谐频率(MHz)",
        "signalFrequency" :     "信号频率(MHz)",
        "snr" :                 "是否修正相差",
        "func" :                "操作",
    }

    property TObject mbForm: TObject{
        property var mbId:            "";
        property var name:            "";
        property var longitude:       "";
        property var latitude:        "";
        property var _height:          "";
        property var vx:              "";
        property var vy:              "";
        property var vz:              "";
        property var timeStep:        "";
        property var times:           "";
        property var tuningFrequency: "";
        property var signalFrequency: "";
        property var snr:             "";
    }

    EditMbDia {
        id: editmbdia;
    }

    TDialog{
        id: deletembDia

        bodyComponent:  TRectangle{
            theme.enabled: false;
            color: "#282A36"
            width: 400;
            height: 200;
            radius: 10

            Column{
                spacing: 40;
                width: parent.width;
                Item{
                    width: parent.width;
                    height: 12;

                    TIconButton{
                        icon.position: TPosition.Only;
                        icon.source: TAwesomeType.FA_close;
                        icon.color: "white"
                        backgroundComponent: null;
                        anchors.right: parent.right;
                        onClicked: deletembDia.hideAndClose();
                    }
                }
                Text {
                    text: qsTr("确定删除该场景吗？")
                    color: "#0075FF"
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
                Row {
                    spacing: parent.width * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    TButton{
                        width: 90;
                        height: 36;
                        label.text: "确定"
                        label.font.family: "微软雅黑"
                        label.color: "white"
                        backgroundComponent: Rectangle{
                            anchors.fill: parent
                            color: "#0075FF"
                            radius: 5
                        }
                        onClicked: {
                            var mbFormData = {
                                "mbId": mbForm.mbId,
                                "name": mbForm.name,
                                "longitude": mbForm.longitude,
                                "latitude": mbForm.latitude,
                                "height": mbForm._height,
                                "Vx": mbForm.vx,
                                "Vy": mbForm.vy,
                                "Vz": mbForm.vz,
                                "timeStep": mbForm.timeStep,
                                "numberTimes": mbForm.times,
                                "tuningFrequency": mbForm.tuningFrequency,
                                "signalFrequency": mbForm.signalFrequency,
                                "snr": mbForm.snr
                            }
                            penToolSever.deleteMb(mbFormData);
                            deletembDia.close();
                            penToolSever.getMbList();
                        }
                    }

                    TButton{
                        width: 90;
                        height: 36;
                        label.text: "取消"
                        label.font.family: "微软雅黑"
                        label.color: "white"
                        backgroundComponent: Rectangle{
                            anchors.fill: parent
                            border.color: "#0075FF"
                            color: "#7B93B8"
                            border.width: 2
                            radius: 5
                        }
                        onClicked: {
                            console.log(mbForm.mbId);
                            deletembDia.close();
                        }
                    }
                }
            }
        }
    }

    Column{
        id:col;
        width: parent.width;

        Item{
            width: col.width;
            height: 35;

            TRectangle{
                theme.groupName: "musiclistbg"
                anchors.fill: parent;
                color: "#F8F8F8"
                state: "none"
            }

            Row{
                width: parent.width;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: parent.height;
                Item{
                    width: parent.width * 0.05;
                    height: parent.height;
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.name;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.05;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.longitude;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.05;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.latitude;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.05;
                    height:  parent.height;
                    TLabel {
                        text: titleobj._height;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.06;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.Vx;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.06;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.Vy;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.06;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.Vz;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.timeStep;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.05;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.times;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.tuningFrequency;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.signalFrequency;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.05;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.snr;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.func;
                        anchors.centerIn: parent;
                    }
                }
            }
        }

        Repeater{
            id:rep
            model: mbdata
            delegate:  Item{
                width: col.width;
                height: 35;

                TRectangle{
                    theme.groupName: "musiclistbg"
                    anchors.fill: parent;
                    color:  Number(model.mbId) % 2 === 0 ? "#F8F8F8":"#FEFEFE"
                    state:  Number(model.mbId) % 2 === 0 ? "none":"highlight"
                }

                Row{
                    width: parent.width;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height;

                    Item{
                        width: parent.width * 0.05;
                        height: parent.height;
                        TLabel {
                            text: model.mbId;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;

                        TLabel {
                            text: model.name;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.05;
                        height:  parent.height;
                        TLabel {
                            text: model.longitude;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.05;
                        height:  parent.height;
                        TLabel {
                            text: model.latitude;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.05;
                        height:  parent.height;
                        TLabel {
                            text: model._height;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.06;
                        height:  parent.height;
                        TLabel {
                            text: model.Vx;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.06;
                        height:  parent.height;
                        TLabel {
                            text: model.Vy;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.06;
                        height:  parent.height;
                        TLabel {
                            text: model.Vz;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.timeStep;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.05;
                        height:  parent.height;
                        TLabel {
                            text: model.times;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.tuningFrequency;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.signalFrequency;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.05;
                        height:  parent.height;
                        TLabel {
                            text: model.snr;
                            anchors.centerIn: parent;
                        }
                    }

                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TIconButton{
                            backgroundComponent: null;
                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.2
                            icon.width: 20;
                            icon.height: 20;
                            icon.position: TPosition.Only;
                            icon.source: TAwesomeType.FA_edit
                            onClicked: {
                                mbForm.mbId = model.mbId;
                                mbForm.name = model.name;
                                mbForm.longitude = model.longitude;
                                mbForm.latitude = model.latitude;
                                mbForm._height = model._height;
                                mbForm.vx = model.Vx;
                                mbForm.vy = model.Vy;
                                mbForm.vz = model.Vz;
                                mbForm.timeStep = model.timeStep;
                                mbForm.times = model.times;
                                mbForm.tuningFrequency = model.tuningFrequency;
                                mbForm.signalFrequency = model.signalFrequency;
                                mbForm.snr = model.snr;
                                editmbdia.open();
                            }
                        }
                        TIconButton{
                            height: parent.height
                            backgroundComponent: null;
                            anchors.right: parent.right
                            anchors.rightMargin: parent.width * 0.2
                            icon.width: 20;
                            icon.height: 20;
                            icon.source: TAwesomeType.FA_trash
                            icon.position: TPosition.Only;
                            onClicked: {
                                mbForm.mbId = model.mbId;
                                mbForm.name = model.name;
                                mbForm.longitude = model.longitude;
                                mbForm.latitude = model.latitude;
                                mbForm._height = model._height;
                                mbForm.vx = model.Vx;
                                mbForm.vy = model.Vy;
                                mbForm.vz = model.Vz;
                                mbForm.timeStep = model.timeStep;
                                mbForm.times = model.times;
                                mbForm.tuningFrequency = model.tuningFrequency;
                                mbForm.signalFrequency = model.signalFrequency;
                                mbForm.snr = model.snr;
                                deletembDia.open()
                            }
                        }
                    }
                }
            }
        }
    }
}
