pragma Singleton
import QtQuick 6.2
//import QtQuick.Studio.Application

QtObject {
    readonly property int width: 1200
    readonly property int height: 600

    property string relativeFontDirectory: "fonts"

    /* Edit this comment to add your custom font */
    readonly property font font: Qt.font({
                                             family: Qt.application.font.family,
                                             pixelSize: Qt.application.font.pixelSize
                                         })
    readonly property font largeFont: Qt.font({
                                                  family: Qt.application.font.family,
                                                  pixelSize: Qt.application.font.pixelSize * 1.6
                                              })

    readonly property color accentColor: "#D9A560"
    readonly property color contraverseColor: "#AF794B"
    readonly property color softColor: "#FDEACA"
    readonly property color backgroundColor: "#FFFFFF"
    readonly property color darkColor: "#6E4E39"

    readonly property color nameLine : "#317A47"
    readonly property color unitsLine : "#462E70"


    /*property StudioApplication application: StudioApplication {
        fontPath: Qt.resolvedUrl("../../content/" + relativeFontDirectory)
    }//*/
}
