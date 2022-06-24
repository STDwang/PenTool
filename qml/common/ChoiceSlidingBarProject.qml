import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Toou2D 1.0

Item {
    property ListModel mode;

    property var labelColor: "#9BB3C7";
    property var iconColor: "#9BB3C7";
    property var heardColor: "#0075FF";

    signal sureProject(string projectName);
    signal deleteProject(string projectId);

    ListView {
        id: attform1
        height: parent.height
        width: parent.width
        model: mode

        delegate: Row {
            width: parent.width
            TIconButton{
                id: projectButton
                label.text: name;
                label.font.pixelSize: 18;
                label.color: labelColor
                icon.source: TAwesomeType.FA_tv;
                icon.color: iconColor
                spacing: parent.width * 0.05
                backgroundComponent: null;
                onClicked: sureProject(name);
            }
            Item {
                height: 1
                width: parent.width - projectButton.width - deleteButton.width - 10
            }
            TIconButton{
                id: deleteButton
                icon.position: TPosition.Only;
                icon.source: TAwesomeType.FA_close;
                icon.color: iconColor
                backgroundComponent: null;
                onClicked: {
                    deleteProject(projectId);
                    penToolSever.getProjectList();
                }
            }
        }
        section.property: "editTime"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading1
        clip: true

        //分类高亮
        Component {
            id: sectionHeading1
            Text {
                height: 30
                text: section;
                color: heardColor
                font.pixelSize: 20
            }
        }

        //滚动条
        ScrollBar.vertical: ScrollBar {
            anchors.right: attform1.right
            width: parent.width * 0.02
            active: true
            background: Item {            //滚动条的背景样式
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width * 0.1
                    color: '#606266'
                    radius: width/2
                }
            }

            contentItem: Rectangle {
                radius: width/4        //bar的圆角
                color: '#9BB3C7'
            }
        }
    }
}
