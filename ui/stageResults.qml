import QtQuick 2.0


Item{
    id:stageResultsItem
    anchors.fill: parent;
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    property string phase1ID;


    Component.onCompleted: {
        //console.log("vamos a ello");
        //console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID+","+phase1ID);

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
