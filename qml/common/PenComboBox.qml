import QtQuick 2.6
import QtQuick.Controls 2.1

Item {
    id: pencombox

//    property var heightv: parent.height
    property var model: null
    property var borderColor: "#606266"
    property var backgoundColor: "#30323D"
    property var borderWidth: 0
    property var textColor: "#9BB3C7"
    property var backgoundRadius: 10
    property var fontSize: 12
    property var displayText: control.displayText

    ComboBox {
        id: control
        model: pencombox.model
        height: parent.height
        width: parent.width

        //选择框背景
        background: Rectangle{
            anchors.fill: parent
            color: backgoundColor
            border.color: borderColor
            border.width: borderWidth
            radius: backgoundRadius
        }
        //迭代的每个元素的样式代理
        delegate: ItemDelegate {
            width: control.width
            contentItem: Text {
                text: modelData
                color: textColor;
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
//                font.family: "微软雅黑"
//                font.pointSize: fontSize
            }
            highlighted: control.highlightedIndex == index

            background: Rectangle{
                anchors.fill: parent
                color: backgoundColor
            }
        }

        //三角形图标
        indicator: Canvas {
            id: canvas
            x: control.width - width - control.rightPadding
            y: control.topPadding + (control.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            Connections {
                target: control
                onPressedChanged: canvas.requestPaint()
            }

            onPaint: {
                context.reset();
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = pencombox.textColor;
                context.fill();
            }
        }
        //选择框里的内容样式
        contentItem: Text {
            leftPadding: 10
            rightPadding: control.indicator.width + control.spacing
            text: control.currentText
            color: pencombox.textColor
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        //弹出框
        popup: Popup {
            //默认向下弹出，如果距离不够，y会自动调整（）
            y: control.height
            width: control.width
            //根据showCount来设置最多显示item个数
            implicitHeight: Math.min(contentItem.implicitHeight, control.height * 5)
            //用于边框留的padding
            padding: 1
            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex
                //按行滚动SnapToItem ;像素移动SnapPosition
                snapMode: ListView.SnapToItem
                //ScrollBar.horizontal: ScrollBar { visible: false }
                ScrollBar.vertical: ScrollBar { //定制滚动条
                    id: box_bar
                    implicitWidth: 6
                    visible: control.delegateModel && (control.delegateModel.count>5)
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
                        color: pencombox.textColor
                    }
                }
            }

            //弹出框背景（只有border显示出来了，其余部分被delegate背景遮挡）
            background: Rectangle{
                border.width: 1
                border.color: borderColor
                radius: backgoundRadius
                color: pencombox.backgoundColor
            }
        }
    }
}
