import QtQuick 2.0


Item{
    id:classificationResultsItem
    anchors.fill: parent;
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;
    property string phase1ID;
    property string phaseClassificationID;


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
//{"name":"Christopher HORNER","id":8588,"result":"84:36:04","rank":"1","nat":"USA","team":"RLT","age":"42","paR":null,"pcR":null}
                classificationResultsModel.append({
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
        id:classificationResultsModel
    }

    ListView {
        id:classificationResultsList
        anchors.fill: parent
        clip: true
        model: classificationResultsModel
        delegate: classificationResultsDelegate
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
        id: classificationResultsDelegate
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
