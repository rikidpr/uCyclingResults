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


    ///////////////////////////////////
    ///   JS NAVIGATION FUNCTIONS   ///
    ///////////////////////////////////
        function stagesCompDetail(competitionID,eventID,editionID,genderID,classID){
            console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID);
            pageStack.push(Qt.resolvedUrl("ui/stagesDetail.qml"),
                           {"competitionID":competitionID,
                                   "eventID":eventID,
                                   "editionID":editionID,
                                   "genderID":genderID,
                                   "classID":classID});
        }

        function oneDayResult(name, competitionID,eventID,editionID,genderID,classID){
            pageStack.push(Qt.resolvedUrl("ui/oneDayResults.qml"),
                               {"name":name,
                                "competitionID":competitionID,
                                "eventID":eventID,
                                "editionID":editionID,
                                "genderID":genderID,
                                "classID":classID});
        }

        //http://localhost:8282/rest/results/stage/20695,12146,810688,1,1,837675
        function stageResult(name, competitionID,eventID,editionID,genderID,classID,phase1ID){
            pageStack.push(Qt.resolvedUrl("ui/stageResults.qml"),
                               {"name":name,
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID,
                               "phase1ID":phase1ID});
        }

        //http://localhost:8282/rest/results/classification/20695,12146,810688,1,1,0,800977
        function stagesClassification(classificationName, competitionID,eventID,editionID,genderID,classID,phaseClassificationID){
            pageStack.push(Qt.resolvedUrl("ui/classificationResults.qml"),
                               {"classificationName":classificationName,
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID,
                               "phase1ID":0,
                               "phaseClassificationID":phaseClassificationID});
        }


}

