import QtQuick 2.7




import com.ford.hmicontrols 1.0 as FHC

FHC.Layout {
    id: root

    layoutId: "tnInteractiveListItemLayout"

    property string destName
    property string destAddress
    property string destDistance
    property string iconAsset
    property string typeIconAsset
    property bool dragable: true
    property bool hasEditButton: true
    property bool hasDistanceLabel: true
    property bool enabled: true
    property int hideOrShowAnimationDuration: 200
    property int slideThreshold
    property int deleteSeparatorLeftMarginInRecent
    property int addressDetailNormalTopMargin
    property int addressDetailSmallTopMargin
    property bool isMaximumWaypointsReached: false
    property var placeId
    property string goTextString

    signal deleteButtonActivated()
    signal editButtonActivated()
    signal itemActivated()
    signal goToNavigationActivated()

    FHC.StyleHelper {
        id: styleHelper
        styleId: "tnInteractiveListDelegateStyle"
    }

    Item {
        id: contentRect
        width: parent.width
        height: parent.height
        anchors {
            top: parent.top
        }

        FHC.AssetItem {
            id: icon
            objectName: "icon"
            anchors {
                left : parent.left
                top: parent.top
            }
            assetId: root.iconAsset
        }

        FHC.Text {
            id: addressName
            objectName: "addressName"
            anchors {
                left: icon.right
                top: parent.top
            }
            maximumLineCount: 1
            text: root.destName
            styleId: root.enabled? "tnSpecialListItemAddressNameTextStyle" : "tnSpecialListItemAddressNameDisabledTextStyle"
        }

        FHC.Text {
            id: addressDetail
            objectName: "addressDetail"
            width: root.addressDetailWidth
            maximumLineCount: 1
            anchors {
                left: icon.right
                top: parent.top
                topMargin: root.destName === "" ? root.addressDetailSmallTopMargin
                                                : root.addressDetailNormalTopMargin
            }
            text: root.destAddress
            styleId: root.enabled ? (root.destName === "" ? "tnSpecialListItemAddressNameTextStyle" : "tnSpecialListItemAddressDetailTextStyle") :
                                   "tnSpecialListItemAddressDetailDisabledTextStyle"
        }



        FHC.Text {
            id: distanceText
            objectName: "distanceText"
            height: 40
            width: 100

            anchors {
                top: parent.top
                right: parent.right
                rightMargin: 60

            }
            text: root.destDistance

        }
        FHC.AssetItem {
            id: typeIcon
            objectName: "typeIcon"
            width:60
            height:60
            anchors {
                right : parent.right
                rightMargin: -100
                top: parent.top

            }
            assetId: root.typeIconAsset
        }

        state: "hidden"
        states: [
            State {
                name: "hidden"
                PropertyChanges {
                    target: contentRect
                    x: 0
                }
            },
            State {
                name: "shown"
                PropertyChanges {
                    target: contentRect
                    x: 0 - (hasEditButton ? (editAreaItem.width + deleteRect.width) : deleteRect.width)
                }
            },
            State {
                name: "deletePending"
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "x"
                duration: hideOrShowAnimationDuration
                easing.type: Easing.InOutQuad
            }
        }

        NumberAnimation {
            id: anim
            target: contentRect;
            property: "x";
            to: 0;
            duration: hideOrShowAnimationDuration;
            easing.type: Easing.InOutQuad;
        }

        MouseArea {
            id: contentMouseArea
            anchors.fill: parent
            drag.axis: Drag.XAxis
            drag.target: parent
            drag.minimumX: !root.dragable ? 0: (0 - contentRect.width)
            drag.maximumX: !root.dragable ? 0 : parent.width
            property bool isDragging: drag.active

            onIsDraggingChanged: {
                if (!isDragging) {
                    root.applyInteraction();
                }
            }

            onPressed: {
                if (root.ListView.view !== null) {
                    if (root.ListView.view.currentIndex !== index) {
                        root.ListView.view.currentItem.hideDeleteButton();
                        root.ListView.view.currentIndex = index;
                    }
                }
            }

            onClicked: {
                contentRect.state = "hidden";
                root.itemActivated();
            }
        }
    }

    Item {
        id: editAreaItem
        objectName: "editAreaItem"
        height: root.height
        visible: hasEditButton
        anchors {
            left: contentRect.right
            verticalCenter: parent.verticalCenter
        }

        FHC.AssetItem {
            id: editSeparator
            objectName: "editSeparator"
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }
        }

        FHC.IconTextPushButton {
            id: editButton
            objectName: "editButton"
            anchors {
                left: editSeparator.right
                verticalCenter: parent.verticalCenter
            }

            onClicked: {
                contentRect.state = "hidden";
                root.editButtonActivated();
            }
        }
    }

    Item {
        id: deleteRect
        objectName: "deleteRect"
        height: parent.height
        anchors {
            verticalCenter: parent.verticalCenter
            left: hasEditButton? editAreaItem.right : contentRect.right
        }

        FHC.AssetItem {
            id: deleteSeparator
            objectName: "deleteSeparator"
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: hasEditButton? 0 : root.deleteSeparatorLeftMarginInRecent
            }
        }

        FHC.IconTextPushButton {
            id: deleteButton
            objectName: "deleteButton"
            anchors {
                left: deleteSeparator.right
                verticalCenter: parent.verticalCenter
            }

            onClicked: {
               listModel.remove(index)
            }
        }
    }

    FHC.AssetItem {
        id: itemSeparator
        objectName: "itemSeparator"
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
    }

    Row {
        id: goButton
        objectName: "goButton"
        width: parent.width
        anchors {
            top: parent.top
            bottom: itemSeparator.top
            right: contentRect.left
        }

        Rectangle {
            color: styleHelper.style.get("interactiveGoSlideBarColor")
            width: parent.width - goArrowRight.width
            height: parent.height

            FHC.Text {
                id: goText
                objectName: "goText"
                text: root.goTextString
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                width: text.width
            }
        }

        FHC.AssetItem {
            id: goArrowRight
            height:100
            width:50
            color: styleHelper.style.get("interactiveGoSlideBarColor")
            objectName: "goArrowRight"
            assetId:"tnArrowButtonRight"
        }
    }

    ListView.onAdd: NumberAnimation {
        target: root
        property: "height"
        from: 0
        duration: 1000
        to: root.height
        easing.type: Easing.InOutQuad
    }

    ListView.onRemove: SequentialAnimation {
        id: seqAnim
        PropertyAction {
            target: root;
            property: "ListView.delayRemove"
            value: true
        }

        NumberAnimation {
            target: root
            property: "height"
            to: 0
            easing.type: Easing.InOutQuad
        }

        PropertyAction {
            target: root;
            property: "ListView.delayRemove"
            value: false
        }
    }

    function hideDeleteButton() {
        contentRect.state = "hidden";
    }

    function showDeleteButton() {
        contentRect.state = "shown";
    }

    function applyInteraction() {
        if (contentRect.x < 0)
        {
            if (contentRect.x > -(contentRect.width) /2)
            {
                if (contentRect.state == "hidden")
                {
                    if (contentRect.x < -slideThreshold) {
                        contentRect.state = "shown";
                    }
                    else {
                        contentRect.x = 0;
                    }
                }
                else if (contentRect.state == "shown")
                {
                    if (contentRect.x > -(hasEditButton? (editAreaItem.width  + deleteRect.width) : deleteRect.width)) {
                        contentRect.state = "hidden";
                    }
                    else {
                        contentRect.x = -(hasEditButton? (editAreaItem.width  + deleteRect.width) : deleteRect.width);
                    }
                    listModel.remove(index)
                }
            }
            else
            {
                if (index === 0) {
                    contentRect.state = "deletePending"
                    timer.start();
                }

                root.deleteButtonActivated();
            }
        }
        else
        {
            if ((contentRect.x > contentRect.width / 2)
                && !maximumWaypointsReached()
                && !sameWaypointExists(placeId))
            {
                root.goToNavigationActivated();
                contentRect.x = contentRect.width;
            }
            else
            {
                contentRect.x = 0;
            }
            listModel.remove(index)
        }
    }

    Timer {
        id: timer
        repeat: false
        interval: 0

        onTriggered: {
            contentRect.state = "shown";
        }
    }
}
