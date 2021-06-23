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

  property real size
  property color conturTop
  property color conturBottom
  property color surfaceTop
  property color surfaceBottom
  property color baseConturTop: colorHelper.shade(root.buttonColor, ColorHelper.LightShade, 0.6)
  property color baseConturBottom: colorHelper.shade(root.buttonColor, ColorHelper.LightShade, 0.8)
  property color baseSurfaceTop: baseConturBottom
  property color baseSurfaceBottom: baseConturTop

  function buttonImage() {
    if (button.buttonType === DecorationOptions.DecorationButtonClose) {
      return '../../src/hydrogen-close.svg';
    } else if (button.buttonType === DecorationOptions.DecorationButtonMaximizeRestore) {
      return '../../src/hydrogen-maximize.svg';
    } else if (button.buttonType === DecorationOptions.DecorationButtonMinimize) {
      return '../../src/hydrogen-minimize.svg';
    } else {
      return '../../src/hydrogen-close.svg';
    }
  }

  width: size
  height: size
  // Button
//  Rectangle {
//      radius: 0
//      smooth: true
//      anchors.fill: parent
//      border.width: 1
//      border.color: '#9d9795'
//  }

  Item {
    property int imageWidth: button.width > 14 ? button.width - 2 * Math.floor(button.width/3.5) : button.width - 6
    property int imageHeight: button.height > 14 ? button.height - 2 * Math.floor(button.height/3.5) : button.height - 6
//      property string source: "image://plastik/" + button.buttonType + "/" + decoration.client.active + "/" + ((buttonType == DecorationOptions.DecorationButtonMaximizeRestore) ? decoration.client.maximized : button.toggled)
    property string source: buttonImage()
    anchors.fill: parent
    Image {
      id: image
      x: 0
      y: 0
      source: parent.source
      width: 24
      height: 24
      sourceSize.width: width
      sourceSize.height: height
    }

  }
  Component.onCompleted: {
      if (buttonType == DecorationOptions.DecorationButtonQuickHelp) {
          visible = Qt.binding(function() { return decoration.client.providesContextHelp});
      }
      if (buttonType == DecorationOptions.DecorationButtonApplicationMenu) {
          visible = Qt.binding(function() { return decoration.client.hasApplicationMenu; });
      }
  }
//    onHoveredChanged: colorize()
//    onPressedChanged: colorize()
}
