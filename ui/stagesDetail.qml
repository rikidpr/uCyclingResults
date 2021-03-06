import QtQuick 2.0
import Ubuntu.Components 1.2
import "../js/StringFormats.js" as SF;

Page{
    id: stagesDetailPage;
    title: i18n.tr("StagesTourDetail");
    //parametros
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
            PropertyChanges {target: stagesDetailItem; opacity: 0}
        },
        State {
            name: "LOADED"
            PropertyChanges {target: activityIndicator; opacity: 0}
            PropertyChanges {target: stagesDetailItem; opacity: 1}
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
        id:stagesDetailItem
        anchors.fill: parent;
        opacity: 0;

        Component.onCompleted: {
            console.log("vamos a ello");
            console.log(competitionID+","+eventID+","+editionID+","+genderID+","+classID);
            stagesDetailWorker.sendMessage({"competitionID":competitionID,
                                               "eventID":eventID,
                                               "editionID":editionID,
                                               "genderID": genderID,
                                               "classID":classID})
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
                                        "winner":typeof(comp.winner) === 'undefined' ? '' : comp.winner,
                                        "leader":typeof(comp.leader) === 'undefined' ? '' : comp.leader});
                }
                stagesDetailPage.state="LOADED";
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
            id: stagesDetailDelegate
            Item{
                anchors{
                    left: parent.left
                    right: parent.right
                }
                height: units.gu(3);
                Label {
                    id:txtDate
                    text: SF.formatDate(initDate);
                    width: units.gu(10);
                    fontSize: "small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        margins: units.gu(0.5)
                    }
                }
                Rectangle {
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(3)
                    color: SF.getListBackgroundColor(index);
                }
                Label {
                    id:txtName
                    text: name
                    fontSize: "small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtDate.right
                        right: txtWinner.left
                        margins: units.gu(0.5)
                    }
                }
                Label {
                    id:txtWinner
                    text: phase1ID === 0 ? leader : winner;
                    width: units.gu(15)
                    fontSize: "x-small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        right: parent.right
                        margins: units.gu(0.5)
                    }
                }

               MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (competitionType === 'STAGE_STAGES') {
                            stageResult(name, competitionID,eventID,editionID,genderID,classID,phase1ID);
                        } else if (competitionType === 'CLASSIFICATION_STAGES') {
                            stagesClassification(name, competitionID,eventID,editionID,genderID,classID,phaseClassificationID);
                        }
                    }
                }
            }
        }

    }
}
