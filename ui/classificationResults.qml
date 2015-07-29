import QtQuick 2.0
import Ubuntu.Components 1.2

Page{
    id: classificationResultsPage;
    title: i18n.tr("ClassificationResults");
    //parametros
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    property string phase1ID;
    property string phaseClassificationID;
    state: "LOADING"

    states: [
        State {
            name: "LOADING"
            PropertyChanges {target: activityIndicator; opacity: 1}
            PropertyChanges {target: classificationResultsItem; opacity: 0}
        },
        State {
            name: "LOADED"
            PropertyChanges {target: activityIndicator; opacity: 0}
            PropertyChanges {target: classificationResultsItem; opacity: 1}
        }

    ]

    ActivityIndicator {
        id: activityIndicator
        anchors{
            horizontalCenter: parent.horizontalCenter;
            verticalCenter: parent.verticalCenter;
        }
        width: units.gu(6);
        height: units.gu(6);
        running:true;
        opacity: 1;
    }


    Item{
        id:classificationResultsItem
        anchors.fill: parent;
        opacity: 0;

        Component.onCompleted: {
            classificationResultsWorker.sendMessage({"competitionID":competitionID,
                                               "eventID":eventID,
                                               "editionID":editionID,
                                               "genderID": genderID,
                                               "classID":classID,
                                               "phase1ID":phase1ID,
                                               "phaseClassificationID":phaseClassificationID})
        }

        WorkerScript {
            id: classificationResultsWorker
            source: "../js/classificationResults.js"

            onMessage: {
                console.log("recibido mensaje");
                for (var i = 0; i < messageObject.results.length; i++) {
                    var result= messageObject.results[i];
                    classificationResultsModel.append({
                                                  "id": result.id,
                                                  "rank":result.rank,
                                                  "name": result.name,
                                                  "result":result.result,
                                                  "nat":result.nat,
                                                  "team":result.team,
                                                  "age":result.age});
                }
                classificationResultsPage.state="LOADED";
            }
        }

        ListModel{
            id:classificationResultsModel
        }

        ListView {
            id:classificationResultsList
            anchors.fill: parent
            clip: true
            model: classificationResultsModel
            delegate: classificationResultsDelegate
            header: Rectangle {
                width: parent.width;
                height: units.gu(1);
                color: "#555555"
            }

            footer: Rectangle {
                width: parent.width;
                height: units.gu(1);
                color: "#555555"
            }
        }

        Component {
            id: classificationResultsDelegate
            Item{
                anchors{
                    left: parent.left
                    right: parent.right
                }
                height: units.gu(2)
                Text {
                    id:txtRank
                    text: rank
                    width: units.gu(10)
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        margins: 3
                    }
                }
                Text {
                    id:txtName
                    text: name
                    width: units.gu(30)
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtRank.right
                        margins: 3
                    }
                }
                Text {
                    id:txtResult
                    text: result;
                    width: units.gu(10)
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtName.right
                        margins: 3
                    }
                }
            }
        }
    }
}
