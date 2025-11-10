import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Item {
    id: main
    width: 55
    height: 30

    property int delegateHeight : 30

    property string delimiter : "\t"
    property color color : Constants.contraverseColor
    property color textColor : Constants.backgroundColor

    property bool opened : false

    onOpen: opened = true
    onCollapse: opened = false

    signal collapse();
    signal open()

    ListView {
        id: list

        anchors{
            top: main.top
            right: main.right
            left: main.left
            bottom: main.bottom
        }


        model: ListModel {
            ListElement {
                text: "Tab"
                delimiter: "\t"
            }
            ListElement {
                text: ";"
                delimiter: ";"
            }
            ListElement {
                text: ":"
                delimiter: ":"
            }
            ListElement {
                text: ","
                delimiter: ","
            }
        }

        delegate: Rectangle {
            id: listDelegate
            anchors {
                left: parent.left
                right: parent.right
            }

            Component.onCompleted : {
                if(model.text === "Tab"){
                    list.currentIndex = 0;
                    listDelegate.openDelegate()
                }
            }//*/

            //property bool opened : false

            /*onOpenedChanged: {
                if(opened)
                    openDelegate()
                else
                    closeDelegate()
            }//*/

            function closeDelegate(){
                if(list.currentIndex !== model.index)
                    closeAnimation.start()
            }
            function openDelegate(){
                if(list.currentIndex !== model.index)
                    openAnimation.start()
            }//*/

            Connections {
                target: main
                onOpen: listDelegate.openDelegate()
                onCollapse: listDelegate.closeDelegate()
            }

            color: main.color


            Text {
                id: text
                anchors.fill: parent
                text: model.text
                font {
                    family: "Roboto"
                    pixelSize: 15
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: main.textColor
                scale: 0.0
            }

            MouseArea {
                id: area
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    if(main.opened){
                        main.delimiter = model.delimiter
                        list.currentIndex = model.index
                        main.collapse()
                        //main.opened = false
                    }
                    else{
                        main.open()
                        //main.opened = true
                    }
                }
            }

            states: [
                State {
                    name: "default"
                    when: !area.containsMouse && (list.currentIndex!==model.index)
                    PropertyChanges {target: listDelegate; color: main.color}
                    PropertyChanges {target: text; color: main.textColor}
                },
                State {
                    name: "hovered"
                    when: area.containsMouse //&& (list.currentIndex!==model.index)
                    PropertyChanges {target: listDelegate; color: Constants.accentColor}
                    PropertyChanges {target: text; color: Constants.darkColor}
                    /*PropertyChanges {
                        listDelegate {
                            color: Constants.accentColor
                        }
                        text{
                            color: Constants.darkColor
                        }
                    }//*/
                },
                State {
                    name: "chosen"
                    when: (list.currentIndex===model.index) && !area.containsMouse
                    PropertyChanges {target: listDelegate; color: Constants.darkColor}
                    PropertyChanges {target: text; color: Constants.backgroundColor}
                }/*,
                State {
                    name: "closed"
                    when: !listDelegate.opened
                    PropertyChanges {
                        listDelegate {
                            height: 0
                        }
                        text {
                            scale: 0.0
                        }
                    }
                },
                State {
                    name: "opened"
                    when: listDelegate.opened
                    PropertyChanges {
                        listDelegate {
                            height: 30
                        }
                        text {
                            scale: 1.0
                        }
                    }
                }//*/
            ]
            transitions: [
                Transition {
                    PropertyAnimation{
                        targets: [listDelegate, text]
                        properties: "color"
                        duration: 50
                    }
                }/*,
                Transition {
                    PropertyAnimation{
                        target: listDelegate
                        property: "height"
                        duration: 100
                    }
                },
                Transition{
                    PropertyAnimation{
                        target: text
                        property: "scale"
                        duration: 100
                    }
                }//*/
            ]

            ParallelAnimation{
                id: closeAnimation
                PropertyAnimation {
                    target: listDelegate
                    property: "height"
                    to: 0
                    duration: 50
                }
                PropertyAnimation{
                    target: text
                    property: "scale"
                    to: 0
                    duration: 50
                }
            }
            ParallelAnimation{
                id: openAnimation
                PropertyAnimation {
                    target: listDelegate
                    property: "height"
                    to: 30
                    duration: 50
                }
                PropertyAnimation{
                    target: text
                    property: "scale"
                    to: 1.0
                    duration: 50
                }
            }//*/
        }
    }
}
