import QtQuick 2.0


Item{
    id:stagesDetailItem
    anchors.fill: parent;
    property string competitionID;
    property string eventID;
    property string editionID;
    property string genderID;
    property string classID;

    Component.onCompleted: {
        console.log("vamos a ello");
        console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID);
        stagesDetailWorker.sendMessage({"competitionID":competitionID,
                                           "eventID":eventID,
                                           "editionID":editionID,
                                           "genderID": genderID,
                                           "classID":classID})
    }

    function formatDate(timestamp){
        var date = new Date(timestamp);
        var mes = date.getMonth()+1;
        var dateFormatted = date.getDate()+"/"+mes+"/"+date.getFullYear()
        return dateFormatted;
    }

    function getCompetitionTypeName(competitionType){
        switch(competitionType){
        case "ONE_DAY": return "One day comp.";
        case "STAGES": return "Stages comp.";
        default: return competitionType;
        }
    }

    WorkerScript {
        id: stagesDetailWorker
        source: "../js/stageCompDetails.js"

        onMessage: {
            console.log("recibido mensaje");
            for (var i = 0; i < messageObject.competitions.length; i++) {
                var comp = messageObject.competitions[i];
                stagesDetailModel.append({
                                    "id": comp.id,
                                    "name": comp.name,
                                    "eventID":comp.eventID,
                                    "initDate":comp.initDate,
                                    "finishDate":comp.finishDate,
                                    "editionID":comp.editionID,
                                    "genderID":comp.genderID,
                                    "classID":comp.classID,
                                    "phase1ID":comp.phase1ID,
                                    "phaseClassificationID":comp.phaseClassificationID,
                                    "eventPhaseID":comp.eventPhaseID,
                                    "competitionType":comp.competitionType,
                                    "competitionID":comp.competitionID,
                                    "winner":comp.winner});
            }

        }
    }

    ListModel{
        id:stagesDetailModel
    }

    ListView {
        id:stagesDetailList
        anchors.fill: parent
        clip: true
        model: stagesDetailModel
        delegate: stagesDetailDelegate
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
        id: stagesDetailDelegate
        Item{
            anchors{
                left: parent.left
                right: parent.right
            }
            height: 25
            Text {
                id:txtDate
                text: formatDate(initDate);
                width: 75
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
                    left: txtDate.right
                    margins: 3
                }
            }
            Text {
                id:txtWinner
                text: winner;
                width: 75
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                    left: txtName.right
                    margins: 3
                }
            }

           MouseArea {
                anchors.fill: parent
                onClicked: {
                    var baseUrl = "http://localhost:8282/rest/";
                    if (competitionType === 'STAGE_STAGES') {
                        //@Path("/stage/{competitionId},{eventID},{editionID],{genderID},{classID},{phase1ID}")
                        var url = baseUrl+"results/stage/"
                            +competitionID+","+eventID+","+editionID+","+genderID+","+classID+","+phase1ID;
                        stageResult(competitionID,eventID,editionID,genderID,classID,phase1ID);
                    } else if (competitionType === 'CLASSIFICATION_STAGES') {
                        //@Path("/classification/{competitionId},{eventID},{editionID},{genderID},{classID},{phase1ID},{phaseClassificationID}")
                        var url = baseUrl+"results/classification/"
                            +competitionID+","+eventID+","+editionID+","+genderID+","+classID
                            +","+phase1ID+","+phaseClassificationID;
                        stagesClassification(competitionID,eventID,editionID,genderID,classID,phaseClassificationID);

                    }
                    console.log("url:"+url);
                    //pageStack.push(Qt.resolvedUrl("FavoriteDetail.qml"))
                }
            }
        }
    }

}
