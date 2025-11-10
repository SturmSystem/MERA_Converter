import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Item {
    id: main
    width: parent.width/2
    height: 30
    property int number : 20000

    property color color : Constants.backgroundColor
    property bool externalChange : false

    function externalNumberSet(num){
        externalChange = true
        number = num
        externalChange = false
    }

    onNumberChanged: {
        numberText.text = number
    }//*/

    onSetNumber: {
        activeMode()
        console.log(1)
        numberText.focus = true
        console.log(2)
        number = num
        //numberText.focus = false
    }

    signal disactivate()
    signal activeMode()
    signal setNumber(num: int)


    Rectangle {
        anchors.fill: parent
        color: parent.color
        opacity: 0.2
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
        id: numberText
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        font {
            family: "Segoe UI"
            bold: true
            pixelSize: 14
        }
        clip: true
        text: parent.number
        onTextChanged: {
            if(!externalChange)
                main.setNumber(text*1)
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "black"
        opacity: 1.0
        selectByMouse: true
        onActiveFocusChanged: {
                if(!activeFocus){
                    //accepted()
                    //parent.setNumber(text)
                    focus = false
                    //main.disactivate()
                    //console.log("Active focus changed")
                }
                else
                    main.activeMode()
            }
            Keys.onReturnPressed: {
                //main.setNumber(text)
                main.disactivate()
                focus = false
            }
        validator: IntValidator {bottom: 0; top: 500000}
        //onAccepted: parent.setNumber(text)
    }

    /*
    Rectangle {
        id: upperArrow
        color: parent.color
        width: parent.width/4
        height: parent.height/2
        anchors {
            right: parent.right
            top: parent.top
        }

        Text {
            anchors.fill: parent
            text: "↑"
            font {
                family: "Calibri"
                pixelSize: 14
                bold: true
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Constants.backgroundColor
            scale: main.height/40
        }
        MouseArea {
            id: upperArea
            hoverEnabled: true
            anchors.fill: upperArrow
            onClicked: {
                if(main.number < 50)
                    main.externalNumberSet( main.number + 1)
                upperArrowClicked.start()
            }
        }
        states : [
            State {
                name: "default"
                when: !upperArea.containsMouse
                PropertyChanges {
                    target: upperArrow
                    color: main.color
                }
            },
            State {
                name: "containsMouse"
                when: upperArea.containsMouse
                PropertyChanges {
                    target: upperArrow
                    color: Constants.contraverseColor
                }
            }
        ]
        SequentialAnimation {
            id: upperArrowClicked
            PropertyAnimation {
                target: upperArrow
                property: "color"
                to: Constants.accentColor
                duration: 50
            }
            PropertyAnimation {
                target: upperArrow
                property: "color"
                to: upperArea.containsMouse ? Constants.contraverseColor : main.color
                duration: 50
            }
        }
    }
    Rectangle {
        id: downArrow
        color: parent.color
        width: parent.width/4
        height: parent.height/2
        anchors {
            right: parent.right
            bottom: parent.bottom
        }

        Text {
            anchors.fill: parent
            text: "↓"
            font {
                family: "Calibri"
                pixelSize: 14
                bold: true
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: Constants.backgroundColor
            scale: main.height/40
        }
        MouseArea {
            id: downArea
            hoverEnabled: true
            anchors.fill: downArrow
            onClicked: {
                if(main.number > 0 )
                    main.externalNumberSet(main.number - 1)
                downArrowClicked.start()
            }
        }
        states : [
            State {
                name: "default"
                when: !downArea.containsMouse
                PropertyChanges {
                    target: downArrow
                    color: main.color
                }
            },
            State {
                name: "containsMouse"
                when: downArea.containsMouse
                PropertyChanges {
                    target: downArrow
                    color: Constants.contraverseColor
                }
            }
        ]
        SequentialAnimation {
            id: downArrowClicked
            PropertyAnimation {
                target: downArrow
                property: "color"
                to: Constants.accentColor
                duration: 50
            }
            PropertyAnimation {
                target: downArrow
                property: "color"
                to: downArea.containsMouse ? Constants.contraverseColor : main.color
                duration: 50
            }
        }
    }
    //*/
}
