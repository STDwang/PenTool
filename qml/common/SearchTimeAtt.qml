import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Toou2D 1.0

Item {
    property ListModel mode

    ListView {
        id: searchTimeAtt
        height: parent.height
        width: parent.width
        model: mode
        Rectangle {
            color: Qt.rgba(0/255,0/255,0/255, 0)
            anchors.fill: parent
            border.color: "#304156"
            border.width: 0
        }
        delegate: Row{
            height: 20
            width: parent.width
            TLabel {
                width: parent.width * 0.5
                text: attribute
                color: '#9BB3C7'
            }
            TLabel {
                text: value
                color: '#9BB3C7'
            }
        }

        section.property: "team"
        section.criteria: ViewSection.FullString
        section.delegate: sectionHeading1
        clip: true
        //分类高亮
        Component {
            id: sectionHeading1
            Item {
                height: 30
                Rectangle {
                    radius: 3
                    width: searchTimeAtt.width
                    height: 20
                    color: '#9BB3C7'
                    Text {
                        text: section;
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#303133"
                        font.pixelSize: 12
                    }
                }
            }
        }
        //滚动条
        ScrollBar.vertical: ScrollBar {
            anchors.right: searchTimeAtt.right
            width: 6
            active: true
            background: Item {            //滚动条的背景样式
                Rectangle {
                    anchors.centerIn: parent
                    height: parent.height
                    width: parent.width * 0.1
                    color: '#606266'
                    radius: 3
                }
            }

            contentItem: Rectangle {
                radius: 2        //bar的圆角
                color: '#9BB3C7'
            }
        }
    }
}
