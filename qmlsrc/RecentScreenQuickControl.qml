import QtQuick 2.7

import QtQuick.Controls 2.2

Item {
    id : root
    anchors.fill: parent
    property var geoCoordinatesHelper
    property var mapLocation
    property var favoritesProvider
    property var listModel
    property bool isMaximumWaypointsReached: false

    signal backButtonActivated()
    signal deleteButtonActivated(var place)
    signal editButtonActivated(var place)
    signal itemActivated(var place)
    signal startNavigation(var place)

    ListModel {

        id: listModel
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"KFC"; details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Amarican"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}
        ListElement { place:"China"; details: "4603 Westland st, Dearborn, MI 48126......"; distance: "5.3mi" }
        ListElement { place:"Crian";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "5.4mi" }
        ListElement { place:"Srtgf";details: "Set up and ge  there form anywhere"; distance: "3.3mi"}
        ListElement { place:"Dlalihne";details: "KFC 12653 mICHIGAN Ave,Dearborn,MI 48..."; distance: "1.4mi"}
        ListElement { place:"Uk"; details: "15712 Michigan Ave,Dearborn,MI 45343... "; distance: "5.3mi"}

    }


    ListView {
        id: listView

        headerPositioning: ListView.PullBackHeader
//        header:Rectangle{
//            id:headbar
//            width: view.width
//            height: 60
//            Row{
//                Image {
//                    id: returnbutton
//                    source: "15inch/header_back.png"
//                    anchors.leftMargin: 12
//                }
//                Label{
//                    id:labelheader
//                    text:"Saved Places"
//                    font.pixelSize: 27
//                    color: "#44516f"
//                    anchors.left: returnbutton.right
//                    anchors.leftMargin: 12
//                }
//            }


//        }

        objectName: "listView"
        anchors.fill: parent
       // anchors.top: headbar.bottom
      //  clip: true
       // boundsBehavior: Flickable.StopAtBounds
        model: listModel
        delegate:

            RecentItemDelegate {}
    }

}






















