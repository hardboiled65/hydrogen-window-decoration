/********************************************************************
Copyright (C) 2012 Martin Gräßlin <mgraesslin@kde.org>
Copyright (C) 2015-2017 Giacomo Barazzetti <giacomosrv@gmail.com>

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
import QtGraphicalEffects 1.0
import org.kde.kwin.decoration 0.1
import org.kde.kwin.decorations.plastik 1.0

DecorationButton {
    id: button
    function colorize() {
        var highlightColor = null;
        if (button.pressed) {
            if (button.buttonType == DecorationOptions.DecorationButtonClose) {
                highlightColor = colorHelper.foreground(decoration.client.active, ColorHelper.NegativeText);
            } else {
                highlightColor = options.titleBarColor;
            }
            highlightColor = colorHelper.shade(highlightColor, ColorHelper.ShadowShade);
            highlightColor = colorHelper.multiplyAlpha(highlightColor, 0.3);
        } else if (button.hovered) {
            if (button.buttonType == DecorationOptions.DecorationButtonClose) {
                highlightColor = colorHelper.foreground(decoration.client.active, ColorHelper.NegativeText);
            } else {
                highlightColor = options.titleBarColor;
            }
            highlightColor = colorHelper.shade(highlightColor, ColorHelper.LightShade, Math.min(1.0, colorHelper.contrast + 0.4));
            highlightColor = colorHelper.multiplyAlpha(highlightColor, 0.6);
        }
        if (highlightColor) {
            button.surfaceTop = Qt.tint(button.baseSurfaceTop, highlightColor);
            button.surfaceBottom = Qt.tint(button.baseSurfaceBottom, highlightColor);
            highlightColor = colorHelper.multiplyAlpha(highlightColor, 0.4);
            button.conturTop = Qt.tint(button.baseConturTop, highlightColor);
            button.conturBottom = Qt.tint(button.baseConturBottom, highlightColor);
        } else {
            button.conturTop = button.baseConturTop;
            button.conturBottom = button.baseConturBottom;
            button.surfaceTop = button.baseSurfaceTop;
            button.surfaceBottom = button.baseSurfaceBottom;
        }
    }
    property real size
    property color conturTop
    property color conturBottom
    property color surfaceTop
    property color surfaceBottom
    property color baseConturTop: colorHelper.shade(root.buttonColor, ColorHelper.LightShade, 0.6)
    property color baseConturBottom: colorHelper.shade(root.buttonColor, ColorHelper.LightShade, 0.8)
    property color baseSurfaceTop: baseConturBottom
    property color baseSurfaceBottom: baseConturTop
    width: size
    height: size
    // Button
    Rectangle {
        radius: width / 2
        smooth: true
        anchors.fill: parent
        border.width: 1
        border.color: '#9d9795'
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: '#f0efee'
            }
            GradientStop {
                position: 1.0
                color: '#d6d1ce'
            }
        }
    }
    Item {
        property int imageWidth: button.width > 14 ? button.width - 2 * Math.floor(button.width/3.5) : button.width - 6
        property int imageHeight: button.height > 14 ? button.height - 2 * Math.floor(button.height/3.5) : button.height - 6
        property string source: "image://plastik/" + button.buttonType + "/" + decoration.client.active + "/" + ((buttonType == DecorationOptions.DecorationButtonMaximizeRestore) ? decoration.client.maximized : button.toggled)
        anchors.fill: parent
        Image {
            id: image
            x: button.x + button.width / 2 - width / 2
            y: button.y + button.height / 2 - height / 2 + (button.pressed ? 1 : 0)
            source: parent.source
            width: parent.imageWidth
            height: parent.imageHeight
            sourceSize.width: width
            sourceSize.height: height
        }
        ColorOverlay {
            anchors.fill: image
            source: image
            color: options.titleBarColor
        }
    }
    Component.onCompleted: {
        colorize();
        if (buttonType == DecorationOptions.DecorationButtonQuickHelp) {
            visible = Qt.binding(function() { return decoration.client.providesContextHelp});
        }
        if (buttonType == DecorationOptions.DecorationButtonApplicationMenu) {
            visible = Qt.binding(function() { return decoration.client.hasApplicationMenu; });
        }
    }
    onHoveredChanged: colorize()
    onPressedChanged: colorize()
    Connections {
        target: decoration.client
        onActiveChanged: button.colorize()
    }
    Connections {
        target: options
        onColorsChanged: button.colorize();
    }
}
