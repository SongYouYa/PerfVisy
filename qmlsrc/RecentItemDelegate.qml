import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0


SwipeDelegate {
    id: delegate

    width: parent.width
    checked: swipe.complete
    onCheckedChanged: if (!checked) swipe.close()

    onClicked: {
        print("SwipeDelegate get clicked")
        if (!maximumWaypointsReached())
        {
            SharedAttributes.PoiDetailAttribute.selectedPlace = recentsProvider.places[index];
            SharedAttributes.PoiDetailAttribute.routeFromOutter = undefined;
            root.StackView.view.push(Qt.resolvedUrl("../PoiDetail/PoiDetailsScreen.qml"));
        }
    }

    checkable: true
    // cannot handle quick switch between item before animation finish
//    onPressed: {
//        if (delegate.ListView.view !== null) {
//            if (delegate.ListView.view.currentIndex !== index) {
//                var obj = delegate.ListView.view.currentItem
//                if (obj.swipe.complete)
//                    obj.swipe.close()
//                delegate.ListView.view.currentIndex = index;
//            }
//        }
//    }
    ListView.onRemove: SequentialAnimation {
        PropertyAction {
            target: delegate;property: "ListView.delayRemove";value: true
        }
        NumberAnimation {
            target: delegate;property: "scale";to: 0;easing.type: Easing.InOutQuad
        }
        //                 //unknow why below cannot work
        //                //NumberAnimation { target: delegate; property: "height"; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
        //                ParallelAnimation {
        //                         NumberAnimation { target: delegate; property: "height"; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
        //                         NumberAnimation { target: contentItem; property: "height"; to: 0; duration: 1000; easing.type: Easing.InOutQuad }
        //                }
        PropertyAction {
            target: delegate;property: "ListView.delayRemove";value: false
        }
    }
    swipe.left: ArrowCanvas {
        id: goButton

        width: parent.width
        height: parent.height

        x: contentItem.x - parent.width
        // below works but not intention
        //SwipeDelegate.onClicked: {
        onXChanged: {
//            if(x === 0) {
//                print("ArrowCanvas SwipeDelegate.onClicked")
//                var place = recentsProvider.places[index];
//                if (activeGuidanceFlow.enabled)
//                {
//                    if(!(maximumWaypointsReached()
//                        || sameWaypointExists(place.id))) {
//                        activeGuidanceFlow.addDestination(QtArpPlaceBuilder.destination(place));
//                    }
//                }
//                else {
//                    activeGuidanceFlow.startNavigation(QtArpPlaceBuilder.destination(place));
//                }
//                root.StackView.view.pop(null);
//            }
        }
        Label {
            id: goText
            objectName: "goText"
            text:  "goText"
            anchors {
                right: parent.right
                rightMargin: 65
                verticalCenter: parent.verticalCenter
            }
            color: "#ffffff"
            font.pixelSize: 38
            font.family: root.fontFamily
        }
    }

    swipe.right: Button {
        id: deleteLabel
        width: 195
        height: parent.height
        x: content.x + parent.width
        leftPadding: 0
        rightPadding: 0
        contentItem: Item {
            Image {
                anchors.right: parent.right
                anchors.rightMargin: 85
                anchors.verticalCenter: parent.verticalCenter
                source: "15inch/icon-60-delete-dark-blue.png"
            }
        }
        SwipeDelegate.onClicked: {    
            listModel.remove(index)
        }
        onClicked: {

           listModel.remove(index)
        }

        background: Item {
            // workaround current for listview is at right edge, so enlarge the button to right edge too
            height: parent.height
            width: 195
            Rectangle {
                color: "#bfbec4"
                height: parent.height - 60
                width: 1
                anchors.verticalCenter: parent.verticalCenter

            }
        }
    }
    // transparent
    background: Item {}
    topPadding: 12
    bottomPadding: 12
    leftPadding: 0
    rightPadding: 0

    contentItem: ColumnLayout {
        id: content
        spacing: 4

        RowLayout {
            id: firstRow
            spacing: 25
            Image {
                source: "15inch/icon-50-recents-dark-blue.png"
                Layout.leftMargin: 43
            }

            Label {
                text: place
                elide: Text.ElideRight
                Layout.fillWidth: true
                color: "#44516f"
                font.pixelSize: 35
                font.family: root.fontFamily

           }
           Label {
                text: distance
                elide: Text.ElideRight
                Layout.rightMargin: 35
                color: "#44516f"
                font.pixelSize: 35
                font.family: root.fontFamily
                horizontalAlignment: Text.AlignRight
            }
        }

        Label {
            id: detailed
            text: details
            Layout.leftMargin: 118
            Layout.maximumWidth: 820
            elide: Text.ElideRight
            color: "#767676"
            font.pixelSize: 35
            font.family: root.fontFamily
        }
    }

    states: [
        State {
            name: "rich_content"
        },
        State {
            name: "ev_content"
        },
        State {
            name: "detail"
            when: detailedAddress

            PropertyChanges {
                target: detailed
                visible: true
            }
        },
        State {
            name: "no_detail"
            when: ! detailedAddress

            PropertyChanges {
                target: detailed
                visible: false
            }
            PropertyChanges {
                target: delegate
                topPadding: 25
            }
            PropertyChanges {
                target: content
                spacing: 25
            }
        }
    ]
}
