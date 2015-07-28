import QtQuick 2.0
import Ubuntu.Components 1.1
import "ui"
/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "ucyclingresults.andprsoft"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(45)
    height: units.gu(78)

    PageStack {
        id: pageStack
        Component.onCompleted: push(mainPage)
        MainPage {
            id:mainPage
        }
    }

}

