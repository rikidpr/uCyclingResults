import QtQuick 2.0
import Ubuntu.Components 1.2
import "../js/StringFormats.js" as SF;

Page{
    id:competitionsListPage
    title: i18n.tr("Competitions List")
    property string initDate;
    property string finishDate
    property string genderID;
    property string classID;
    property string classificationType;
    state: "LOADING"

    states: [
        State {
            name: "LOADING"
            PropertyChanges {target: activityIndicator; opacity: 1}
            PropertyChanges {target: competitionsItem; opacity: 0}
        },
        State {
            name: "LOADED"
            PropertyChanges {target: activityIndicator; opacity: 0}
            PropertyChanges {target: competitionsItem; opacity: 1}
        }

    ]

    ActivityIndicator {
        id: activityIndicator
        anchors.fill: parent
        runing:true;
        opacity: 1;
    }

    Item{
        id:competitionsItem
        anchors.fill: parent;
        opcatity: 0;

        WorkerScript {
            id: competitionsWorker
            source: "../js/uciCompetitions.js"

            onMessage: {
                console.log("recibido mensaje");
                for (var i = 0; i < messageObject.competitions.length; i++) {
                    var comp = messageObject.competitions[i];
                    competitionsModel.append({
                                        "id": comp.id,
                                        "name": comp.name,
                                        "eventID":comp.eventID,
                                        "initDate":comp.initDate,
                                        "finishDate":comp.finishDate,
                                        "editionID":comp.editionID,
                                        "genderID":comp.genderID,
                                        "classID":comp.classID,
                                        "phase1ID":comp.phase1ID,
                                        "sportID":comp.sportID,
                                        "seasonID":comp.seasonID,
                                        "competitionClass":comp.competitionClass,
                                        "eventPhaseID":comp.eventPhaseID,
                                        "nationality":comp.nationality,
                                        "competitionType":comp.competitionType,
                                        "competitionID":comp.competitionID});
                }
                competitionsListPage.state="LOADED";
            }
        }

        Component.onCompleted: {
            competitionsWorker.sendMessage({
                "initDate":initDate,
                "finishDate":finishDate,
                "genderID":genderID,
                "classID":classID,
                "classificationType":classificationType})
        }


        ListModel{
            id:competitionsModel
        }

        ListView {
            id:competitionsList
            anchors.fill: parent
            clip: true
            model: competitionsModel
            delegate: competitionsDelegate
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
            id: competitionsDelegate
            Item{
                anchors{
                    left: parent.left
                    right: parent.right
                }
                height: 25
                Text {
                    id:txtDate
                    text: SF.formatDate(initDate);
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
                    id:txtCompType
                    text: SF.getCompetitionTypeName(competitionType);
                    width: 75
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtName.right
                        margins: 3
                    }
                }
                Text {
                    id:txtClass
                    text: competitionClass;
                    width: 50
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtCompType.right
                        right: parent.right
                        margins: 3
                    }
                }
               MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var baseUrl = "http://localhost:8282/rest/";
                        if (competitionType === 'STAGES'){
                            var url = baseUrl+"competitions/stageRaceCompetitions/"
                                +competitionID+","+eventID+","+editionID+","+genderID+","+classID;
                            stagesCompDetail(competitionID,eventID,editionID,genderID,classID);
                        } else if (competitionType === 'ONE_DAY') {
                            var url = baseUrl+"results/oneDay/"
                                +competitionID+","+eventID+","+editionID+","+genderID+","+classID;
                            oneDayResult(competitionID,eventID,editionID,genderID,classID);
                        }
                        console.log("url:"+url);

                    }
                }
            }
        }

    }
}
