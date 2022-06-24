import QtQuick 2.6
import Toou2D 1.0

TFlickable{
    scrollBar.horizontal: false;
    scrollBar.autoHide: false;
    contentWidth: width;
    contentHeight: col.height;

    property var titleobj: {
                "name" :                "项目名称",
                "sateName":             "场景名称",
                "modulation":           "调制方法",
                "nosurearg":            "调制频率(k)/符号速率(k)/间隙(ms)",
                "outputSamplingRate":   "输出采样率",
                "allTime":              "总时间",
                "func" :                "操作"
    }

    property TObject projectForm: TObject{
        property var projectId:             "";
        property var name:                  "";
        property var sateName:              "";
        property var modulation:            "";
        property var nosurearg:             "";
        property var outputSamplingRate:    "";
        property var allTime:               "";
    }

    EditProjectDia {
        id: editprojectdia;
    }

    TDialog{
        id: deleteprojectDia

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
                        onClicked: deleteprojectDia.hideAndClose();
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
                            var projectFormData = {
                                "projectId": projectForm.projectId,
                                "name": projectForm.name,
                                "sateName": projectForm.sateName,
                                "modulation":  projectForm.modulation,
                                "nosurearg":  projectForm.nosurearg,
                                "outputSamplingRate":  projectForm.outputSamplingRate,
                                "allTime":  projectForm.allTime,
                                "editTime": Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                            }
                            penToolSever.deleteProject(projectFormData);
                            deleteprojectDia.close();
                            penToolSever.getProjectList();
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
                            deleteprojectDia.close()
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
                    width: parent.width * 0.06;
                    height: parent.height;
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
                        text: titleobj.sateName;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.modulation;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.14;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.nosurearg;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.06;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.outputSamplingRate;
                        anchors.centerIn: parent;
                    }
                }
                Item{
                    width: parent.width * 0.1;
                    height:  parent.height;
                    TLabel {
                        text: titleobj.allTime;
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
            model: projectdata
            delegate:  Item{
                width: col.width;
                height: 35;

                TRectangle{
                    theme.groupName: "musiclistbg"
                    anchors.fill: parent;
                    color:  Number(model.projectId) %2 === 0 ? "#F8F8F8":"#FEFEFE"
                    state:  Number(model.projectId) %2 === 0 ? "none":"highlight"
                }

                Row{
                    width: parent.width;
                    anchors.horizontalCenter: parent.horizontalCenter;
                    height: parent.height;

                    Item{
                        width: parent.width * 0.06;
                        height: parent.height;
                        TLabel {
                            text: model.projectId;
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
                            text: model.sateName;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.modulation;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.14;
                        height:  parent.height;
                        TLabel {
                            text: model.nosurearg;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.06;
                        height:  parent.height;
                        TLabel {
                            text: model.outputSamplingRate;
                            anchors.centerIn: parent;
                        }
                    }
                    Item{
                        width: parent.width * 0.1;
                        height:  parent.height;
                        TLabel {
                            text: model.allTime;
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
                                projectForm.projectId = model.projectId;
                                projectForm.name = model.name;
                                projectForm.sateName = model.sateName;
                                projectForm.modulation = model.modulation;
                                projectForm.nosurearg = model.nosurearg;
                                projectForm.outputSamplingRate = model.outputSamplingRate;
                                projectForm.allTime = model.allTime;
                                editprojectdia.open();
                            }
                        }
                        TIconButton{
                            backgroundComponent: null;
                            anchors.right: parent.right
                            anchors.rightMargin: parent.width * 0.2
                            icon.width: 20;
                            icon.height: 20;
                            icon.source: TAwesomeType.FA_trash
                            icon.position: TPosition.Only;
                            onClicked: {
                                projectForm.projectId = model.projectId;
                                projectForm.name = model.name;
                                projectForm.sateName = model.sateName;
                                projectForm.modulation = model.modulation;
                                projectForm.nosurearg = model.nosurearg;
                                projectForm.outputSamplingRate = model.outputSamplingRate;
                                projectForm.allTime = model.allTime;
                                deleteprojectDia.open()
                            }
                        }
                    }
                }
            }
        }
    }
}
