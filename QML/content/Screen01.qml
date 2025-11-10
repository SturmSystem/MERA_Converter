import QtQuick 6.2
import QtQuick.Controls 6.2
import Mera_Converter

Rectangle {
    id: rectangle
    width: parent.width
    height: parent.height

    color: Constants.backgroundColor

    Text {
        id: destinationText
        height: 30
        anchors {
            left: folderString.left
            //right: rectangle.right
            top: rectangle.top
            leftMargin: 10
            //rightMargin: 200
            topMargin: 5
        }
        text: "Folder"
        font {
            family: "Arial"
            bold: true
            pixelSize: height/1.5
        }
        color: Constants.darkColor
        horizontalAlignment: Text.AlignLeft
    }

    FilesString {
        id: folderString
        width: rectangle.width/1.3
        anchors {
            left: rectangle.left
            //right: folderButton.left
            top: destinationText.bottom
            leftMargin: (rectangle.width-folderString.width-folderButton.width)/3
            //rightMargin: (rectangle.width-width-folderButton.width)/3
            topMargin: 0
        }
        Connections{
            target: app
            onFolderChanged: (folder) => {
                folderString.text = folder
            }
        }
        Component.onCompleted: {
            app.getFolder();
        }
    }

    CustomButton {
        id: folderButton
        width: rectangle.width/5.5
        height: folderString.height
        anchors {
            //left: folderString.right
            //leftMargin: width/6
            verticalCenter: folderString.verticalCenter
            right: rectangle.right
            rightMargin: (rectangle.width-folderString.width-folderButton.width)/3
        }
        onButtonClicked: {
            app.openFolder();
        }
    }

    Text {
        id: originText
        height: 30
        anchors {
            left: folderString.left
            //right: rectangle.right
            top: folderString.bottom
            leftMargin: 10
            //rightMargin: 200
            topMargin: 10
        }
        text: "Files"
        font {
            family: "Arial"
            bold: true
            pixelSize: height/1.5
        }
        color: Constants.darkColor
        horizontalAlignment: Text.AlignLeft
    }


    property real buttonWidth: rectangle.width*0.9/3
    property real buttonGap: rectangle.width*0.1/4
    CustomButton {
        id: chooseFilesButton
        text: "Choose Files"
        width: rectangle.buttonWidth
        height: 30
        anchors {
            left: rectangle.left
            top: originText.bottom
            leftMargin: rectangle.buttonGap
            topMargin: 0
        }
        onButtonClicked: {
            selector.model.clear();
            app.chooseFiles();
        }
    }

    CustomButton {
        id: addFilesButton
        text: "Add Files"
        width: rectangle.buttonWidth
        height: 30
        anchors {
            left: chooseFilesButton.right
            top: originText.bottom
            leftMargin: rectangle.buttonGap
            topMargin: 0
        }
        onButtonClicked: app.addFiles();
    }

    CustomButton {
        id: removeFilesButton
        text: "Remove File"
        width: rectangle.buttonWidth
        height: 30
        anchors {
            left: addFilesButton.right
            top: originText.bottom
            leftMargin: rectangle.buttonGap
            topMargin: 0
        }
        onButtonClicked: {
            app.removeFile(selector.choosenIndex);
            //selector.model.remove(selector.currentIndex);
            selector.remove()
        }
    }

    StringSelector {
        id: selector
        //height: 100
        clip: true
        anchors {
            left: rectangle.left
            right: rectangle.right
            top: chooseFilesButton.bottom
            bottom: nameText.top
            leftMargin: rectangle.buttonGap
            rightMargin: rectangle.buttonGap
            topMargin: 10
            bottomMargin: 10
        }
        Connections {
            target: app
            onFileChosen: (file) => selector.model.append({text: file});

        }

        onChoosenIndexChanged: app.currentFileChanged(selector.choosenIndex);

        //model: filesListModel
    }

    InputName{
        id: nameInput
        anchors {
            left: folderString.left
            leftMargin: 10
            right: rectangle.right
            rightMargin: 10
            bottom: rectangle.bottom
            bottomMargin: 10
        }
        onNameChanged: app.nameChanged(name)
    }

    Text {
        id: nameText
        height: 30
        anchors {
            left: folderString.left
            leftMargin: 10
            bottom: nameInput.top
            bottomMargin: 0
        }
        text: "Name"
        font {
            family: "Arial"
            bold: true
            pixelSize: height/1.5
        }
        color: Constants.darkColor
        horizontalAlignment: Text.AlignLeft
    }


    /*property color changeColor: Constants.contraverseColor

    Button {
        id: button
        text: qsTr("Press me")
        anchors.verticalCenter: parent.verticalCenter
        checkable: true
        anchors.horizontalCenter: parent.horizontalCenter

        Connections {
            target: button
            onClicked: {
                app.openFolder();
            }
        }
    }

    Text {
        id: label
        text: qsTr("Hello Mera_Converter")
        anchors.top: button.bottom
        font.family: Constants.font.family
        anchors.topMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter

        SequentialAnimation {
            id: animation

            ColorAnimation {
                id: colorAnimation1
                target: rectangle
                property: "color"
                to: changeColor
                from: Constants.backgroundColor
            }

            ColorAnimation {
                id: colorAnimation2
                target: rectangle
                property: "color"
                to: Constants.backgroundColor
                from: changeColor
            }
        }
    }
    states: [
        State {
            name: "clicked"
            when: button.checked

            PropertyChanges {
                target: label
                text: qsTr("Button Checked")
            }
        }
    ]*/
}
