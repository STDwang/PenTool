import QtQuick 2.6
import Toou2D 1.0

TFlickable{
    scrollBar.horizontal: false;
    scrollBar.autoHide: false;
    contentWidth: width;
    contentHeight: col.height;

    property var titleobj: {
        "name" :        "场景名称",
        "_height" :      "轨道高度",
        "timeStep" :    "时间步进",
        "times" :       "次数",
        "distance" :    "距离",
        "satenumbers" : "卫星个数",
        "fixPD" :       "是否修正相差",
        "xlsx" :        "测向阵文件",
        "func" :        "操作",
    }

    property TObject sateForm: TObject{
        property var sateId:                "";
        property var name:                  "";
        property var _height:                "";
        property var timeStep:              "";
        property var times:                 "";
        property var distance:              "";
        property var satenumbers:           "";
        property var fixPD:                 "";
        property var xlsx:                  "";
    }

    EditSateDia {
        id: editsatedia;
    }

    TDialog{
        id: deleteSateDia

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
                        onClicked: deleteSateDia.hideAndClose();
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
                            console.log(sateForm.sateId)
                            var sateFormData = {
                                "sateId": sateForm.sateId,
                                "name": sateForm.name,
                                "height": sateForm._height,
                                "timeStep":  sateForm.timeStep,
                                "numberTimes":  sateForm.times,
                                "distance":  sateForm.distance,
                                "satenumbers":  sateForm.satenumbers,
                                "fixPD": sateForm.fixPD,
                                "xlsx": sateForm.xlsx
                            }
                            penToolSever.deleteSate(sateFormData);
                            deleteSateDia.close();
                            penToolSever.getSateList();
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
                            deleteSateDia.close()
                        }
                    }
                }
            }
        }
    }

    Column{
        id:col;
        width: parent.width;

        Item {
            width: col.width;
            height: 35;

            TRectangle{
                theme.groupName: "musiclistbg"
                anchors.fill: parent;
                color:  "#F8F8F8"
                state:  "none"
            }
            Row {
                width: parent.width;
                anchors.horizontalCenter: parent.horizontalCenter;
                height: parent.height;
                Item{
                    width: parent.width * 0.06
                    height: 1
                }
                Item{
                    width: parent.width * 0.14;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.name;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj._height;
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
                    width: parent.width * 0.1;
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
                        text: titleobj.distance;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.satenumbers;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.fixPD;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.xlsx;
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
            model: satedata

            delegate:  Item {
                width: col.width;
                height: 35;

                TRectangle{
                    theme.groupName: "musiclistbg"
                    anchors.fill: parent;
                    color:  Number(model.sateId) % 2 === 0 ? "#F8F8F8":"#FEFEFE"
                    state:  Number(model.sateId) === 0 ? "none":"highlight"
                }

                Row{
                    width: parent.width;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height;

                    Item{
                        width: parent.width * 0.06;
                        height: parent.height;
                        TLabel {
                            text: model.sateId;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.14;
                        height:  parent.height;

                        TLabel {
                            text: model.name;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model._height;
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
                        width: parent.width * 0.1;
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
                            text: model.distance;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.satenumbers;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.fixPD;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.xlsx;
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
                                sateForm.sateId = model.sateId;
                                sateForm.name = model.name;
                                sateForm._height = model._height;
                                sateForm.timeStep = model.timeStep;
                                sateForm.times = model.times;
                                sateForm.distance = model.distance;
                                sateForm.satenumbers = model.satenumbers;
                                sateForm.fixPD = model.fixPD;
                                sateForm.xlsx = model.xlsx;
                                editsatedia.open();
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
                                sateForm.sateId = model.sateId;
                                sateForm.name = model.name;
                                sateForm._height = model._height;
                                sateForm.timeStep = model.timeStep;
                                sateForm.times = model.times;
                                sateForm.distance = model.distance;
                                sateForm.satenumbers = model.satenumbers;
                                sateForm.fixPD = model.fixPD;
                                sateForm.xlsx = model.xlsx;
                                deleteSateDia.open()
                            }
                        }
                    }
                }
            }
        }
    }
}
