import QtQuick 2.0
import Ubuntu.Components 1.2

Page{
    id: stageResultsPage;
    title: i18n.tr("OneDayResults");
    //parametros
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    property string phase1ID;
    state: "LOADING"

    states: [
        State {
            name: "LOADING"
            PropertyChanges {target: activityIndicator; opacity: 1}
            PropertyChanges {target: stageResultsItem; opacity: 0}
        },
        State {
            name: "LOADED"
            PropertyChanges {target: activityIndicator; opacity: 0}
            PropertyChanges {target: stageResultsItem; opacity: 1}
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
        id:stageResultsItem
        anchors.fill: parent;
        opacity: 1;

        Component.onCompleted: {
            stageResultsWorker.sendMessage({"competitionID":competitionID,
                                               "eventID":eventID,
                                               "editionID":editionID,
                                               "genderID": genderID,
                                               "classID":classID,
                                               "phase1ID":phase1ID})
        }

        WorkerScript {
            id: stageResultsWorker
            source: "../js/stageResults.js"

            onMessage: {
                console.log("recibido mensaje");
                for (var i = 0; i < messageObject.results.length; i++) {
                    var result= messageObject.results[i];
                    stageResultsModel.append({
                                                  "id": result.id,
                                                  "rank":result.rank,
                                                  "name": result.name,
                                                  "result":result.result,
                                                  "nat":result.nat,
                                                  "team":result.team,
                                                  "age":result.age});
                }
                stageResultsPage.state="LOADED";
            }
        }

        ListModel{
            id:stageResultsModel
        }

        ListView {
            id:stageResultsList
            anchors.fill: parent
            clip: true
            model: stageResultsModel
            delegate: stageResultsDelegate
            header: Rectangle {
                width: parent.width; height: 10;
                color: "#555555"
            }

            footer: Rectangle {
                width: parent.width; height: 10;
                color: "#555555"
            }
        }

        Component {
            id: stageResultsDelegate
            Item{
                anchors{
                    left: parent.left
                    right: parent.right
                }
                height: 25
                Text {
                    id:txtRank
                    text: rank;
                    width: 25
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
                    width: 150
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
                    width: 75
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
