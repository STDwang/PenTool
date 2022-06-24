import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import Toou2D 1.0

Item {
    id: menubuttons

    property var labelColor: "#9BB3C7";
    property var headerColor: "#0075FF";
    property var iconColor: "#9BB3C7";
    property var textAreaColor: "#1C2128";
    property var backgroundColor: "#347D39";
    property var diaBackgroundColor: "#282A36";
    property var borderColor: Qt.rgba(1,1,1, 0.6);
    property var radiusNumber: 20;

    //上头毛玻璃背景
    Rectangle{
        id:indexMaoBoLi
        width: menubuttons.width;
        height: menubuttons.height;
        color: Qt.rgba(40/255,42/255,54/255, 0.6)//设置透明度   每个数值都除以255  不影响子组件
        radius: radiusNumber
        border.width: 1
        border.color: borderColor
        //opacity: 0.6;  //影响子组件
    }

    //毛玻璃效果
    FastBlur {
        anchors.fill: indexMaoBoLi
        source: indexMaoBoLi
        radius: radiusNumber
    }

    Label {
        text: qsTr("PenTool Free");
        font.pixelSize: 18
        color: labelColor

        anchors.verticalCenter: indexMaoBoLi.verticalCenter
        anchors.left: indexMaoBoLi.left
        anchors.leftMargin: indexMaoBoLi.width * 0.02
    }

    TButton{
        width: indexMaoBoLi.width * 0.12;
        height: indexMaoBoLi.height * 0.7;
        label.text: "Get Lincese"
        label.color: labelColor
        backgroundComponent: Rectangle{
            anchors.fill: parent
            color: backgroundColor
            radius: 10
        }

        anchors{
            right: indexMaoBoLi.right;
            top:   indexMaoBoLi.top;
            bottom: indexMaoBoLi.bottom;
        }
        anchors.margins: 15;

        onClicked: {
            getLinceseDia.open();
        }
    }

    //按钮栏里的数据
    Row {
        spacing: 10
        anchors.centerIn: indexMaoBoLi;

        Repeater{
            model: [
                {label:"Blog",icon:TAwesomeType.FA_github_alt,uri:"http://101.43.234.220:8090/"},
                {label:"Github",icon:TAwesomeType.FA_github,uri:"https://github.com/STDwang"},
                {label:"Doc-Help",icon:TAwesomeType.FA_book,uri:"https://blog.csdn.net/qq_47898198"},
                {label:"Set-Lincese",icon:TAwesomeType.FA_key,uri:"http://101.43.234.220:8090/"},
            ]

            delegate: TIconButton{
                height: 60;
                width: 100;
                contentHAlign: Qt.AlignCenter
                label.text: modelData.label;
                label.color: labelColor
                icon.source: modelData.icon;
                icon.color: iconColor
                backgroundComponent: null;
                onClicked: {
                    toURL(modelData.uri, modelData.label);
                }
            }
        }
    }

    TDialog{
        id:getLinceseDia

        bodyComponent:  TRectangle{
            theme.enabled: false;
            color: diaBackgroundColor
            width: 470;
            height: 320;
            radius: 10

            Column{
                spacing: 25;
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
                        onClicked: getLinceseDia.hideAndClose();
                    }
                }

                Column{
                    width: parent.width;
                    spacing: 10
                    Text {
                        text: qsTr("请根据此ID购买Lincese")
                        color: headerColor
                        font.pixelSize: 24
                        anchors.horizontalCenter: parent.horizontalCenter;
                    }

                    Text {
                        text: qsTr("您的ID：")
                        color: labelColor
                        font.pixelSize: 20
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.1
                    }

                    TextArea {
                        id: idText
                        width: parent.width * 0.8;
                        height: 120;
                        font.pixelSize: 16
                        color: labelColor
                        anchors.left: parent.left
                        anchors.leftMargin: parent.width * 0.1
                        wrapMode: TextArea.WrapAnywhere
                        text: penToolSever.getID()
                        enabled: false
                        background: Rectangle{
                            anchors.fill: parent
                            color: textAreaColor
                            radius: 5
                        }
                    }

                    Item {
                        height: 20;
                        width: 1;
                    }

                    TButton{
                        width: 90;
                        height: 36;
                        label.text: "复制"
                        anchors.horizontalCenter: parent.horizontalCenter;
                        backgroundComponent: Rectangle{
                            anchors.fill: parent
                            color: headerColor
                            radius: 10
                        }

                        onClicked: {
                            penToolSever.copyID(idText.text)
                        }
                    }
                }
            }
        }
    }

    TDialog {
        id:setLinceseDia

        bodyComponent:  TRectangle{
            theme.enabled: false;
            color: diaBackgroundColor
            width: 500;
            height: 400;
            radius: 10

            Column{
                spacing: 25;
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
                        onClicked: setLinceseDia.hideAndClose();
                    }
                }

                Text {
                    text: qsTr("请输入您的Lincese")
                    color: headerColor
                    font.pixelSize: 24
                    anchors.horizontalCenter: parent.horizontalCenter;
                }

                TextArea {
                    id: linceseText
                    width: parent.width*0.9;
                    height: parent.height*0.6;
                    font.pixelSize: 16
                    color: labelColor
                    text: global.lincese
                    anchors.horizontalCenter: parent.horizontalCenter;
                    wrapMode: TextArea.WrapAnywhere
                    background: Rectangle{
                        anchors.fill: parent
                        color: textAreaColor
                        radius: 5
                    }
                }

                TButton{
                    width: 90;
                    height: 36;
                    label.text: "确定"
                    anchors.horizontalCenter: parent.horizontalCenter;
                    backgroundComponent: Rectangle{
                        anchors.fill: parent
                        color: headerColor
                        radius: 10
                    }

                    onClicked: {
                        console.log(linceseText.text)
                        if(penToolSever.linceseVerify(linceseText.text)){
                            penToolSever.readPro();
                            TToast.showSuccess("验证成功",TTimePreset.LongTime4s, "penTool欢迎您的加入");
                        }else{
                            TToast.showError("验证失败",TTimePreset.LongTime4s, "请输入有效lincese");
                        }
                        setLinceseDia.close();
                    }
                }

            }
        }
    }

    Component.onCompleted: {
        if(!global.haveLincese){
            setLinceseDia.open();
        }
    }

    function toURL(url, label){
        if(label === "Set-Lincese"){
            setLinceseDia.open();
        }else{
            Qt.openUrlExternally(url);
        }
    }
}
