import QtQuick 2.0
import Ubuntu.Components 1.2

Page{
    id: oneDayResultsPage;
    title: i18n.tr("OneDayResults");
    //parameters
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    state: "LOADING"

    states: [
        State {
            name: "LOADING"
            PropertyChanges {target: activityIndicator; opacity: 1}
            PropertyChanges {target: oneDayResultsItem; opacity: 0}
        },
        State {
            name: "LOADED"
            PropertyChanges {target: activityIndicator; opacity: 0}
            PropertyChanges {target: oneDayResultsItem; opacity: 1}
        }

    ]

    ActivityIndicator {
        id: activityIndicator
        anchors : parent
        running:true;
        opacity: 1;
    }

    Item{
        id:oneDayResultsItem
        anchors.fill: parent;
        opacity: 0;


        Component.onCompleted: {
            console.log("vamos a ello");
            console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID);

            oneDayResultsWorker.sendMessage({"competitionID":competitionID,
                                               "eventID":eventID,
                                               "editionID":editionID,
                                               "genderID": genderID,
                                               "classID":classID})
        }

        WorkerScript {
            id: oneDayResultsWorker
            source: "../js/oneDayResults.js"

            onMessage: {
                console.log("recibido mensaje");
                for (var i = 0; i < messageObject.results.length; i++) {
                    var result= messageObject.results[i];
                    oneDayResultsModel.append({
                                                  "id": result.id,
                                                  "rank":result.rank,
                                                  "name": result.name,
                                                  "result":result.result,
                                                  "nat":result.nat,
                                                  "team":result.team,
                                                  "age":result.age});
                }
                oneDayResultsPage.state="LOADED";
            }
        }

        ListModel{
            id:oneDayResultsModel
        }

        ListView {
            id:oneDayResultsList
            anchors.fill: parent
            clip: true
            model: oneDayResultsModel
            delegate: oneDayResultsDelegate
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
            id: oneDayResultsDelegate
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

