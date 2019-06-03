import QtQuick 2.7


import com.ford.hmicontrols 1.0 as FHC
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
        ListElement { place:"Home"; details: "Set up and ge  there form anywhere"; distance:"3.3mi"}
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
            id: listItem
            objectName: place
            anchors.fill: parent
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: listModel
            cacheBuffer:208
            delegate:
                InteractiveListDelegate {
                width: parent.width
                height:104
                hasEditButton: true
                destName: place
                destAddress: details
                destDistance:distance
                iconAsset: "tnSmallRecentIcon"
                typeIconAsset: "tnInteractiveDeleteIcon"

                isMaximumWaypointsReached: false
                placeId: "listModel.id"
                goTextString: "goText"
                onDeleteButtonActivated: {
                    root.deleteButtonActivated(listModel);

                }

                onEditButtonActivated: {
                    root.editButtonActivated(listModel);
                }

                onItemActivated:  {
                    root.itemActivated(listModel);
                }

                onGoToNavigationActivated: {
                    root.startNavigation(listModel);
                }
            }
        }
}
