import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Rectangle {
    id: rectangle
    width: 1920
    height: 1080

    color: defaultColor
    radius: 5

    property ListModel model : ListModel {}
    property int size : model.count
    property color defaultColor: Constants.softColor
    property color enteredColor: Constants.contraverseColor
    property color clickedColor: Constants.accentColor
    property color choosenColor: Constants.darkColor

    property color textDefaultColor: "black"
    property color textEnteredColor: Constants.backgroundColor
    property color textClickedColor: Constants.darkColor
    property color textChoosenColor: Constants.backgroundColor

    property int currentIndex : list.currentIndex
    property int choosenIndex : -1

    function remove(){
        model.remove(choosenIndex)
        console.log(choosenIndex)
        rectangle.choosenIndex = -1
        app.clearScreen()
    }

    Connections {
        target: app
        onRiseUp: (index) => {
                      list.itemAtIndex(index).riseUpLine()
                  }

    }


    ListView {
        id: list
        anchors.fill: parent
        anchors.topMargin: rectangle.height/100
        anchors.bottomMargin: rectangle.height/100

        model: rectangle.model

        //spacing: rectangle.height/100
        delegate: Rectangle{
            id: listDelegate
            height: delegateText.font.pixelSize+5
            color: rectangle.defaultColor
            property bool choosen : false

            function riseUpLine(){
                stringCheck.width += listDelegate.width/100;
            }

            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: stringCheck
                height: listDelegate.height;
                width: 0;
                color: "#5CCCCC"//"#009999"
                anchors {
                    left: listDelegate.left
                    bottom: listDelegate.bottom
                }
            }

            Text {
                id: delegateText
                anchors {
                    left: listDelegate.left
                    right: listDelegate.right
                    rightMargin: width/10
                }
                text: modelData
                font {
                    family: "Arial"
                    pixelSize: 14
                }
                horizontalAlignment: delegateText.width<delegateText.contentWidth ? Text.AlignRight : Text.AlignLeft
                color: rectangle.textDefaultColor
            }
            MouseArea {
                id: area
                anchors.fill: listDelegate
                hoverEnabled: true
                onClicked: {
                    if(rectangle.choosenIndex >= 0)
                        list.itemAtIndex(rectangle.choosenIndex).choosen = false
                    rectangle.choosenIndex = model.index
                    list.itemAtIndex(rectangle.choosenIndex).choosen = true
                    clickedAnimation.start()
                }
            }

            states: [
                State {
                    name: "default"
                    when: (!area.containsMouse)&&(!choosen)
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.defaultColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textDefaultColor
                    }
                },
                State {
                    name: "entered"
                    when: area.containsMouse&&(!choosen)
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.enteredColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textEnteredColor
                    }
                },
                State {
                    name: "choosen"
                    when: listDelegate.choosen
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.choosenColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textChoosenColor
                    }
                }
            ]

            SequentialAnimation {
                id: clickedAnimation
                ParallelAnimation {
                    PropertyAnimation {
                        target: listDelegate
                        property: "color"
                        to: rectangle.clickedColor
                        duration: 100
                    }
                    PropertyAnimation {
                        target: delegateText
                        property: "color"
                        to: rectangle.textClickedColor
                        duration: 100
                    }
                }
                ParallelAnimation {
                    PropertyAnimation {
                        target: listDelegate
                        property: "color"
                        to: listDelegate.choosen ? rectangle.choosenColor : rectangle.defaultColor
                        duration: 100
                    }
                    PropertyAnimation {
                        target: delegateText
                        property: "color"
                        to: listDelegate.choosen ? rectangle.textChoosenColor : rectangle.textDefaultColor
                        duration: 100
                    }
                }
            }

            transitions: [
                Transition{
                    from: "default"
                    to: "entered"
                    reversible: true
                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 50
                    }
                },
                Transition{
                    from: "entered"
                    to: "choosen"
                    reversible: true

                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 50
                    }
                },
                Transition{
                    from: "default"
                    to: "choosen"
                    reversible: true
                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 50
                    }
                }
            ]
        }
        ScrollBar.vertical: scroll_bar
    }

    ScrollBar {
                id: scroll_bar
                    anchors {
                        right: rectangle.right
                        top: rectangle.top
                        bottom: rectangle.bottom
                    }
                contentItem: Rectangle {
                    color: "#33000000"
                }
                active: true
            }
}
