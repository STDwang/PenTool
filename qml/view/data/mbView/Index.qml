import QtQuick 2.6
import Toou2D 1.0
import QtQuick.Controls 2.1
import "../../../common"

TRectangle {
    color: "#282A36"//"white"

    property var labelColor: "#CDD9D5"
    property var rowHeight:             30;
    property var rowWidth:              450;
    property var fontfamily:            "微软雅黑";
    property var labelPixSize:          16;

    property var inputBackgroundColor:  "#30323D";
    property var radiusNumber:          5;
    property var mbTempMap:          ({});
    Item{
        id:titlebar
        width: parent.width;
        height: 66;

        Row {
            spacing: 20
            anchors.left: parent.left;
            anchors.leftMargin: 40;
            anchors.verticalCenter: parent.verticalCenter;

            Label {
                id: mbNameLabel
                text: qsTr("目标名称:");
                font.pixelSize: labelPixSize
                font.family: fontfamily
                color: labelColor
            }

            PenComboBox {
                id: mbName
                height: rowHeight
                width: rowWidth * 0.8
                fontSize: 12
                textColor: labelColor
                borderColor: "white"
                backgoundColor: inputBackgroundColor
                backgoundRadius: radiusNumber
                anchors.verticalCenter: mbNameLabel.verticalCenter

                Component.onCompleted: {
                    var out = [];
                    for(var i=0;i<mbdata.count;i++){
                        out.push(mbdata.get(i).name)
                        mbTempMap[mbdata.get(i).name] = mbdata.get(i).mbId
                    }
                    mbName.model = out;
                }
            }

            TButton{
                label.color: labelColor
                label.text: "搜索";
                width: 80
                anchors.verticalCenter: parent.verticalCenter;
                theme.enabled: false;
                backgroundComponent: Rectangle{
                    anchors.fill: parent
                    color: "#316DCA"
                    radius: radiusNumber
                }
                onClicked: {
                    penToolSever.getMbList();
                    if(mbName.displayText !== "") {
                        var idForm;
                        for(var key in mbTempMap){
                            if(mbName.displayText===key){
                                idForm = mbTempMap[key];
                                break;
                            }
                        }
                        if(idForm){
                            var mbFormData = {
                                "mbId": idForm
                            }
                            penToolSever.getMbById(mbFormData);
                        }
                    }
                }
            }
        }

        TButton{
            anchors.right: parent.right;
            anchors.rightMargin: 40;
            label.color: labelColor
            label.text: "添加";
            width: 80
            anchors.verticalCenter: parent.verticalCenter;
            theme.enabled: false;
            backgroundComponent: Rectangle{
                anchors.fill: parent
                color: "#347D39"
                radius: radiusNumber
            }
            onClicked: {
                newmbdia.open();
            }
        }
    }

    Rectangle {
        color: "white"
        anchors.top: titlebar.bottom;
        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.topMargin: 10;
        anchors.bottomMargin: 10;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;

        Loader{
            id:subcontentLoader
            anchors.fill: parent
            clip: true;
            asynchronous: true
            onStatusChanged: bi.visible = status !==Loader.Ready
        }
    }

    TBusyIndicator{
        id:bi;
        anchors.centerIn: parent;
    }

    Component.onCompleted: {
        subcontentLoader.sourceComponent = mbTableComponent;
    }

    Component{
        id:mbTableComponent

        MbTable {
            id: mbtable
        }
    }

    NewMbDia {
        id: newmbdia
    }
}
