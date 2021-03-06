import QtQuick 2.0
import Ubuntu.Components 1.2
import "../js/StringFormats.js" as SF;

Page{
    id:competitionsListPage
    title: i18n.tr("Competitions List")
    property string initDate;
    property string finishDate
    property string sportID;
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
        id:competitionsItem
        anchors.fill: parent;
        opacity: 0;

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
                                        "sportID":comp.sportID,
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
                "sportID":sportID,
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
            id: competitionsDelegate
            Item{
                anchors{
                    left: parent.left
                    right: parent.right
                }
                height: units.gu(3);
                Rectangle {
                    anchors{
                        left: parent.left
                        right: parent.right
                    }
                    height: units.gu(3)
                    color: SF.getListBackgroundColor(index);
                }
                Label {
                    id:txtDate
                    text: SF.formatDate(initDate);
                    fontSize:"small"
                    width: units.gu(10)
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: parent.left
                        margins: units.gu(0.5)
                    }
                }
                Label {
                    id:txtName
                    text: name
                    fontSize: "small"
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtDate.right
                        right: parent.right
                        margins: units.gu(0.5)
                    }
                }
                /*Text {
                    id:txtCompType
                    text: SF.getCompetitionTypeName(competitionType);
                    width: 75
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        left: txtName.right
                        margins: units.gu(0.5)
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
                        margins: units.gu(0.5)
                    }
                }*/
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
                            oneDayResult(name, competitionID,eventID,editionID,genderID,classID);
                        }
                        console.log("url:"+url);

                    }
                }
            }
        }

    }
}
