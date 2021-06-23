/********************************************************************
Copyright (C) 2012 Martin Gräßlin <mgraesslin@kde.org>
Copyright (C) 2015-2017 Giacomo Barazzetti <giacomosrv@gmail.com>
Copyright (C) 2020 Yujeonja <hardboiled65@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/
import QtQuick 2.0
import org.kde.kwin.decoration 0.1
import org.kde.kwin.decorations.plastik 1.0

Decoration {
    id: root

    ColorHelper { id: colorHelper }
    DecorationOptions { id: options; deco: decoration }

    property int borderSize: decorationSettings.borderSize
    property int buttonSize: 23
    property alias titleAlignment: caption.horizontalAlignment
    property color titleBarColor: options.titleBarColor
    property color borderColor: options.borderColor
    property bool titleShadow: true
    property int roundness : 5
    alpha: false

    Rectangle {
        id: baseRect
        radius: 8
        color: "transparent" //root.borderColor
        anchors { fill: parent }
        border {
            width: decoration.client.maximized ? 0 : 1
            color: "blue" //colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 1.0)
        }

        Rectangle {
            id: borderLeft
            anchors {
                left: parent.left
                top: top.bottom
                bottom: parent.bottom
                leftMargin: 1
                topMargin: -3
                bottomMargin: 1
            }
            visible: !decoration.client.maximized && !decoration.client.shaded
            width: root.borders.left
            color: "white"
            Rectangle {
                id: topLeftDecoration
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: top.height/1.8
                color: root.titleBarColor
                Rectangle {
                    id: topLeftDecoration2
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                    }
                    height: 1
                    width: parent.width
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
            }
        }
        Rectangle {
            id: borderRight
            anchors {
                right: parent.right
                top: top.bottom
                bottom: parent.bottom
                rightMargin: 1
                topMargin: -3
                bottomMargin: 1
            }
            visible: !decoration.client.maximized && !decoration.client.shaded
            width: root.borders.right
            color: "white"
            Rectangle {
                id: topRightDecoration
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: top.height/1.8
                color: root.titleBarColor
                Rectangle {
                    id: topRightDecoration2
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }
                    height: 1
                    width: parent.width
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
            }
        }
        Rectangle {
            id: borderBottom
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                leftMargin: 1
                rightMargin: 1
                bottomMargin: 1
            }
            height: root.borders.bottom
            visible: !decoration.client.maximized
            color: "white"
            Rectangle {
                id: bottomLeftDecoration
                anchors {
                    left: parent.left
                    bottom: parent.bottom
                }
                height: root.borders.bottom > 10 ? root.borders.bottom + top.height / 2 : top.height / 2
                width: height
                color: root.titleBarColor
                Rectangle {
                    id: bottomLeftDecoration2
                    anchors {
                        top: parent.top
                        left: parent.left
                    }
                    height: 1
                    width: parent.width
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
                Rectangle {
                    id: bottomLeftDecoration3
                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }
                    height: parent.height
                    width: 1
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
            }
            Rectangle {
                id: bottomRightDecoration
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                }
                height: root.borders.bottom > 10 ? root.borders.bottom + top.height / 2 : top.height / 2
                width: height
                color: root.titleBarColor
                Rectangle {
                    id: bottomRightDecoration2
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                    height: 1
                    width: parent.width
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
                Rectangle {
                    id: bottomRightDecoration3
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                    }
                    height: parent.height
                    width: 1
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, 0.0) // as baseRect border
                }
            }
        }

        // Title bar.
        Rectangle {
            id: top
            Text {
              id: debugText
              visible: false
              x: 128

              text: "debug"
            }

            radius: 8
            property int topMargin: 1
            property real normalHeight: titleRow.normalHeight + topMargin + 1
            property real maximizedHeight: titleRow.maximizedHeight + 1
            height: decoration.client.maximized ? maximizedHeight + 2 : normalHeight + 2
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: decoration.client.maximized ? 0 : top.topMargin
                leftMargin: decoration.client.maximized ? 0 : 1
                rightMargin: decoration.client.maximized ? 0 : 1
            }
            color: decoration.client.active ? "#bebab3" : "#a0a0a0"

            Item {
                id: titleRow
                property real captionHeight: 32
                property int topMargin: 2
                property int bottomMargin: 2
                property real normalHeight: captionHeight + bottomMargin + topMargin
                property real maximizedHeight: captionHeight + bottomMargin
                anchors {
                    fill: parent
                    topMargin: decoration.client.maximized ? 0 : titleRow.topMargin
                    leftMargin: decoration.client.maximized ? 0 : 4
                    rightMargin: decoration.client.maximized ? 0 : 4
                    bottomMargin: titleRow.bottomMargin
                }

                // Title bar title.
                Item {
                  id: iconAndCaption

                  anchors.centerIn: parent

                  width: parent.width
                  height: caption.implicitHeight

//                  Rectangle {
//                    anchors.fill: parent
//                    color: "#50ff0000"
//                  }
                  GalaxyButton {
                    id: closeButton

                    anchors.verticalCenter: parent.verticalCenter

                    buttonType: DecorationOptions.DecorationButtonClose
                    size: root.buttonSize
                  }
                  GalaxyButton {
                    id: maximizeButton

                    anchors.left: closeButton.right
                    anchors.verticalCenter: parent.verticalCenter

                    buttonType: DecorationOptions.DecorationButtonMaximizeRestore
                    size: root.buttonSize
                  }
                  GalaxyButton {
                    id: minimizeButton

                    anchors.left: maximizeButton.right
                    anchors.verticalCenter: parent.verticalCenter

                    buttonType: DecorationOptions.DecorationButtonMinimize
                    size: root.buttonSize
                  }

                  MenuButton {
                    anchors.right: caption.left
                    width: root.buttonSize
                    height: root.buttonSize
                  }

                  Text {
                    id: caption
                    anchors.centerIn: parent

                    textFormat: Text.PlainText
                    color: "black"
                    text: decoration.client.caption
                    font: options.titleFont
                    // font.pixelSize: 14
                    elide: Text.ElideMiddle
                    renderType: Text.NativeRendering
                  }
                }
                ButtonGroup {
                    id: rightButtonGroup
                    spacing: 4
                    explicitSpacer: root.buttonSize
                    menuButton: menuButtonComponent
                    appMenuButton: appMenuButtonComponent
                    minimizeButton: minimizeButtonComponent
                    maximizeButton: maximizeButtonComponent
                    keepBelowButton: keepBelowButtonComponent
                    keepAboveButton: keepAboveButtonComponent
                    helpButton: helpButtonComponent
                    shadeButton: shadeButtonComponent
                    allDesktopsButton: stickyButtonComponent
                    closeButton: closeButtonComponent
                    buttons: options.titleButtonsRight
                    anchors {
                        top: parent.top
                        right: parent.right
                        topMargin: 4
                    }
                }
                Component.onCompleted: {
                    decoration.installTitleItem(titleRow);
                }
            }
        }

        Item {
            id: innerBorder
            anchors.fill: parent
            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: root.borders.left - 1
                    rightMargin: root.borders.right - 1
                    topMargin: root.borders.top - 1
                    bottomMargin: root.borders.bottom - 1
                }
                border {
                    width: 1
                    color: colorHelper.shade(root.borderColor, ColorHelper.ShadowShade, -0.1)
                }
                Rectangle {
                    id: bottomInnerBorder
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                        leftMargin: 1
                        rightMargin: 1
                    }
                    height: 1
                    color: Qt.lighter(root.borderColor, 0.8)
                }
                visible: !decoration.client.maximized  && !decoration.client.shaded
                color: root.borderColor //just a plain window inside for the preview
            }
        }
    }

    Component {
        id: maximizeButtonComponent
        GalaxyButton {
            objectName: "maximizeButton"
            buttonType: DecorationOptions.DecorationButtonMaximizeRestore
            size: root.buttonSize
        }
    }
    Component {
        id: keepBelowButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonKeepBelow
            size: root.buttonSize
        }
    }
    Component {
        id: keepAboveButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonKeepAbove
            size: root.buttonSize
        }
    }
    Component {
        id: helpButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonQuickHelp
            size: root.buttonSize
        }
    }
    Component {
        id: minimizeButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonMinimize
            size: root.buttonSize
        }
    }
    Component {
        id: shadeButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonShade
            size: root.buttonSize
        }
    }
    Component {
        id: stickyButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonOnAllDesktops
            size: root.buttonSize
        }
    }
    Component {
        id: closeButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonClose
            size: root.buttonSize
        }
    }
    Component {
        id: menuButtonComponent
        MenuButton {
            width: root.buttonSize
            height: root.buttonSize
        }
    }
    Component {
        id: appMenuButtonComponent
        GalaxyButton {
            buttonType: DecorationOptions.DecorationButtonApplicationMenu
            size: root.buttonSize
        }
    }
    Component.onCompleted: {
        borders.setBorders(1);
        borders.setTitle(top.normalHeight);
        maximizedBorders.setTitle(top.maximizedHeight);
    }
}
