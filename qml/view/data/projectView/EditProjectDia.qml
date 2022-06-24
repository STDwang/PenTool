import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import Toou2D 1.0
import "../../../common"

TDialog{
    id:editprojectdia

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
        height: 620;
        radius: radiusNumber

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
                    onClicked: editprojectdia.hideAndClose();
                }
            }

            Label {
                text: qsTr("修改项目")
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
                    id: projectNameLabel
                    text: qsTr("项目名称:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                TInputField{
                    id:projectName;
                    height: parent.height
                    background.radius: radiusNumber;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.8
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: projectForm.name;

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入项目名称";
                    placeholderLabel.color: labelColor
                    border.color: borderColor
                    border.width: 0
                    anchors.verticalCenter: projectNameLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                Label {
                    id: sceneLabel
                    text: qsTr("场景设置:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                PenComboBox {
                    id: sateName
                    height: rowHeight
                    width: rowWidth * 0.8
                    fontSize: 12
                    textColor: labelColor
                    backgoundColor: inputBackgroundColor
                    backgoundRadius: radiusNumber
                    anchors.verticalCenter: sceneLabel.verticalCenter
                    displayText: projectForm.sateName;
                    model: getsatename()

                    function getsatename(){
                        var out = [];
                        for(var i=0;i<satedata.count;i++){
                            out.push(satedata.get(i).name)
                        }
                        return out;
                    }
                    onDisplayTextChanged: {
                        newsateModel.clear();
                        for(var i=0;i<satedata.count;i++){
                            if(satedata.get(i).name === sateName.displayText){
                                for(var j=0;j<Number(satedata.get(i).satenumbers);j++){
                                    newsateModel.append(satedata.get(i));
                                    newsateModel.setProperty(j, "name", "卫星" + (j+1).toString());
                                    newsateModel.setProperty(j, "_checked", true);
                                }
                                break;
                            }
                        }
                        satechoiceBar.mode=satedata;
                        satechoiceBar.mode=newsateModel;
                    }
                }
            }

            Rectangle {
                height: parent.height * 0.36
                width: rowWidth
                color: "#21222C"
//                border.color: borderColor
                anchors.horizontalCenter: parent.horizontalCenter
                radius: radiusNumber

                Rectangle {
                    height: parent.height * 0.1;
                    width: parent.width * 0.2
                    color: borderColor
                    anchors.horizontalCenter: parent.horizontalCenter
                    Label {
                        text: qsTr("场景详情")
                        color: "#21222C"
                        font.pixelSize: 12
                        font.family: fontfamily
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    radius: radiusNumber
                }

//                ListModel {
//                    id: editmbChoiceModel
//                }

//                ChoiceSlidingBarMb {
//                    id: mbchoiceBar
//                    height: parent.height * 0.7
//                    width: parent.width
//                    anchors.verticalCenter: parent.verticalCenter
//                    mode: editmbChoiceModel

//                    function getChecked(){
//                        var i=0;
//                        var mbListTemp = projectForm.mbList.split(",");
//                        var mbMap = {};
//                        for(i=0;i<mbdata.count;i++){
//                            mbMap[mbdata.get(i).name] = false;
//                        }
//                        for(i=0; i<mbListTemp.length;i++){
//                            mbMap[mbListTemp[i]] = true;
//                        }

//                        editmbChoiceModel.clear();
//                        for(i=0;i<mbdata.count;i++){
//                            editmbChoiceModel.append(mbdata.get(i));
//                            editmbChoiceModel.setProperty(i, "checked", false);
//                        }
//                        for(i=0;i<mbdata.count;i++){
//                            editmbChoiceModel.get(i).checked = mbMap[mbdata.get(i).name];
//                        }
//                    }

//                    Component.onCompleted: {
//                        getChecked();
//                    }
//                }
                ListModel {
                    id: newsateModel
                }

                ChoiceSlidingBarSate {
                    id: satechoiceBar
                    height: parent.height * 0.7
                    width: parent.width * 0.94
                    anchors.centerIn: parent
                    mode: newsateModel
                    Component.onCompleted: {
                        newsateModel.clear();
                        for(var i=0;i<satedata.count;i++){
                            if(satedata.get(i).name === sateName.displayText){
                                for(var j=0;j<Number(satedata.get(i).satenumbers);j++){
                                    newsateModel.append(satedata.get(i));
                                    newsateModel.setProperty(j, "name", "卫星" + (j+1).toString());
                                    newsateModel.setProperty(j, "_checked", true);
                                }
                                break;
                            }
                        }
                    }
                }
            }

            Row {
                id: modulationRow
                anchors.horizontalCenter: parent.horizontalCenter
                height: rowHeight
                width: rowWidth
                spacing: 20
                Label {
                    id: modulationLabel
                    text: qsTr("调制方法:");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                PenComboBox {
                    id: modulation
                    height: rowHeight
                    width: rowWidth * 0.56
                    fontSize: 12
                    textColor: labelColor
                    backgoundColor: inputBackgroundColor
                    backgoundRadius: radiusNumber
                    anchors.verticalCenter: modulationLabel.verticalCenter
                    model: global.modulationList
                    displayText: projectForm.modulation
                }

                TIconButton{
                    id: modulationButton
                    icon.source: TAwesomeType.FA_upload;
                    icon.color: iconColor
                    label.text: qsTr("添加")
                    label.color: "white"
                    height: parent.height
                    width: parent.width * 0.2
                    backgroundComponent: Rectangle{
                        anchors.fill: parent
                        color: backgroundColor
                        radius: 10
                    }
                    anchors.verticalCenter: modulationLabel.verticalCenter
                    onClicked: {
                        console.log("添加文件")
                    }
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: nosureargLabel
                    text: qsTr("调制频率(k)/符号速率(k)/间隙(ms):");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - nosureargLabel.width - nosurearg.width;
                    height: 1
                }

                TInputField{
                    id:nosurearg;
                    background.radius: 10;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.28
                    height: parent.height
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: projectForm.nosurearg

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入参数";
                    placeholderLabel.color: labelColor
                    border.width: 0
                    anchors.verticalCenter: nosureargLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: outputSamplingRateLabel
                    text: qsTr("输出采样率(k):");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - outputSamplingRateLabel.width - outputSamplingRate.width;
                    height: 1
                }

                TInputField{
                    id:outputSamplingRate;
                    background.radius: 10;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.28
                    height: parent.height
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: projectForm.outputSamplingRate

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入参数";
                    placeholderLabel.color: labelColor
                    border.width: 0
                    anchors.verticalCenter: outputSamplingRateLabel.verticalCenter
                    theme.enabled: false;
                }
            }

            Row {
                height: rowHeight
                width: rowWidth
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: allTimeLabel
                    text: qsTr("总时间(s):");
                    font.pixelSize: labelPixSize
                    font.family: fontfamily
                    color: labelColor
                }

                Item {
                    width: parent.width - allTimeLabel.width - allTime.width;
                    height: 1
                }

                TInputField{
                    id:allTime;
                    background.radius: 10;
                    background.color: inputBackgroundColor
                    width: parent.width * 0.28
                    height: parent.height
                    label.color: labelColor;
                    cursorColor: labelColor;
                    text: projectForm.allTime

                    placeholderPosition: TPosition.Left;
                    placeholderLabel.text: "请输入参数";
                    placeholderLabel.color: labelColor
                    border.width: 0
                    anchors.verticalCenter: allTimeLabel.verticalCenter
                    theme.enabled: false;
                }
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
                        var projectFormData = {
                            "projectId": projectForm.projectId,
                            "name": projectName.text,
                            "sateName": sateName.displayText,
                            "modulation": modulation.displayText,
                            "nosurearg": nosurearg.text,
                            "outputSamplingRate": outputSamplingRate.text,
                            "allTime": allTime.text,
                            "editTime": Qt.formatDateTime(new Date(), "yyyy-MM-dd")
                        }
                        penToolSever.editProject(projectFormData);
                        editprojectdia.close();
                        penToolSever.getProjectList();
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
                        editprojectdia.close();
                    }
                }
            }
        }
    }
}
