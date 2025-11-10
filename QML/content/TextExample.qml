import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Rectangle {
    id: rectangle
    width: 1920
    height: 1080

    color: defaultColor
    radius: 5
    clip: true

    function flush(){
        model.clear();
        //rectangle.choosenIndex = -1
    }

    Connections {
        target: app
        onClearScreen: rectangle.flush()
    }

    property int mode: TextExample.EmptyLine

    enum LineType{
        EmptyLine = 4,
        FirstLine = 0,
        NamesLine = 1,
        UnitsLine = 3
    }

    function reset(index) {
        list.itemAtIndex(index).choosen = false;
        list.itemAtIndex(index).lineType = TextExample.EmptyLine
        switch(index){
        case choosenFirstLine:
            choosenFirstLine = -1;
            break;
        case choosenNamesLine:
            choosenNamesLine = -1;
            break;
        case choosenUnitsLine:
            choosenUnitsLine = -1;
            break;
        }
    }

    function choosen(index){
        if(model.rowCount() > 0)
            if(index >= 0)
                reset(index)
        switch(rectangle.mode){
        case TextExample.FirstLine:
            if(rectangle.choosenFirstLine >=0 ){
                if(model.rowCount() > 0){
                    list.itemAtIndex(rectangle.choosenFirstLine).choosen = false
                    list.itemAtIndex(rectangle.choosenFirstLine).lineType = TextExample.EmptyLine
                }
            }
            //else if(rectangle.choosenFirstLine === -1)

            rectangle.choosenFirstLine = index
            if(model.rowCount() > 0 && index >= 0){
                list.itemAtIndex(index).lineType = TextExample.FirstLine
                list.itemAtIndex(index).choosen = true
            }
            console.log("First Line is ", rectangle.choosenFirstLine)
            break;
        case TextExample.NamesLine:
            if(rectangle.choosenNamesLine >= 0){
                if(model.rowCount() > 0){
                    list.itemAtIndex(rectangle.choosenNamesLine).choosen = false
                    list.itemAtIndex(rectangle.choosenNamesLine).lineType = TextExample.EmptyLine
                }
            }
            rectangle.choosenNamesLine = index
            if(model.rowCount() > 0 && index >= 0){
                list.itemAtIndex(index).lineType = TextExample.NamesLine
                list.itemAtIndex(index).choosen = true
            }
            console.log("Names Line is ", rectangle.choosenNamesLine)
            break;
        case TextExample.UnitsLine:
            if(rectangle.choosenUnitsLine >= 0){
                if(model.rowCount() > 0){
                    list.itemAtIndex(rectangle.choosenUnitsLine).choosen = false
                    list.itemAtIndex(rectangle.choosenUnitsLine).lineType = TextExample.EmptyLine
                }
            }
            rectangle.choosenUnitsLine = index
            if(model.rowCount() > 0 && index >= 0){
                list.itemAtIndex(index).lineType = TextExample.UnitsLine
                list.itemAtIndex(index).choosen = true
            }
            console.log("Units Line is ", rectangle.choosenUnitsLine)
            break;
        }
    }

    property ListModel model : ListModel {}

    property color defaultColor: Constants.softColor
    property color enteredColor: Constants.contraverseColor
    property color clickedColor: Constants.accentColor
    property color choosenColor: Constants.darkColor

    property color textDefaultColor: "black"
    property color textEnteredColor: Constants.backgroundColor
    property color textClickedColor: Constants.darkColor
    property color textChoosenColor: Constants.backgroundColor

    property color choosenNamesLineColor : Constants.nameLine
    property color choosenUnitsLineColor : Constants.unitsLine

    //property int currentIndex : list.currentIndex
    //property int choosenIndex : -1
    property int choosenNamesLine : -1
    property int choosenUnitsLine : -1
    property int choosenFirstLine : -1

    ListView {
        id: list
        anchors.fill: parent

        model: rectangle.model

        delegate: Rectangle{
            id: listDelegate
            height: delegateText.font.pixelSize+5
            color: rectangle.defaultColor
            property bool choosen : false
            property int lineType : TextExample.EmptyLine
            anchors {
                left: parent.left
                right: parent.right
            }
            Component.onCompleted: switch(model.index){
                                   case rectangle.choosenFirstLine:
                                       choosen = true
                                       lineType = TextExample.FirstLine
                                       break;
                                   case rectangle.choosenNamesLine:
                                       choosen = true
                                       lineType = TextExample.NamesLine
                                       break;
                                   case rectangle.choosenUnitsLine:
                                       choosen = true
                                       lineType = TextExample.UnitsLine
                                       break;
                                   }

            Text {
                id: stringNumber
                width: 25
                anchors {
                    left: listDelegate.left
                }
                font {
                    family: "Arial"
                    pixelSize: 14
                    bold: true
                }
                horizontalAlignment: Text.AlignHCenter
                text: (1+model.index) + ": "
                color: Constants.contraverseColor
            }
            Text {
                id: delegateText
                anchors {
                    left: stringNumber.right
                    right: listDelegate.right
                    rightMargin: width/10
                }
                text: modelData
                font {
                    family: "Arial"
                    pixelSize: 14
                }
                horizontalAlignment: Text.AlignLeft
                color: rectangle.textDefaultColor
            }
            MouseArea {
                id: area
                /*anchors {
                    left: stringNumber.left
                    right: delegateText.right
                    top: delegateText.top
                    bottom: delegateText.bottom
                }*/
                anchors.fill: listDelegate

                hoverEnabled: true
                onClicked: {
                    if(rectangle.mode!==TextExample.EmptyLine)
                        rectangle.choosen(model.index)
                    /*if(rectangle.choosenIndex >= 0)
                        list.itemAtIndex(rectangle.choosenIndex).choosen = false
                    rectangle.choosenIndex = model.index
                    list.itemAtIndex(rectangle.choosenIndex).choosen = true
                    list.itemAtIndex(erctangle.choosenIndex).clickedAnimation.start()//*/
                }
                //onContainsMouseChanged: console.log(stringNumber.text)
            }

            states: [
                State {
                    name: "default"
                    when: (!area.containsMouse) && (!choosen)
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
                    when: area.containsMouse && (!choosen)
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
                    name: "firstLine"
                    when: listDelegate.choosen && listDelegate.lineType === TextExample.FirstLine
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.choosenColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textChoosenColor
                    }
                },
                State {
                    name: "namesLine"
                    when: listDelegate.choosen && listDelegate.lineType === TextExample.NamesLine
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.choosenNamesLineColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textChoosenColor
                    }
                },
                State {
                    name: "unitsLine"
                    when: listDelegate.choosen && listDelegate.lineType === TextExample.UnitsLine
                    PropertyChanges {
                        target: listDelegate
                        color:  rectangle.choosenUnitsLineColor
                    }
                    PropertyChanges {
                        target: delegateText
                        color: rectangle.textChoosenColor
                    }
                }
            ]

            transitions: [
                Transition{
                    //from: "default"
                    to: "entered"
                    reversible: true
                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 10
                    }
                },
                Transition{
                    //from: "entered"
                    to: "choosen"
                    reversible: true

                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 100
                    }
                }/*,
                Transition{
                    from: "default"
                    to: "choosen"
                    reversible: true
                    PropertyAnimation {
                        targets: [listDelegate, delegateText]
                        property: "color"
                        duration: 100
                    }
                }//*/
            ]
        }
        ScrollBar.vertical: vertical_scroll_bar
    }

    ScrollBar {
                id: vertical_scroll_bar
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
