import QtQuick 2.6
import Toou2D 1.0

TPopup{
    id:popup
    signal topage(string uri,string title);
    property int  width;
    property int  height;
    property bool isopen: false;

    onOpened: isopen = true;
    onHided:  isopen = false;

    onTriggeredBackground: hide(true);
    backgroundComponent: null;

    //样式
    property var backgroundColor: "#22272E";
    property var dividingLineColor : "#444C56";
    property var labelColor: "#CDD9D5";

    TRectangle{
        id:bg
        width: popup.width;
        height: popup.height;
        x:isopen ? 0 : -width;
        theme.groupName: "menubg"
        color: backgroundColor

        Column{
            spacing: 10;
            anchors.horizontalCenter: parent.horizontalCenter;

            Item{
                width: 10;
                height: 20;
            }

            TLabel{
                id:logo
                text: "PenTool";
                font.pixelSize: TPixelSizePreset.PH1;
                font.bold: true;
                anchors.horizontalCenter: parent.horizontalCenter;
                theme.groupName: "menutitle"
                color: labelColor
            }

            Item{
                width: 10;
                height: 10;
            }

            TDividerLine{
                width: popup.width * 0.8;
                height: 1;
                color: dividingLineColor
            }

            Repeater{
                anchors.horizontalCenter: parent.horizontalCenter;

                model: [
                    {label:"Home",icon:TAwesomeType.FA_home,            uri:"qrc:/qml/view/home/Index.qml"},
                    {label:"Table",icon:TAwesomeType.FA_table,          uri:"qrc:/qml/view/data/Index.qml"},
                    {label:"Play",icon:TAwesomeType.FA_tv,              uri:"qrc:/qml/view/play/Index.qml"},
                    {label:"Config",icon:TAwesomeType.FA_cog,           uri:"qrc:/qml/view/config/Index.qml"},
//                    {label:"Awesome",icon:TAwesomeType.FA_font_awesome, uri:"qrc:/qml/view/awesome/Index.qml"},
                    {label:"Help",icon:TAwesomeType.FA_book,            uri:"qrc:/qml/view/help/Index.qml"},
                    {label:"Github",icon:TAwesomeType.FA_github_alt,    uri:"https://github.com/STDwang"},
                ]

                delegate: TIconButton{
                    width: parent.width;
                    spacing: 15;
                    height: 50;
                    contentHAlign: Qt.AlignCenter
                    label.text: modelData.label;
                    label.font.pixelSize: 16
                    label.color: labelColor
                    icon.source: modelData.icon;
                    icon.color: labelColor
                    backgroundComponent: null;
                    onClicked: {
                        topage(modelData.uri,modelData.label);
                        hide(true);
                    }
                }
            }
        }

        TLabel{
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 5;
            font.pixelSize: TPixelSizePreset.PH7
            text: "Version: 1.4"
            color: labelColor
        }

        Behavior on x {
            NumberAnimation {
                duration: 100
            }
        }
    }
}

