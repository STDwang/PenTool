import QtQuick 2.0
import Toou2D 1.0
import QtQuick.Controls 2.1

Item {

    signal submit(string account, string password, bool remember)
    signal quickBegin()

    property var labelColor: "#9BB3C7"
    property var inputColor: "#282A36"
    Column {
        anchors.centerIn: parent
        width: parent.width * 0.9
        spacing: 10

        TLabel {
            text: qsTr("Hellow PenTool!")
            font.pixelSize: 32
            color: labelColor
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TLabel {
            text: qsTr("Enter your mysql account and password to login")
            font.pixelSize: 12
            color: labelColor
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            height: parent.height * 0.1
            width: 20
        }

        TInputField{
            id:account
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width;
            background.radius: 4;
            placeholderPosition: TPosition.Left;
            placeholderLabel.text: "account";
            placeholderLabel.color: inputColor
            placeholderIcon.color: inputColor
            placeholderIcon.source: TAwesomeType.FA_user_o
            theme.enabled: false;
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton  //只处理鼠标左键
                onClicked: {
                    TToast.showWarning("直接登录即可",TTimePreset.LongTime4s, "不用输入")
                }
            }
        }

        Item {
            height: parent.height * 0.05
            width: 20
        }

        TInputField{
            id:password;
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width;
            background.radius: 4;
            placeholderPosition: TPosition.Left;
            placeholderLabel.text: "password";
            placeholderLabel.color: "#282A36"
            placeholderIcon.color: "#282A36"
            placeholderIcon.source: TAwesomeType.FA_keyboard_o
            theme.enabled: false;
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton  //只处理鼠标左键
                onClicked: {
                    TToast.showWarning("直接登录即可",TTimePreset.LongTime4s, "不用输入")
                }
            }
        }

        Item {
            height: parent.height * 0.05
            width: 20
        }

        TSwitch {
            id: rememberMeSwith
            anchors.left: parent.left
            background.color: "#505254"

            TLabel {
                text: qsTr("Remember me")
                anchors.left: parent.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: "#CDD9D5"
            }
        }

        Item {
            height: parent.height * 0.03
            width: 20
        }

        TButton{
            width: parent.width;
            height: parent.height * 0.12;
            label.text: "Login"
            label.color: labelColor
            label.font.pixelSize: 20;
            label.font.bold: true;
            backgroundComponent: Rectangle{
                anchors.fill: parent
                color: "#347D39"
                radius: 10
            }
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                submit(account.text, password.text, rememberMeSwith.checked);
            }
        }

        TLabel {
            text: qsTr("Don't have an mysql account?")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
            color: labelColor
        }

        TButton{
            label.text: qsTr("quick begin")
            label.color: labelColor
            label.font.pixelSize: 14
            label.font.bold: true;
            backgroundComponent: null

            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                quickBegin();
            }
        }
    }

}
