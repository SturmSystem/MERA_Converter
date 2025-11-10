import QtQuick 6.2
import QtQuick.Controls 6.2
//import QtQuick.Controls.Styles 1.0
import Mera_Converter

Rectangle {
    id: rectangle
    width: parent.width
    height: parent.height

    color: Constants.backgroundColor

    property string fieldsFont : "Sans Serif"
    property int fieldsFontSize : 14


    Text {
        id: sectionName
        height: 30
        anchors {
            left: rectangle.left
            //right: rectangle.right
            top: rectangle.top
            leftMargin: 30
            //rightMargin: 200
            topMargin: 10
        }
        text: "File Viewer"
        font {
            family: "Arial"
            bold: true
            pixelSize: height/1.5
        }
        color: Constants.darkColor
        horizontalAlignment: Text.AlignLeft
    }


    Text {
        id: nameLineField
        width: 80
        height: 30
        text: "Channel\nnames line"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: rectangle.left
            leftMargin: 5
        }
    }

    NumberField {
        id: nameLineNumber
        width: 50
        color: Constants.nameLine
        anchors {
            left: nameLineField.right
            top: nameLineField.top
            bottom: nameLineField.bottom
            leftMargin: 5
        }
        Connections {
            target: textBlock
            onChoosenNamesLineChanged: {
                nameLineNumber.externalNumberSet(textBlock.choosenNamesLine+1)
                //nameLineNumber.number = textBlock.choosenNamesLine+1
            }
        }
        Connections {
            target: nameLineNumber
            onSetNumber: {
                textBlock.choosen(nameLineNumber.number-1)
            }
            onActiveMode: {
                textBlock.mode = TextExample.NamesLine
            }
            onDisactivate: {
                textBlock.mode = TextExample.EmptyLine
            }//*/
        }
    }

    Text {
        id: unitsLineField
        width: 60
        height: 30
        text: "Channel\nunits line"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: nameLineNumber.right
            leftMargin: 10
        }
    }

    NumberField {
        id: unitsLineNumber
        width: 50
        color: Constants.unitsLine
        anchors {
            left: unitsLineField.right
            top: unitsLineField.top
            bottom: unitsLineField.bottom
            leftMargin: 5
        }
        Connections {
            target: textBlock
            onChoosenUnitsLineChanged: {
                unitsLineNumber.externalNumberSet(textBlock.choosenUnitsLine+1)
                //unitsLineNumber.number = textBlock.choosenUnitsLine+1
            }
        }
        Connections{
            target: unitsLineNumber
            onSetNumber: {
                textBlock.choosen(unitsLineNumber.number-1)
            }
            onActiveMode: {
                textBlock.mode = TextExample.UnitsLine
            }
            onDisactivate: {
                textBlock.mode = TextExample.EmptyLine
            }//*/
        }
    }


    Text {
        id: firstLineField
        width: 30
        height: 30
        text: "First line"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: unitsLineNumber.right
            leftMargin: 15
        }
    }

    NumberField {
        id: firstLineNumber
        width: 50
        color: Constants.darkColor
        anchors {
            left: firstLineField.right
            top: firstLineField.top
            bottom: firstLineField.bottom
            leftMargin: 5
        }
        Connections {
            target: textBlock
            onChoosenFirstLineChanged: {
                firstLineNumber.externalNumberSet(textBlock.choosenFirstLine+1)
                //firstLineNumber.number = textBlock.choosenFirstLine+1
            }
        }
        Connections{
            target: firstLineNumber
            onSetNumber: {
                textBlock.choosen(firstLineNumber.number-1)
            }
            onActiveMode: {
                textBlock.mode = TextExample.FirstLine
            }
            onDisactivate: {
                textBlock.mode = TextExample.EmptyLine
            }//*/
        }
    }

    Text {
        id: sampleRateField
        width: 30
        height: 30
        text: "Sample Rate"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize-1
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: firstLineNumber.right
            leftMargin: 30
        }
    }

    SampleNumberField{
        id: sampleRateRectangle
        //property int number : 0
        width: 55
        color: Constants.softColor
        anchors {
            left: sampleRateField.right
            top: sampleRateField.top
            bottom: sampleRateField.bottom
            leftMargin: 5
        }
        onNumberChanged: {
            //delimiterMenu.open()
            console.log("Sample Rate is Changed", number)
        }
    }
/*
    Rectangle{
        id: sampleRateRectangle
        property int number : 20000
        width: 55
        color: Constants.softColor
        anchors {
            left: sampleRateField.right
            top: sampleRateField.top
            bottom: sampleRateField.bottom
            leftMargin: 5
        }
        onNumberChanged: console.log("Sample Rate is Changed", number)
        Rectangle {
            color: "black"
            height: 1
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        TextInput {
            id: sampleRate
            anchors {
                fill: parent
            }
            font {
                family: "Segoe UI"
                bold: true
                pixelSize: 14
            }
            clip: true
            text: parent.number
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            opacity: 1.0
            selectByMouse: true
            onActiveFocusChanged: {
                    if(!activeFocus){
                        accepted()
                        focus = false
                    }
                    else
                    {
                        textBlock.mode = TextExample.EmptyLine
                    }
                }
                Keys.onReturnPressed: {
                    focus = false
                }
            validator: IntValidator {bottom: 0; top: 500000}
            onAccepted: parent.number = text
        }
    }
//*/
    Text {
        id: skipField
        width: 65
        height: 30
        text: "Skip Left\n Columns"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize-1
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: sampleRateRectangle.right
            leftMargin: 5
        }
    }

    NumberField{
        id: skipRectangle
        //property int number : 0
        width: 40
        color: Constants.contraverseColor
        anchors {
            left: skipField.right
            top: skipField.top
            bottom: skipField.bottom
            leftMargin: 5
        }
        onNumberChanged: {
            //delimiterMenu.open()
            console.log("Skip Value is Changed", number)
        }

        /*
        Rectangle {
            color: "black"
            height: 1
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        TextInput {
            //id: sampleRate
            anchors {
                fill: parent
            }
            font {
                family: "Segoe UI"
                bold: true
                pixelSize: 14
            }
            clip: true
            text: parent.number
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "black"
            opacity: 1.0
            selectByMouse: true
            onActiveFocusChanged: {
                    if(!activeFocus){
                        accepted()
                        focus = false
                    }
                    else
                    {
                        textBlock.mode = TextExample.EmptyLine
                    }
                }
                Keys.onReturnPressed: {
                    focus = false
                }
            validator: IntValidator {bottom: 0; top: 50}
            onAccepted: parent.number = text
        }
        //*/
    }

    Text {
        id: delimiterField
        width: 65
        height: 30
        text: "Choose\nDelimiter"
        wrapMode: Text.WordWrap
        font {
            family: rectangle.fieldsFont//"Sans Serif"//"Calibri"
            pixelSize: rectangle.fieldsFontSize-1
            //bold: true
        }//*/
        lineHeight: 1.0
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors {
            top: sectionName.bottom
            topMargin: 0
            left: skipRectangle.right
            leftMargin: 0
        }
    }
/*
    Rectangle{
        id: delimiterRectangle
        property string delimiter : '\t'
        width: 55
        color: Constants.softColor
        anchors {
            left: delimiterField.right
            top: delimiterField.top
            bottom: delimiterField.bottom
            leftMargin: 5
        }
        onDelimiterChanged: {
            //delimiterMenu.open()
            console.log("Delimiter is Changed", delimiter)
        }
        Rectangle {
            color: "black"
            height: 1
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        TextInput {
            //id: sampleRate
            anchors {
                fill: parent
            }
            font {
                family: rectangle.fieldsFont
                pixelSize: rectangle.fieldsFontSize+2
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            clip: true
            text: parent.delimiter
            color: "black"
            opacity: 1.0
            selectByMouse: true
            onActiveFocusChanged: {
                    if(!activeFocus){
                        accepted()
                        focus = false
                    }
                    else
                    {
                        textBlock.mode = TextExample.EmptyLine
                    }
                }
                Keys.onReturnPressed: {
                    focus = false
                }
            //validator: IntValidator {bottom: 0; top: 50}
            onAccepted: parent.delimiter = text
        }
    }//*/
    /*Rectangle{
        id: delimiterRectangle
        //property int number : 20000
        width: 55
        //color: Constants.softColor
        anchors {
            left: delimiterField.right
            top: delimiterField.top
            bottom: delimiterField.bottom
            leftMargin: 5
        }
        color: Constants.softColor
        Rectangle {
            color: "black"
            height: 1
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        Text {
            id: delimiter
            anchors.fill: parent
            text: "Tab"
            font {
                family: rectangle.fieldsFont
                pixelSize: rectangle.fieldsFontSize+2
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            Connections {
                target: delimiterTable
                onDelimiterChanged: delimiter.text = (delimiterTable.delimiter === "\t") ? "Tab" : delimiterTable.delimiter
            }
        }

        MouseArea{
            id: delimiterArea
            anchors.fill: parent
            hoverEnabled: true
            onContainsMouseChanged: {
                if(containsMouse)
                    parent.color = Constants.contraverseColor
                else
                    parent.color = Constants.softColor
            }
            onClicked: delimiterTable.open();
        }

    }//*/

    /*NumberField {
        id:
        width: 50
        color: Constants.darkColor
        anchors {
            left: firstLineField.right
            top: firstLineField.top
            bottom: firstLineField.bottom
            leftMargin: 5
        }
        Connections {
            target: textBlock
            onChoosenFirstLineChanged: {
                firstLineNumber.number = textBlock.choosenFirstLine+1
            }
        }
        Connections{
            target: firstLineNumber
            onSetNumber: {
                textBlock.choosen(firstLineNumber.number-1)
            }
            onActiveMode: {
                textBlock.mode = TextExample.FirstLine
            }
            onDisactivate: {
                textBlock.mode = TextExample.EmptyLine
            }
        }
    }//*/

    CustomButton {
        id: startButton
        text: "Start Converting"
        height: 40
        anchors {
            left: rectangle.left
            right: rectangle.right
            bottom: rectangle.bottom
            leftMargin: 30
            rightMargin: 30
            bottomMargin: 10
        }
        onButtonClicked: {
            text = "∙ ∙ ∙ converting ∙ ∙ ∙"
            defaultColor = Constants.accentColor


            app.start(
                        textBlock.choosenFirstLine+1,
                        textBlock.choosenNamesLine+1,
                        textBlock.choosenUnitsLine+1,
                        sampleRateRectangle.number,
                        skipRectangle.number,
                        delimiter.delimiter
                        )
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            //timer.start()
        }
        Connections {
            target: app
            onConvertingDone:    {
                startButton.text = " Done"
                startButton.defaultColor = Constants.darkColor
            }
        }

        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        /*Timer {
            id: timer
            repeat: true
            triggeredOnStart: true;
            interval: 10
            onTriggered: {
                app.riseUp(0)
            }
        }//*/
    }


    TextExample {
        id: textBlock
        anchors {
            top: nameLineField.bottom
            left: rectangle.left
            right: rectangle.right
            bottom: startButton.top
            topMargin: 10
            leftMargin: 10
            rightMargin: 10
            bottomMargin: 10
        }

        Connections {
            target: app
            onCurrentFileChanged: textBlock.flush()
            onAddLine: (newLine)=>{
                textBlock.model.append({text: newLine})
            }
            onChooseFiles: textBlock.flush()//textBlock.model.clear()
        }
    }

    DelimiterMenu {
        id: delimiter
        height: 30
        delegateHeight: 30
        width: 55
        clip: true
        anchors {
            left: delimiterField.right
            top: delimiterField.top
            //bottom: delimiterField.bottom
            leftMargin: 5
        }

        //x: delimiterRectangle.x
        //y: delimiterRectangle.y

        //onCloseTable: delimiterTable.close()


        states: [
            State {
                name: "opened"
                when: delimiter.opened
                PropertyChanges {
                    target: delimiter
                    height: 120
                }
            },
            State {
                name: "closed"
                when: !delimiter.opened
                PropertyChanges {
                    target: delimiter
                    height: 30
                }
            }
        ]
        transitions: [
            Transition {
            from: "closed"
            to: "opened"
            SequentialAnimation {
                PropertyAnimation{
                    property: "height"
                    duration: 50
                }
            }
        },
        Transition {
            from: "opened"
            to: "closed"
            SequentialAnimation {
                PropertyAnimation {
                    property: "height"
                    duration: 50
                    }
                }
            }
        ]//*/

    }

}
