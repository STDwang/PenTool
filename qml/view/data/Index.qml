import QtQuick 2.6
import Toou2D 1.0

Item {

    Loader{
        id:loader;
        anchors.fill: parent;
        asynchronous: true
        onStatusChanged: bi.visible = status !==Loader.Ready
    }

    TBusyIndicator{
        id:bi;
        anchors.centerIn: parent;
    }

    Component.onCompleted: {
        loader.sourceComponent = dataComponent;
    }

    Component {
        id: dataComponent

        Item {
            TDialog{
                id: loginPleaseDia
                titleText: "提示";
                contentText: "请先连接好数据库";
                onTriggered: {
                    loginPleaseDia.hideAndClose();
                    toPage("qrc:/qml/view/home/Index.qml", "Home")
                }
            }

            TCarousel{
                id: dataPage

                width: parent.width * 0.84;
                height: parent.height * 0.84;
                itemWidth: parent.width * 0.7;
                itemHeight:parent.height * 0.7;
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                theme.groupName: "only"

                TCarouselElement{
                    otherData: "#409EFF"
                    imageSource: "qrc:/res/png/sate(1).png"
                }

                TCarouselElement{
                    otherData: "#67C23A"
                    imageSource: "qrc:/res/png/mb(1).png"
                }

                TCarouselElement{
                    otherData: "#E6A23C"
                    imageSource: "qrc:/res/png/project(1).png"
                }

                onTriggered: {
        //            console.log("circularIndex:", modelData.index);
                    if(!global.databaseLogin) {
                        loginPleaseDia.open()
                    }else{
                        if(modelData.otherData == "#409EFF"){
                            penToolSever.getSateList();
                            toPage("qrc:/qml/view/data/sateView/Index.qml", "场景管理")
                        }else if(modelData.otherData === "#67C23A"){
                            penToolSever.getMbList();
                            toPage("qrc:/qml/view/data/mbView/Index.qml", "目标管理")
                        }else{
                            penToolSever.getProjectList();
                            toPage("qrc:/qml/view/data/projectView/Index.qml", "项目管理")
                        }
                    }
                }

                contentComponent: Rectangle{
                    color: modelData.otherData;
                    anchors.centerIn: parent;
                    TImage {
                        height: 394
                        width: 339
                        anchors.centerIn: parent
                        source: modelData.imageSource
                    }

                    TLabel{
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.top:parent.top;
                        anchors.topMargin: 30;
                        font.pixelSize: 22;
                        color: "#FFF";
                        font.bold: true;
                        text: global.tableNameList[modelData.index];
                    }
                }
            }
        }
    }
}
