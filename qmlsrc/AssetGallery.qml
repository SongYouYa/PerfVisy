import QtQuick 2.6
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.1

import com.ford.hmicontrols 1.0 as HMIControls

import "components"

Gallery {
    id: root
    anchors.fill: parent

    HMIControls.AssetItem {
        id: backgroundAssetItem
        parent: root.parent
        x: 0
        y: 0
        z: -1
        anchors.fill: parent
        visible: assetId !== ""
    }

    function sliderToColor(x) {
        return Qt.rgba(saturate(Math.max(2 - 6 * x, 6 * x - 4)),
                       saturate(Math.min(6 * x, 4 - 6 * x)),
                       saturate(Math.min(6 * x - 2, 6 - 6 * x)))
    }

    function saturate(x) {
        return Math.min(Math.max(x, 0), 1)
    }

    property variant assetTypeModel: ListModel {
        ListElement {
            itemText: "Background asset-set"
            assetId: "viewBackground"
        }
        ListElement {
            itemText: "Linear Gradient (using theme highlight colors)"
            assetId: "linearHighlightGradient"
        }
        ListElement {
            itemText: "Radial Gradient (with other style colors)"
            assetId: "radialGradient"
        }
        ListElement {
            itemText: "Nine-slice (AKA border image)"
            assetId: "gradientBorder"
        }
        ListElement {
            itemText: "SVG image (an apple)"
            assetId: "apple"
        }
        ListElement {
            itemText: "Main background"
            assetId: "mainBackground"
        }
        ListElement {
            itemText: "Popup"
            assetId: "popup"
        }
        ListElement {
            itemText: "None (effectively transparent)"
            assetId: ""
        }
    }

    property ShaderEffectSource theSource: ShaderEffectSource {
        sourceItem: fordLogo
    }

    property variant fordLogo: HMIControls.ThemeableImage {
        id: fordLogo
        assetId: "fordLogo"
        width: 180
        visible: false
        fillMode: Image.PreserveAspectFit
    }

    GalleryExhibit {
        label: qsTr("Select background asset")
        HMIControls.ComboBox {
            id: styleSelector
            width: itemWidth
            model: assetTypeModel
            useListDataModel: true
            property int itemWidth: 550
            property int itemHeight: 50
            onCurrentIndexChanged: {
                backgroundAssetItem.assetId = model.get(currentIndex).assetId;
            }
        }

        HMIControls.ComboBox {
            id: stateSelector
            width: 250
            model: backgroundAssetItem.assetStates
            onCurrentIndexChanged: {
               if (currentIndex >= 0 && currentIndex < backgroundAssetItem.assetStates.length) {
                    backgroundAssetItem.currentAssetState = backgroundAssetItem.assetStates[currentIndex];
               } else {
                   backgroundAssetItem.currentAssetState = ""; // just use default
               }
            }
            visible: backgroundAssetItem.assetStates.length > 0
        }
    }

    GalleryExhibit {
        label: qsTr("Button with icon and background")
        placard: qsTr("From theme asset: click to change asset type")
        HMIControls.IconTextPushButton {
            id: assetButton

            height: 160
            width: assetHelper.assetType === HMIControls.AssetHelper.NINE_SLICE ? parent.width - x : 150
            HMIControls.AssetHelper {
                id: assetHelper
                assetId: assetButtonBackground.assetId
            }

            property int modelIndex: 2  // BorderImage
            background: HMIControls.AssetItem {
                id: assetButtonBackground
                anchors.fill: assetButton
                assetId: assetTypeModel.get(assetButton.modelIndex).assetId
            }
            text: assetTypeModel.get(assetButton.modelIndex).itemText

            iconAssetId: "settingsBluetooth"

            onClicked: {
                if (modelIndex === (assetTypeModel.count-1)) {
                    modelIndex = 0;
                } else {
                    modelIndex += 1;
                }
            }
        }
    }

    GalleryExhibit {
        label: qsTr("Button with colourized icon")
        placard: qsTr("Colourization provides statefullness of the icon.")
        HMIControls.IconTextPushButton {
            id: colourizedIconButton

            // This style has colourization properties set
            styleId: "ColourizedIconButtonStyle"

            height: 125
            width: 200

            iconAssetId: "fordLogo"
            text: qsTr("Colourized Icon")
            autoSelectOnClick: true
        }
    }

    GalleryExhibit {
        label: "Button with absolute path!"
        placard: "Asset using absolute path to icon instead of assetId"
        HMIControls.IconTextPushButton {
            text: qsTr("Click Me")
            iconAssetId: absoluteStylehelper.style.get("assetId",
                "/fs/storage/usr/hmithemes/Ford-MY20/assets/icons/40x40_icons/shader_icons/system/icn_roadwork.png")
            pathIsAbsolute: absoluteStylehelper.style.get("pathIsAbsolute", true)

            width: 150
            height: 100
        }

        HMIControls.StyleHelper {
            id: absoluteStylehelper
            styleId: "absolutePathStyle"
        }
    }

    GalleryExhibit {
        label: "Button with Pre-Colored icon!"
        placard: "Pre-Colored icon without being shaded"
        HMIControls.IconTextPushButton {
            text: qsTr("Click Me")
            iconAssetId: "iconSirius"

            width: 150
            height: 100
        }
    }

    GalleryExhibit {
        label: qsTr("Shadeable Image")
        placard: qsTr("Exposed through AssetItem")

        Rectangle {
            height: 200
            width: 400
            color: "lightgrey"
            HMIControls.AssetItem {
                id: coloredLogo
                assetId: "fordLogoShaderColorize"
            }

            HMIControls.AssetItem {
                assetId: "fordLogoShaderWobble"
                anchors.left: coloredLogo.right
            }
        }
    }

    GalleryExhibit {
        id: shadeableImageExhibit
        label: qsTr("Shadeable Image: Internal Usage")
        placard: qsTr("Allows binding and dynamic changes")


        property var theDynamicObject;

        HMIControls.AssetHelper {
            id: fragShader
        }

        HMIControls.AssetHelper {
            id: vertShader
        }

        HMIControls.AssetHelper {
            id: asset
        }

        property string comboStyle: "comboBoxListItemStyle"

        property variant fragModel: ListModel {
            ListElement {
                itemText: "None"
                assetId: ""
                binding: ""
                control: ""
            }
            ListElement {
                itemText: "Color Effect"
                assetId: "shaderColorize"
                binding: "property color fragmentColor: root.sliderToColor(colorSlider2.value);"
                control: "HMIControls.Slider {
                            id: colorSlider2
                            height: 40
                            width: 200
                            anchors.left: myItem.right
                        }"
            }
            ListElement {
                itemText: "Wobble Effect"
                assetId: "shaderWobble"
                binding: "property real fragmentAmplitude: 0.04 * wobbleSlider2.value
                          property real fragmentFrequency: 20
                          property real fragmentTime: 0
                          NumberAnimation on fragmentTime { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 600 }"
                control: "HMIControls.Slider {
                            id: wobbleSlider2
                            value: 0.1
                            height: 40
                            width: 200
                            anchors.left: myItem.right
                         }"
            }
        }

        property variant vertModel: ListModel {
            ListElement {
                itemText: "None"
                assetId: ""
                binding: ""
                control: ""
            }
            ListElement {
                itemText: "Vertex Shader"
                assetId: "shaderVanish"
                binding: "property real vertexBend: 0
                          property real vertexMinimize: 0
                          property real vertexSide: vanishSlider2.value
                          SequentialAnimation on vertexBend {
                              loops: Animation.Infinite
                              NumberAnimation { to: 1; duration: 700; easing.type: Easing.InOutSine }
                              PauseAnimation { duration: 1600 }
                              NumberAnimation { to: 0; duration: 700; easing.type: Easing.InOutSine }
                              PauseAnimation { duration: 1000 }
                          }
                          SequentialAnimation on vertexMinimize {
                              loops: Animation.Infinite
                              PauseAnimation { duration: 300 }
                              NumberAnimation { to: 1; duration: 700; easing.type: Easing.InOutSine }
                              PauseAnimation { duration: 1000 }
                              NumberAnimation { to: 0; duration: 700; easing.type: Easing.InOutSine }
                             PauseAnimation { duration: 1300 }
                          }"
                control: "HMIControls.Slider {
                            id: vanishSlider2
                            height: 10
                            width: 200
                            anchors.left: myItem.right
                            anchors.top: fragShader.assetId === 'shaderColorize'? colorSlider2.bottom : wobbleSlider2.bottom;
                          }"
            }
        }

        property variant assetModel: ListModel {
            ListElement {
                itemText: "Ford Logo"
                assetId: "fordLogo"
            }
            ListElement {
                itemText: "Apple"
                assetId: "apple"
            }
            ListElement {
                itemText: "Car"
                assetId: "diffuseCar1"
            }
        }



        Column {
            id: selectors

            HMIControls.ComboBox {
                id: assetSelector

                model: shadeableImageExhibit.assetModel
                useListDataModel: true
                width: itemWidth

                property int itemWidth: 200
                property int itemHeight: 50

                onCurrentIndexChanged: {
                    shadeableImageExhibit.theDynamicObject.destroy()
                    asset.assetId = shadeableImageExhibit.assetModel.get(currentIndex).assetId;
                    shadeableImageExhibit.theDynamicObject = shadeableImageExhibit.createShadeableImage(asset.assetId,
                                                                                                        fragShader.assetId,
                                                                                                        vertShader.assetId)
                }
            }

            HMIControls.ComboBox {
                id: fragShaderSelector
                z:1

                model: shadeableImageExhibit.fragModel
                useListDataModel: true
                width: itemWidth

                property int itemWidth: 200
                property int itemHeight: 50

                onCurrentIndexChanged: {
                    shadeableImageExhibit.theDynamicObject.destroy()
                    fragShader.assetId = shadeableImageExhibit.fragModel.get(currentIndex).assetId;
                    shadeableImageExhibit.fragControl = shadeableImageExhibit.fragModel.get(currentIndex).control;
                    shadeableImageExhibit.theDynamicObject = shadeableImageExhibit.createShadeableImage(asset.assetId,
                                                                                                        fragShader.assetId,
                                                                                                        vertShader.assetId)
                }
            }

            HMIControls.ComboBox {
                id: vertShaderSelector
                z:0

                model: shadeableImageExhibit.vertModel
                useListDataModel: true
                width: itemWidth

                property int itemWidth: 200
                property int itemHeight: 50

                onCurrentIndexChanged: {
                    shadeableImageExhibit.theDynamicObject.destroy()
                    vertShader.assetId = shadeableImageExhibit.vertModel.get(currentIndex).assetId;
                    shadeableImageExhibit.vertControl = shadeableImageExhibit.vertModel.get(currentIndex).control;
                    shadeableImageExhibit.theDynamicObject = shadeableImageExhibit.createShadeableImage(asset.assetId,
                                                                                                        fragShader.assetId,
                                                                                                        vertShader.assetId)
                }
            }
        }

        property string fragControl;
        property string vertControl;

        function createShadeableImage (assetId, fragmentShaderId, vertexShaderId) {
            var props = 'assetId: "' +  assetId + '";'

            if (fragmentShaderId) {
                props = props + 'fragmentShaderId: "' +  fragmentShaderId + '";'
                props = props + shadeableImageExhibit.fragModel.get(fragShaderSelector.currentIndex).binding
            }

            if (vertexShaderId) {
                props = props + 'vertexShaderId: "' +  vertexShaderId + '";'
                props = props + shadeableImageExhibit.vertModel.get(vertShaderSelector.currentIndex).binding
            }

            var qmlCode =
               'import QtQuick 2.0
                import com.ford.hmicontrols 1.0 as HMIControls

                Rectangle {
                    id: theRect
                    height: 200
                    width: 196
                    color: "lightgrey"

                    Item {
                        id: myItem
                        height: parent.height
                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter;

                        HMIControls.ShadeableImage {
                            id: shadeableImage
                            width: parent.width
                            height: parent.height
                            anchors.horizontalCenter: parent.horizontalCenter;

                            ' + props + '
                        }

                        ' + shadeableImageExhibit.fragControl + shadeableImageExhibit.vertControl + '
                    }
                }'

            return Qt.createQmlObject(qmlCode, shadeableImageExhibit, 'shadeableImage')
        }

        Component.onCompleted: {
            asset.assetId = "fordLogo"
            shadeableImageExhibit.theDynamicObject = shadeableImageExhibit.createShadeableImage(asset.assetId,
                                                                                                fragShader.assetId,
                                                                                                vertShader.assetId)
        }
    }


    GalleryExhibit {
        label: "Shader (Shadow Effect)"
        z:-1
        Rectangle {
            height: 152
            width: 196
            color: "lightgrey"

            Item {
                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter;

                ShaderEffect {
                    id: shadowShader

                    width: fordLogo.width
                    height: fordLogo.height
                    anchors.horizontalCenter: parent.horizontalCenter;

                    property variant source: theSource
                    property variant shadow: ShaderEffectSource {
                        sourceItem: ShaderEffect {
                            width: shadowShader.width
                            height: shadowShader.height
                            property size fragmentDelta: Qt.size(0.0, 1.0 / height)
                            property variant source: ShaderEffectSource {
                                sourceItem: ShaderEffect {
                                    width: shadowShader.width
                                    height: shadowShader.height
                                    property size fragmentDelta: Qt.size(1.0 / width, 0.0)
                                    property variant source: theSource
                                    fragmentShader: shadow.contents
                                }
                            }

                            fragmentShader: shadow.contents
                        }
                    }
                    property real angle: 0
                    property point offset: Qt.point(15.0 * Math.cos(angle), 15.0 * Math.sin(angle))
                    NumberAnimation on angle { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 6000 }
                    property size delta: Qt.size(offset.x / width, offset.y / height)
                    property real darkness: shadowSlider.value
                    fragmentShader: "
                        uniform lowp float qt_Opacity;
                        uniform highp vec2 offset;
                        uniform sampler2D source;
                        uniform sampler2D shadow;
                        uniform highp float darkness;
                        uniform highp vec2 delta;
                        varying highp vec2 qt_TexCoord0;
                        void main() {
                            lowp vec4 fg = texture2D(source, qt_TexCoord0);
                            lowp vec4 bg = texture2D(shadow, qt_TexCoord0 + delta);
                            gl_FragColor = (fg + vec4(0., 0., 0., darkness * bg.a) * (1. - fg.a)) * qt_Opacity;
                        }"

                    HMIControls.AssetHelper {
                        id: shadow
                        assetId: "shaderShadow"
                    }
                }

                HMIControls.Slider {
                    id: shadowSlider
                    value: 0.5
                    height: 10
                    anchors.left: shadowShader.left
                    anchors.right: shadowShader.right
                    anchors.top: shadowShader.bottom
                }
            }
        }
    }

    GalleryExhibit {
        label: "Shader (Wobble Effect)"
        Rectangle {
            height: 152
            width: 196
            color: "lightgrey"

            Item {
                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter;

                ShaderEffect {
                    id: wobbleShader

                    width: fordLogo.width
                    height: fordLogo.height
                    anchors.horizontalCenter: parent.horizontalCenter;
                    property variant source: theSource
                    property real fragmentAmplitude: 0.04 * wobbleSlider.value
                    property real fragmentFrequency: 20
                    property real fragmentTime: 0
                    NumberAnimation on fragmentTime { loops: Animation.Infinite; from: 0; to: Math.PI * 2; duration: 600 }
                    fragmentShader: wobble.contents

                    HMIControls.AssetHelper {
                        id: wobble
                        assetId: "shaderWobble"
                    }
                }

                HMIControls.Slider {
                    id: wobbleSlider
                    value: 0.1
                    height: 10
                    anchors.left: wobbleShader.left
                    anchors.right: wobbleShader.right
                    anchors.top: wobbleShader.bottom
                }
            }
        }
    }

    GalleryExhibit {
        label: "Shader (Color Effect)"
        Rectangle {
            height: 152
            width: 196
            color: "lightgrey"

            Item {
                id: theItem

                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter;

                HMIControls.ColorEffect {
                    id: colorizeShader

                    width: fordLogo.width
                    height: fordLogo.height
                    anchors.horizontalCenter: parent.horizontalCenter;
                    fragmentColor: root.sliderToColor(colorSlider.value)
                    target: theSource
                }

                HMIControls.Slider {
                    id: colorSlider
                    height: 10
                    anchors.left: colorizeShader.left
                    anchors.right: colorizeShader.right
                    anchors.top: colorizeShader.bottom
                }
            }
        }
    }

    GalleryExhibit {
        label: "Shader (Vertex Shader)"
        Rectangle {
            height: 152
            width: 196
            color: "lightgrey"

            Item {
                height: childrenRect.height
                anchors.horizontalCenter: parent.horizontalCenter;

                ShaderEffect {
                    id: vanishShader

                    width: fordLogo.width
                    height: fordLogo.height

                    anchors.horizontalCenter: parent.horizontalCenter;

                    property variant source: theSource
                    property real vertexBend: 0
                    property real vertexMinimize: 0
                    property real vertexSide: vanishSlider.value
                    SequentialAnimation on vertexBend {
                        loops: Animation.Infinite
                        NumberAnimation { to: 1; duration: 700; easing.type: Easing.InOutSine }
                        PauseAnimation { duration: 1600 }
                        NumberAnimation { to: 0; duration: 700; easing.type: Easing.InOutSine }
                        PauseAnimation { duration: 1000 }
                    }
                    SequentialAnimation on vertexMinimize {
                        loops: Animation.Infinite
                        PauseAnimation { duration: 300 }
                        NumberAnimation { to: 1; duration: 700; easing.type: Easing.InOutSine }
                        PauseAnimation { duration: 1000 }
                        NumberAnimation { to: 0; duration: 700; easing.type: Easing.InOutSine }
                        PauseAnimation { duration: 1300 }
                    }

                    mesh: Qt.size(10, 10)
                    vertexShader: vanishAsset.contents

                    HMIControls.AssetHelper {
                        id: vanishAsset
                        assetId: "shaderVanish"
                    }
                }

                HMIControls.Slider {
                    id: vanishSlider
                    height: 10
                    anchors.left: vanishShader.left
                    anchors.right: vanishShader.right
                    anchors.top: vanishShader.bottom
                }
            }
        }
    }

    GalleryExhibit {
        label: qsTr("Media Query Override")
        placard: qsTr("asset - period override: day")
        HMIControls.AssetItem {
            id: mediaQueryAsset
            height: 150
            width: 150
            assetHelper: HMIControls.AssetHelper {
                id: mediaQueryAssetHelper
                assetId: "mainBackground"
                displayMode: "day"
            }
        }
    }

    GalleryExhibit {
        label: qsTr("Media Query Override")
        placard: qsTr("asset-set - period override: night")
        HMIControls.AssetItem {
            id: mediaQueryAssetSet
            height: 150
            width: 150
            assetHelper: HMIControls.AssetHelper {
                id: mediaQueryAssetSetHelper
                assetId: "roundButton"
                displayMode: "night"
            }
        }
    }
}
