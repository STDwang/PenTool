import QtQuick 2.0
import Toou2D 1.0
import QtQuick.Controls 2.1
import "../../common"

Item {

    signal toView(string projectName);
    signal back();

    Column{
        spacing: 25;
        width: parent.width;
        height: parent.height * 0.9

        Item {
            width: parent.width;
            height: 12;

            TIconButton{
                icon.position: TPosition.Only;
                icon.source: TAwesomeType.FA_reply;
                icon.color: "#9BB3C7"
                backgroundComponent: null;
                anchors.left: parent.left;
                onClicked: back();
            }
        }

        TLabel {
            text: qsTr("Hellow PenTool!")
            font.pixelSize: 32
            color: "#9BB3C7"
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter;
        }

        Row {
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter;
            Text {
                id: recentText
                text: qsTr("Recent")
                font.pixelSize: 24
                color: "#0075FF"
            }

            Item {
                height: 1
                width: parent.width - recentText.width - newTextButton.width
            }

            TIconButton{
                id: newTextButton
                label.text: qsTr("New")
                label.font.pixelSize: 24;
                label.color: "#0075FF"
                backgroundComponent: null;
                anchors.verticalCenter: recentText.verticalCenter
                onClicked: {
                    newprojectdia.open();
                }
            }
        }

        ChoiceSlidingBarProject {
            id: attform
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width * 0.85;
            height: parent.height * 0.7
            mode: projectdata

            onSureProject: {
                var i=0;
                var sateName="";
                for(i=0;i<projectdata.count;i++){
                    if(projectdata.get(i).name === projectName){
                        sateName = projectdata.get(i).sateName;
                        break;
                    }
                }
                sateChoiceModel.clear();
                for(i=0;i<satedata.count;i++){
                    if(satedata.get(i).name === sateName){
                        for(var j=0;j<Number(satedata.get(i).satenumbers);j++){
                            sateChoiceModel.append(satedata.get(i));
                            sateChoiceModel.setProperty(j, "name", "卫星" + (j+1).toString());
                            sateChoiceModel.setProperty(j, "_checked", true);
                        }
                        break;
                    }
                }
                var sateFormList = [];
                for(i=0;i<sateChoiceModel.count;i++){
                    var sateForm = {
                        "sateId": sateChoiceModel.get(i).sateId,
                        "name": sateChoiceModel.get(i).name,
                        "height": sateChoiceModel.get(i)._height,
                        "timeStep": sateChoiceModel.get(i).timeStep,
                        "numberTimes": sateChoiceModel.get(i).times,
                        "distance": sateChoiceModel.get(i).distance,
                        "satenumbers": sateChoiceModel.get(i).satenumbers,
                        "fixPD": sateChoiceModel.get(i).fixPD,
                        "xlsx": sateChoiceModel.get(i).xlsx,
                    }
                    sateFormList.push(sateForm);
                }
                for(i=0;i<projectdata.count;i++){
                    if(projectdata.get(i).name === projectName){
                        var projectForm = {
                            "name": projectdata.get(i).name,
                            "sateName": projectdata.get(i).sateName,
                            "modulation": projectdata.get(i).modulation,
                            "nosurearg": projectdata.get(i).nosurearg,
                            "outputSamplingRate": projectdata.get(i).outputSamplingRate,
                            "allTime": projectdata.get(i).allTime,
                            "editTime": projectdata.get(i).editTime
                        }
                        penToolSever.openProject(projectForm, sateFormList);
                        break;
                    }
                }
                global.sateTrails = [];
                global.mbTrails = [];
                global.outputIQ = [];
                global.inputIQ = {};
                global.projectingName = projectName;
                toView(projectName);
                TToast.showSuccess("项目加载成功",TTimePreset.LongTime4s, "请开始您的项目.");
            }

            onDeleteProject: {
                var project = {
                    "projectId": projectId
                }
                penToolSever.deleteProject(project);
            }
        } 
    }

    NewProjectDia {
        id: newprojectdia
    }
}
