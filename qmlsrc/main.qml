
import QtQuick.Window 2.2
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtQuick 2.9
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: window
    visible: true
    width: 1200
    height: 1920
    title: qsTr("test QuickControl FORD VS QT ")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("RecentScreen-QT")
                width: parent.width
                onClicked: {

                    console.time("qmlscence RecentScreenQuickControl recent view##########################################");
                    stackView.push("qmlsrc/RecentScreenQuickControl.qml")
                    console.timeEnd("qmlscence RecentScreenQuickControl recent view##########################################");
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("RecentScreen-FORD")
                width: parent.width

                onClicked: {
                    console.time("qmlscence RecentScreenFHC recent view#################################################");
                    stackView.push("qmlsrc/RecentScreenFHC.qml")
                    console.timeEnd("qmlscence RecentScreenFHC recent view#################################################");
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "qmlsrc/HomeForm.qml"
        anchors.fill: parent
    }
}

