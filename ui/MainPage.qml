import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0
import QtLocation 5.0
import QtPositioning 5.2
import QtQuick.XmlListModel 2.0


Page {
    id: mainPage

    title: i18n.tr("Cycling Results")

    Column {
        spacing: units.gu(1)
        anchors {
            margins: units.gu(2)
            fill: parent
        }

        Label {
            id: label
            objectName: "label"

            text: i18n.tr("Hello..")
        }

        Button {
            objectName: "button"
            width: parent.width

            text: i18n.tr("Resultados 2013")

            onClicked: {
                console.log("vamos p'alli");
                pageStack.push({"item" : Qt.resolvedUrl("competitionsList.qml"),
                                   "properties" : {
                                           "initDate":"20130101",
                                           "finishDate":"20131231",
                                           "genderID":"1",
                                           "classID":"1",
                                           "classificationType":"UWT"}
                               });
            }
        }
    }

///////////////////////////////////
///   JS NAVIGATION FUNCTIONS   ///
///////////////////////////////////
    function stagesCompDetail(competitionID,eventID,editionID,genderID,classID){
        console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID);
        mainStack.push({
                       "item":Qt.resolvedUrl("stagesDetail.qml"),
                       "properties": {
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID}
                       });
    }

    function oneDayResult(competitionID,eventID,editionID,genderID,classID){
        mainStack.push({
                           "item":Qt.resolvedUrl("oneDayResults.qml"),
                           "properties": {
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID}
                       });
    }

    //http://localhost:8282/rest/results/stage/20695,12146,810688,1,1,837675
    function stageResult(competitionID,eventID,editionID,genderID,classID,phase1ID){
        mainStack.push({
                           "item":Qt.resolvedUrl("stageResults.qml"),
                           "properties": {
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID,
                               "phase1ID":phase1ID}
                       });
    }

    //http://localhost:8282/rest/results/classification/20695,12146,810688,1,1,0,800977
    function stagesClassification(competitionID,eventID,editionID,genderID,classID,phaseClassificationID){
        mainStack.push({
                           "item":Qt.resolvedUrl("classificationResults.qml"),
                           "properties": {
                               "competitionID":competitionID,
                               "eventID":eventID,
                               "editionID":editionID,
                               "genderID":genderID,
                               "classID":classID,
                               "phase1ID":0,
                               "phaseClassificationID":phaseClassificationID
                           }
                       });
    }

}
