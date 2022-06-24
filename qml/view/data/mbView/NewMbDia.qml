import QtQuick 2.6
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.1
import QtWebView 1.1
import QtWebEngine 1.4
import Toou2D 1.0
import "../../../common"

TDialog{
    id: newmbdia

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
        width: 1000;
        height: 600;
        radius: radiusNumber

        ListModel {
            id: mbChoiceModel
        }


        TDialog {
            id: maxBmapDia

            bodyComponent:  Page {
                id: maxBmapPage
                width: 1200;
                height: 800;
                WebView {
                    anchors.fill: parent
                    url: "qrc:/map/newmbmap.html"
                    onLoadingChanged: {
                        if (loadRequest.errorString)
                        {
                            console.error("webViewError:  " + loadRequest.errorString);
                        }
                    }
                }
                TIconButton{
                    width: 20
                    height: 20
                    icon.position: TPosition.Only;
                    icon.source: TAwesomeType.FA_close;
                    icon.color: "#282A36"
                    backgroundComponent: null;
                    anchors.right: parent.right;
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    onClicked: {
                        maxBmapDia.close();
                    }
                }
            }
        }

        Column {
            id: titleColumn
            spacing: 20;
            width: parent.width * 0.98
            Item{
                width: parent.width;
                height: 24;

                TIconButton{
                    icon.position: TPosition.Only;
                    icon.source: TAwesomeType.FA_close;
                    icon.color: iconColor
                    backgroundComponent: null;
                    anchors.right: parent.right;
                    onClicked: newmbdia.hideAndClose();
                }
            }

            Label {
                text: qsTr("新增目标")
                color: headerColor
                font.pixelSize: 28
                font.family: fontfamily
                anchors.left: parent.left;
                anchors.leftMargin: parent.width * 0.04
            }
        }

        Row {
            id: middleRow
            width: parent.width * 0.92
            anchors.top: titleColumn.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter;
            Column{
                id: leftAtt
                spacing: 20;

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter

                    spacing: 20
                    Label {
                        id: mbNameLabel
                        text: qsTr("目标名称:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    TInputField{
                        id:mbName;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.8
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("测试目标")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入目标名称";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: mbNameLabel.verticalCenter
                        theme.enabled: false;
                    }
                }

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter

                    spacing: 20
                    Label {
                        id: jwdLabel
                        text: qsTr("初始经维度:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    TInputField{
                        id:longitude;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.34
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("0")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入经度(°)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: jwdLabel.verticalCenter
                        theme.enabled: false;
                    }

                    TInputField{
                        id:latitude;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.34
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("0")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入维度(°)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: jwdLabel.verticalCenter
                        theme.enabled: false;
                    }
                }

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter

                    spacing: 20
                    Label {
                        id: mbheightLabel
                        text: qsTr("目标高度:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    TInputField{
                        id: mbheight;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.8
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("5000")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入目标高度(m)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: mbheightLabel.verticalCenter
                        theme.enabled: false;
                    }
                }

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Label {
                        id: mbspeedLabel
                        text: qsTr("VxVyVz:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    Item {
                        width: parent.width - mbspeedLabel.width - vx.width - vy.width- vz.width - 100
                        height: 1
                    }

                    TInputField{
                        id:vx;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.22
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("0")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入Vx(m/s)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: mbspeedLabel.verticalCenter
                        theme.enabled: false;
                    }

                    TInputField{
                        id:vy;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.22
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("0")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入Vy(m/s)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: mbspeedLabel.verticalCenter
                        theme.enabled: false;
                    }

                    TInputField{
                        id:vz;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.22
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("0")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入Vz(m/s)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: mbspeedLabel.verticalCenter
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
                        text: qsTr("1")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入时间步进(s/次)";
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
                        text: qsTr("60")

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
                        id: tuningFrequencyLabel
                        text: qsTr("调谐频率:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    TInputField{
                        id:tuningFrequency;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.8
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("290")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入调谐频率(MHz)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: tuningFrequencyLabel.verticalCenter
                        theme.enabled: false;
                    }
                }

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Label {
                        id: signalFrequencyLabel
                        text: qsTr("信号频率:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    TInputField{
                        id:signalFrequency;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.8
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("290")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入信号频率(MHz)";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: signalFrequencyLabel.verticalCenter
                        theme.enabled: false;
                    }
                }

                Row {
                    height: rowHeight
                    width: rowWidth
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 20
                    Label {
                        id: snrLabel
                        text: qsTr("信噪比:");
                        font.pixelSize: labelPixSize
                        font.family: fontfamily
                        color: labelColor
                    }

                    Item {
                        width: parent.width - snrLabel.width - snr.width - 40
                        height: 1
                    }

                    TInputField{
                        id: snr;
                        height: parent.height
                        background.radius: radiusNumber;
                        background.color: inputBackgroundColor
                        width: parent.width * 0.8
                        label.color: labelColor;
                        cursorColor: labelColor;
                        text: qsTr("10")

                        placeholderPosition: TPosition.Left;
                        placeholderLabel.text: "请输入信噪比";
                        placeholderLabel.color: labelColor
                        border.color: borderColor
                        border.width: 0
                        anchors.verticalCenter: snrLabel.verticalCenter
                        theme.enabled: false;
                    }
                }
            }
            Item {
                width: parent.width - mbMapPage.width - leftAtt.width
                height: 1
            }
            Page {
                id: mbMapPage
                width: leftAtt.height
                height: leftAtt.height
                WebEngineView {
                    id: webView
                    anchors.fill: parent
                    url: "qrc:/map/newmbmap.html"
                    onLoadingChanged: {
                        if (loadRequest.errorString)
                        {
                            console.error("webViewError:  " + loadRequest.errorString);
                        }
                    }
                }
                TIconButton{
                    width: 20
                    height: 20
                    icon.position: TPosition.Only;
                    icon.source: TAwesomeType.FA_square_o;
                    icon.color: "#282A36"
                    backgroundComponent: null;
                    anchors.right: parent.right;
                    anchors.rightMargin: 10
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    onClicked: {
                        webView.stop();
                        maxBmapDia.open();
                    }
                }
            }
        }
        Row {
            spacing: parent.width * 0.2
            anchors.top: middleRow.bottom;
            anchors.topMargin: 20
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
                    var mbFormData = {
                        "name": mbName.text,
                        "longitude": longitude.text,
                        "latitude": latitude.text,
                        "height": mbheight.text,
                        "Vx": vx.text,
                        "Vy": vy.text,
                        "Vz": vz.text,
                        "timeStep": timeStep.text,
                        "numberTimes": times.text,
                        "tuningFrequency": tuningFrequency.text,
                        "signalFrequency": signalFrequency.text,
                        "snr": snr.text
                    }
                    penToolSever.addMb(mbFormData);
                    newmbdia.close();
                    penToolSever.getMbList();
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
                    newmbdia.close();
                }
            }
        }
    }
}
