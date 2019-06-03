import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    width: 1200
    height: 1920

    title: qsTr("Testing FORD AND QT CONTROL WINDOW")

    Label {   
        Text {
               font.pointSize: 20
               text: "<b>Testing FORD AND QT CONTROL WINDOW!</i>"
           }
        anchors.left: parent.left
        anchors.leftMargin: 200
        anchors.top:parent.top
        anchors.topMargin: 600
    }
}
