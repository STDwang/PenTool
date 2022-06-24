import QtQuick 2.6
import Toou2D 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.1

Item {
    Rectangle {
        height: parent.height * 0.94
        width: parent.width * 0.98
        radius: 10
        color: "#282A36"
        anchors.centerIn: parent;

        Rectangle {
            id: configtitle
            height: parent.height * 0.12
            width: parent.width - 40
            color: "#303240"
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.top: parent.top;
            anchors.topMargin: 20
            TLabel {
                text: "配置参数"
                color: "#9BB3C7"
                font.pixelSize: 28
                anchors.verticalCenter: parent.verticalCenter;
                anchors.left: parent.left;
                anchors.leftMargin: 20
            }
        }

        TBusyIndicator{
            id:bi;
            anchors.centerIn: parent;
        }

        Component.onCompleted: {
            loader.sourceComponent = contentComponent;
        }

        Loader{
            id:loader;
            anchors{
                left:  parent.left;
                leftMargin: 20;
                right: parent.right;
                rightMargin: 20;
                top:   configtitle.bottom;
                topMargin: 20;
                bottom: parent.bottom;
                bottomMargin: 20;
            }
            asynchronous: true
            onStatusChanged: bi.visible = status !== Loader.Ready
        }

        Component {
            id:contentComponent;
            TFlickable{
                id: control
                clip: true
                contentWidth: parent.width;
                contentHeight: layout.height;
                scrollBar.horizontal: false;
                Column {
                    id:layout
                    spacing: 20
                    anchors.left: parent.left;
                    Item{
                        width: 10;
                        height: 10;
                    }
                    //--
                    TLabel {
                        text: "文件参数"
                        color: "#9BB3C7"
                        font.pixelSize: 20
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: rootDirColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: rootDirColumn
                            spacing: 10
                            TLabel {
                                text: "The Directory Path where the software installed"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "安装路径:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TInputField {
                                id: rootDirName
                                width: control.width * 0.6;
                                label.color: "#9BB3C7";
                                cursorColor: "#9BB3C7";
                                placeholderLabel.color: "#9BB3C7"
                                placeholderPosition: TPosition.Left;
                                border.width: 0
                                background.radius: 5;
                                background.color: "#1C2128"
                                theme.enabled: false;
                                text: global.rootDir
                                enabled: false
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: intermediateColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: intermediateColumn
                            spacing: 10
                            TLabel {
                                text: "The Directory Path where the intermediate files"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "存放项目文件的默认目录路径:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TInputField {
                                id: intermediatefileName
                                width: control.width * 0.6;
                                label.color: "#9BB3C7";
                                cursorColor: "#9BB3C7";
                                placeholderLabel.color: "#9BB3C7"
                                placeholderPosition: TPosition.Left;
                                placeholderLabel.text: "请输入存放项目文件的默认目录路径";
                                border.width: 0
                                background.radius: 5;
                                background.color: "#1C2128"
                                theme.enabled: false;
                                text: global.temporaryFilesDir
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: logColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: logColumn
                            spacing: 10
                            TLabel {
                                text: "The Directory Path where the log files"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "存放log日志的默认目录路径:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TInputField {
                                id: logName
                                width: control.width * 0.6;
                                label.color: "#9BB3C7";
                                cursorColor: "#9BB3C7";
                                placeholderLabel.color: "#9BB3C7"
                                placeholderPosition: TPosition.Left;
                                placeholderLabel.text: "请输入存放log日志的默认目录路径";
                                border.width: 0
                                background.radius: 5;
                                background.color: "#1C2128"
                                theme.enabled: false;
                                text: global.logDir
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: txtColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: txtColumn
                            spacing: 10
                            TLabel {
                                text: "The Directory Path where the txt files"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "存放txt文件的默认目录路径:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TInputField {
                                id: txtName
                                width: control.width * 0.6;
                                label.color: "#9BB3C7";
                                cursorColor: "#9BB3C7";
                                placeholderLabel.color: "#9BB3C7"
                                placeholderPosition: TPosition.Left;
                                placeholderLabel.text: "请输入存放txt文件的默认目录路径";
                                border.width: 0
                                background.radius: 5;
                                background.color: "#1C2128"
                                theme.enabled: false;
                                text: global.txtDir
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: txtColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: xlsxColumn
                            spacing: 10
                            TLabel {
                                text: "The Directory Path where the xlsx files"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "存放xlsx文件的默认目录路径:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TInputField {
                                id: xlsxName
                                width: control.width * 0.6;
                                label.color: "#9BB3C7";
                                cursorColor: "#9BB3C7";
                                placeholderLabel.color: "#9BB3C7"
                                placeholderPosition: TPosition.Left;
                                placeholderLabel.text: "请输入存放xlsx文件的默认目录路径";
                                border.width: 0
                                background.radius: 5;
                                background.color: "#1C2128"
                                theme.enabled: false;
                                text: global.xlsxDir
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: tuflagColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: tuflagColumn
                            spacing: 10
                            TLabel {
                                text: "Whether I/O waveforms and Spectra are drawn when resampling baseband files"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "是否绘制图:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TCheckBox {
                                id: tuflag
                                label.text: "启用后当会生成并显示结果图"
                                label.color: "#9BB3C7"
                                label.font_size: 14
                                checked: global.tuflag
                            }
                        }
                    }
                    TLabel {
                        text: "用户参数"
                        color: "#9BB3C7"
                        font.pixelSize: 20
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: themeColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: themeColumn
                            spacing: 10
                            TLabel {
                                text: "Choose your favorite theme"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "选择您喜爱的主题:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            Row {
                                id:themelayout
                                spacing: 20
                                TRadioBoxGroup{
                                    id: theme;
                                    parent: themelayout
                                    TRadioBox{
                                        id: blackRadio
                                        label.text: "black"
                                        label.color: "#9BB3C7"
                                        checked: global.theme === label.text ? true:false;
                                    }

                                    TRadioBox{
                                        id: whiteRadio
                                        label.text: "white"
                                        label.color: "#9BB3C7"
                                        checked: global.theme === label.text ? true:false;
                                    }

                                    TRadioBox{
                                        id: blueRadio
                                        enabled: false;
                                        label.color: "#9BB3C7"
                                        label.text: "blue"
                                    }
                                }
                            }
                        }
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: languageColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: languageColumn
                            spacing: 10
                            TLabel {
                                text: "Choose your language"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "选择您的语言:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            Row {
                                id:languagelayout
                                spacing: 20
                                TRadioBoxGroup{
                                    id: language;
                                    parent: languagelayout
                                    TRadioBox{
                                        id: chineseRadio
                                        label.text: "chinese"
                                        label.color: "#9BB3C7"
                                        checked: global.language == label.text ? true:false;
                                    }

                                    TRadioBox{
                                        id: englishRadio
                                        label.text: "english"
                                        label.color: "#9BB3C7"
                                        checked: global.language == label.text ? true:false;
                                    }
                                }
                            }
                        }
                    }
                    TLabel {
                        text: "安全设置"
                        color: "#9BB3C7"
                        font.pixelSize: 20
                    }
                    Row {
                        spacing: 20
                        TDividerLine{
                            width: 2;
                            height: lincesColumn.height;
                            color: "#FFB86C";
                        }
                        Column {
                            id: lincesColumn
                            spacing: 10
                            TLabel {
                                text: "Your encryption key"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TLabel {
                                text: "您的密匙:"
                                color: "#9BB3C7"
                                font.pixelSize: 14
                            }
                            TextArea {
                                id: linceseText
                                width: control.width * 0.6;
                                height: control.height * 0.3;
                                font.pixelSize: 16
                                color: "#9BB3C7"
                                textFormat: TextEdit.RichText
                                wrapMode: TextArea.WrapAnywhere
                                text: global.lincese
                                background: Rectangle{
                                    anchors.fill: parent
                                    color: "#21222C"
                                    radius: 5
                                }
                            }
                        }
                    }
                    Row {
                        spacing: parent.width * 0.2
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
                                radius: 10
                            }
                            onClicked: {
                                var th = "black";
                                if(blackRadio.checked){
                                    th = "black";
                                }else if(whiteRadio.checked){
                                    th = "white";
                                }else{
                                    th = "blue";
                                }
                                var la = "chinese";
                                if(chineseRadio.checked){
                                    la = "chinese";
                                }else{
                                    la = "english";
                                }
                                var newProForm = {
                                    "tuflag": tuflag.checked,
                                    "logDir": logName.text,
                                    "txtDir": txtName.text,
                                    "xlsxDir": xlsxName.text,
                                    "temporaryFilesDir": intermediatefileName.text,
                                    "theme": th,
                                    "language": la,
                                    "lincese": linceseText.text,
                                }
                                if(penToolSever.setPro(newProForm)){
                                    TToast.showSuccess("参数修改成功",TTimePreset.LongTime4s, global.rootDir);
                                }else{
                                    TToast.showError("参数修改失败",TTimePreset.LongTime4s, global.rootDir);
                                }
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
                                radius: 10
                            }

                            onClicked: {
                                var configMap = penToolSever.readPro();
                                tuflag.checked = configMap["tuflag"];
                                logName.text = configMap["logDir"];
                                txtName.text = configMap["txtDir"];
                                xlsxName.text = configMap["xlsxDir"];
                                intermediatefileName.text = configMap["temporaryFilesDir"];
                                if(configMap["theme"] == "black"){
                                    blackRadio.checked = true;
                                }else if(configMap["theme"] == "white"){
                                    whiteRadio.checked = true;
                                }else{
                                    blueRadio.checked = true;
                                }
                                linceseText.text = configMap["lincese"];
                            }
                        }
                    }
                }
            }
        }
    }
}
