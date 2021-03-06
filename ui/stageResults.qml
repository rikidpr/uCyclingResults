import QtQuick 2.0
import Ubuntu.Components 1.2
import "../js/StringFormats.js" as StringFormat;

Page{
    id: stageResultsPage;
    //parametros
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    property string phase1ID;
    property string name;

    title: name;
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
                width: parent.width
                height: units.gu(1)
                color: "#555555"
            }

            footer: Rectangle {
                width: parent.width
                height: units.gu(1)
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
                height: units.gu(3)
                Rectangle {
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(3)
                    color: StringFormat.getOneDayResultsBackgroundColor(index);
                }
                Label {
                    id:txtRank
                    text: rank;
                    width: units.gu(4)
                    fontSize: "small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        margins: units.gu(0.5)
                    }
                }
                Label {
                    id:txtName
                    text: {
                        if (typeof(team) === 'undefined'){
                            return name;
                        } else {
                            return name+"("+team+")";
                        }
                    }
                    fontSize: "small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtRank.right
                        right: txtResult.left
                        margins: units.gu(0.5)
                    }
                    color: StringFormat.getOneDayResultsForegroundColor(index);
                }
                Label {
                    id:txtResult
                    text: result;
                    width: units.gu(8)
                    fontSize: "x-small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        margins: units.gu(0.5)
                    }
                    color: StringFormat.getOneDayResultsForegroundColor(index);
                }
            }
        }

    }
}
