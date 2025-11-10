import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Rectangle {
    id: button
    color: defaultColor
    property color defaultColor: Constants.contraverseColor
    property color enteredColor: Constants.accentColor
    property color clickedColor: Constants.softColor
    property color textDefaultColor: Constants.backgroundColor
    property color textEnteredColor: Constants.darkColor
    property color textClickedColor: Constants.darkColor
    property string text : "Choose"
    //property string text : "The Best Button You Ever Saw And Ever Will See"
    //property string text: "Button"
    width: 50
    height: 30
    radius: height/5

    signal buttonClicked();

    ParallelAnimation{
        id: enterAnimation
        ColorAnimation {
            target: button
            property: "color"
            to: button.enteredColor
            from: button.defaultColor
            duration: 100
        }
        ColorAnimation {
            target: text
            property: "color"
            to: button.textEnteredColor
            from: button.textDefaultColor
            duration: 100
        }
    }
    ParallelAnimation{
        id: exitAnimation
        ColorAnimation {
            target: button
            property: "color"
            to: button.defaultColor
            from: button.enteredColor
            duration: 100
        }
        ColorAnimation {
            target: text
            property: "color"
            to: button.textDefaultColor
            from: button.textEnteredColor
            duration: 100
        }
    }

    SequentialAnimation{
        id: clickedAnimation
        ParallelAnimation{
            ColorAnimation {
                target: button
                property: "color"
                to: button.clickedColor
                from: button.enteredColor
                duration: 100
            }
            ColorAnimation {
                target: text
                property: "color"
                to: button.textClickedColor
                from: button.textEnteredColor
                duration: 100
            }
        }
        ParallelAnimation{
            ColorAnimation {
                target: button
                property: "color"
                to: button.defaultColor
                from: button.clickedColor
                duration: 100
            }
            ColorAnimation {
                target: text
                property: "color"
                to: button.textDefaultColor
                from: button.textClickedColor
                duration: 100
            }
        }
    }

    Text {
        id: text
        anchors.fill: button
        font {
            family: "Montserrat"
            bold: true
            pixelSize: button.height/2;
        }
        //wrapMode: Text.WordWrap
        text: button.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: button.textDefaultColor
        //scale: Math.min((text.contentWidth<text.width?0.9:0.9*text.width/text.contentWidth),(text.contentHeight<text.height?0.9:0.9*text.height/text.contentHeight))
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: enterAnimation.start();
        onExited: exitAnimation.start();
        onClicked: {
            clickedAnimation.start();
            button.buttonClicked();
        }
    }
}
