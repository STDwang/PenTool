import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import Toou2D 1.0
import "../../../common"

TDialog{
    id: editsatedia

    property var bodyColor:             "#282A36";
    property var labelColor:            "#9BB3C7";//#9BB3C7
    property var headerColor:           "#0075FF";
    property var iconColor:             "white";//#9BB3C7
    property var inputBackgroundColor:  "#30323D";
    property var textAreaColor:         "#1C2128";
    property var backgroundColor:       "#347D39";
    property var diaBackgroundColor:    "#282A36";
    property var borderColor:           "#9BB3C7";//#606266
    property var fontfamily:            "微软雅黑";
    property var labelPixSize:          16;
    property var rowHeight:             30;
    property var rowWidth:              450;
    property var radiusNumber:          5;


    bodyComponent:  TRectangle{
        theme.enabled: false;
        color: bodyColor
        width: 500;
        height: 500;
        radius: radiusNumber

        ListModel {
            id: mbChoiceModel
        }

        Column{
            spacing: 12;
            width: parent.width;

            Item{
                width: parent.width;
                height: 12;

                TIconButton{
                    icon.position: TPosition.Only;
                    icon.source: TAwesomeType.FA_close;
                    icon.color: iconColor
                    backgroundComponent: null;
                    anchors.right: parent.right;
                    onClicked: editsatedia.hideAndClose();
                }
            }

            Label {
                text: qsTr("新增场景")
                color: headerColor
                font.pixelSize: 28
                font.family: fontfamily
                anchors.left: parent.left;
                anchors.leftMargin: parent.width * 0.08
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 20
                Label {
                    id: sateNameLabel
                    text: qsTr("场景名称:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                TInputField{
                    id: sateName;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm.name

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入场景名称";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: sateNameLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 20
                Label {
                    id: sateheightLabel
                    text: qsTr("轨道高度:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                TInputField{
                    id:sateheight;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm._height

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入轨道高度";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: sateheightLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Label {
                    id: timeStepLabel
                    text: qsTr("时间步进:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                TInputField{
                    id:timeStep;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm.timeStep

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入时间步进";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: timeStepLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Label {
                    id: timesLabel
                    text: qsTr("次数:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - timesLabel.width - times.width - 40
                    height: 1
                }

                TInputField{
                    id:times;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm.times

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入次数";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: timesLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Label {
                    id: distanceLabel
                    text: qsTr("距离:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - distanceLabel.width - distance.width - 40
                    height: 1
                }

                TInputField{
                    id:distance;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm.distance

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入距离";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: distanceLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Label {
                    id: satenumbersLabel
                    text: qsTr("卫星个数:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                TInputField{
                    id:sateNumbers;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: sateForm.satenumbers

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入卫星个数";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: satenumbersLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter

                TSwitch {
                    id: fixPD
                    background.color: "#505254"
                    checked: sateForm.fixPD

                    TLabel {
                        text: qsTr("卫星相差修正")
                        anchors.left: parent.right
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: labelPixSize
                        color: "#CDD9D5"
                    }
                }
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                height: rowHeight
                width: rowWidth
                spacing: 20
                visible: fixPD.checked ? true:false
                Label {
                    id: cxzLabel
                    text: qsTr("测向阵:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - cxzLabel.width - cxz.width - addCxzButton.width - 3 * parent.spacing
                    height: 1
                }

                PenComboBox {
                    id: cxz
                    height: sateName.height
                    width: parent.width * 0.6
                    fontSize: 12
                    textColor: labelColor
                    backgoundColor: inputBackgroundColor
                    backgoundRadius: radiusNumber
                    anchors.verticalCenter: parent.verticalCenter
                    model: global.cxzList
                    displayText: sateForm.xlsx
                }

                TIconButton{
                    id: addCxzButton
                    icon.source: TAwesomeType.FA_upload;
                    icon.color: iconColor
                    label.text: qsTr("添加")
                    label.color: "white"
                    height: sateName.height
                    backgroundComponent: Rectangle{
                        anchors.fill: parent
                        color: backgroundColor
                        radius: radiusNumber
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        console.log("添加文件")
                    }
                }
            }

            Item {
                height: 1
                width: 1
            }

            Row {
                spacing: parent.width * 0.3
                anchors.horizontalCenter: parent.horizontalCenter
                TButton{
                    width: 90;
                    height: 36;
                    label.text: "确定"
                    label.font.family: fontfamily
                    label.color: "white"
                    backgroundComponent: Rectangle{
                        anchors.fill: parent
                        color: headerColor
                        radius: radiusNumber
                    }

                    onClicked: {
                        var sateFormData = {
                            "sateId": sateForm.sateId,
                            "name": sateName.text,
                            "height": sateheight.text,
                            "timeStep":  timeStep.text,
                            "numberTimes": times.text,
                            "distance": distance.text,
                            "satenumbers":  sateNumbers.text,
                            "fixPD": fixPD.checked,
                            "xlsx": cxz.displayText
                        }
                        penToolSever.editSate(sateFormData);
                        editsatedia.close();
                        penToolSever.getSateList();
                    }
                }

                TButton{
                    width: 90;
                    height: 36;
                    label.text: "取消"
                    label.font.family: fontfamily
                    label.color: "white"
                    backgroundComponent: Rectangle{
                        anchors.fill: parent
                        border.color: headerColor
                        color: "#7B93B8"
                        border.width: 2
                        radius: radiusNumber
                    }

                    onClicked: {
                        editsatedia.close();
                    }
                }
            }
        }
    }
}
