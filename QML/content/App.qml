// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0

import QtQuick 6.2
import QtQuick.Window 6.2
import Mera_Converter

Window {
    width: Constants.width
    height: Constants.height

    visible: true
    title: "Mera_Converter"

    Screen01 {
        id: mainScreen
        width: 3*parent.width/8
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Screen02 {
        id: secondScreen
        width: 5*parent.width/8
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
    }

    Rectangle {
        id: split
        color: Constants.darkColor
        width: 1
        anchors {
            left: mainScreen.right
            top: parent.top
            bottom: parent.bottom
            topMargin: parent.height/20
            bottomMargin: parent.height/20
        }
    }
}

