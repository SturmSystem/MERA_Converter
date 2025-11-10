import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Rectangle {
    width: parent.width/2
    height: 30
    color: Constants.softColor
    property string name : "Name"

    Connections {
        target: app
        onStart: {
            app.nameChanged(inputTextField.text)
            focus = false
        }
    }

    Rectangle {
        height: parent.height/4
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.top
        }
        radius: height/2
        color: parent.color
    }
    Rectangle {
        height: 1
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        color: Constants.darkColor
    }

    TextInput {
        id: inputTextField
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        font {
            family: "Segoe UI"
            //bold: true
            pixelSize: 14 //parent.height/2
        }
        clip: true
        text: parent.name
        horizontalAlignment: contentWidth>width?Text.AlignRight:Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        color: "black"
        selectByMouse: true
        onActiveFocusChanged: {
                if(!activeFocus){
                    accepted()
                    focus = false
                }
            }
            Keys.onReturnPressed: {
                focus = false
            }
        onAccepted: parent.name = text
    }
}
