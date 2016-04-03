import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components.Pickers 1.0
import Ubuntu.Layouts 0.1
import "../js/StringFormats.js" as SF;

    Tabs {
        id: tabs
        Tab{
            title: i18n.tr("Lasts Competitions")
            page: Page{
                head.actions: [//15.04 en adelante
                    Action {
                        id: openAbout
                        text: i18n.tr("About...")
                        iconName: "help"
                        onTriggered: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
                    }
                ]
                Layouts{
                        id:lastSection
                        anchors.fill: parent
                        layouts :[
                            ConditionalLayout {
                              name: "portrait"
                              when: mainPage.width <= units.gu(45)
                              //default layout
                              Column {
                                  id:lastPortraitLayout
                                  spacing: units.gu(1)
                                  anchors {
                                      margins: units.gu(2)
                                      fill: parent
                                  }
                                  Button {
                                      id: btnLast
                                      objectName: "button"
                                      width: parent.width
                                      height: units.gu(20)
                                      text: i18n.tr("Last month Competitions")
                                      color:SF.getPositiveButtonColor()

                                      onClicked: getLastMonthCompetitions();
                                  }
                                  Button {
                                      id: btnUwt
                                      objectName: "button"
                                      width: parent.width
                                      height: units.gu(20)
                                      text: i18n.tr("UCI World Tour")
                                      color:SF.getPositiveButtonColor()

                                      onClicked: getLastYearCompetitions();
                                  }
                              }
                            },
                            ConditionalLayout {
                                name: "landscape"
                                when: mainPage.width > units.gu(45)
                                Grid {
                                    id:lastLandscapeLayout
                                    columns:2
                                    rows:1
                                    spacing: units.gu(1)
                                    anchors {
                                        margins: units.gu(2)
                                        fill: parent
                                    }
                                    Button {
                                        id: btnLastLandscape
                                        objectName: "button"
                                        height: units.gu(25)
                                        width: (mainPage.width/2)-units.gu(2)
                                        text: i18n.tr("Last month Competitions")
                                        color:SF.getPositiveButtonColor()

                                        onClicked: getLastMonthCompetitions();
                                    }
                                    Button {
                                        id: btnUwtLandscape
                                        objectName: "button"
                                        height: units.gu(25)
                                        width: (mainPage.width/2)-units.gu(2)
                                        text: i18n.tr("UCI World Tour")
                                        color:SF.getPositiveButtonColor()

                                        onClicked: getLastYearCompetitions();
                                    }
                                }
                            }

                        ]
                    }
            }
        }
        Tab {
            title: i18n.tr("query")
            page: Page{
                Column{
                    spacing: units.gu(1)
                    anchors {
                        margins: units.gu(2)
                        fill: parent
                    }
                    Row {
                        id:buttonsRow
                        width: parent.width
                        height: units.gu(10)
                        Button {
                            id:btnSelectedMonth
                            objectName: "button"
                            width: parent.width/2
                            height: units.gu(10)
                            text: i18n.tr("Month")
                            color:SF.getPositiveButtonColor()

                            onClicked: {
                                var initDate = Qt.formatDate(datePicker.date, "yyyyMM")+"01";
                                var finishDate =Qt.formatDate(datePicker.date, "yyyyMM")+"31";
                                var uciClass = uciClassModel.get(competitionClassSelect.selectedIndex).name;
                                var gender = genderModel.get(competitionGenderSelect.selectedIndex).genderId;
                                var sport = sportModel.get(competitionSportSelect.selectedIndex).sportId;
                                pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                                   {
                                                           "initDate":initDate,
                                                           "finishDate":finishDate,
                                                           "sportID":sport,
                                                           "genderID":gender,
                                                           "classID":"1",
                                                           "classificationType":uciClass}
                                               );
                            }
                        }
                        Button {
                            id:btnSelectedYear
                            objectName: "button"
                            width: parent.width/2
                            height: units.gu(10)
                            text: i18n.tr("Year")
                            color:SF.getPositiveButtonColor()

                            onClicked: {
                                var initDate = Qt.formatDate(datePicker.date, "yyyy")+"0101";
                                var finishDate =Qt.formatDate(datePicker.date, "yyyy")+"1231";
                                var uciClass = uciClassModel.get(competitionClassSelect.selectedIndex).name;
                                var gender = genderModel.get(competitionGenderSelect.selectedIndex).genderId;
                                var sport = sportModel.get(competitionSportSelect.selectedIndex).sportId;
                                pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                                   {
                                                           "initDate":initDate,
                                                           "finishDate":finishDate,
                                                           "sportID":sport,
                                                           "genderID":gender,
                                                           "classID":"1",
                                                           "classificationType":uciClass}
                                               );
                            }
                        }
                    }
                    DatePicker {
                        id:datePicker
                        //width: parent.width
                        mode: "Years|Months"
                        minimum: {
                            var d = new Date();
                            d.setFullYear(1900);
                            return d;
                        }
                        maximum: new Date();
                    }
                    ListModel{
                        id:uciClassModel
                        ListElement {name:"ALL"; description:"ALL"}
                        ListElement {name:"UWT"; description:"UWT"}
                        ListElement {name: "1.HC"; description:"1.HC"}
                        ListElement {name:"2.HC"; description:"2.HC"}
                        ListElement {name:"1.1"; description:"1.1"}
                        ListElement {name:"2.1"; description:"2.1"}
                        ListElement {name:"1.2"; description:"1.2"}
                        ListElement {name:"2.2"; description:"2.2"}
                        ListElement {name:"CN"; description:"CN"}//campeonato nacional
                        ListElement {name:"CM"; description:"CM"}//campeonato dle mundo
                        ListElement {name:"CDM"; description:"CDM"}//cyclocross
                        ListElement {name:"C1"; description:"C1"}//cyclocross
                        ListElement {name:"C2"; description:"C2"}//cyclocross
                    }

                    OptionSelector {
                        id: competitionClassSelect
                        expanded:false
                        selectedIndex: 0
                        delegate: OptionSelectorDelegate {
                            text: name
                        }
                        model: uciClassModel
                        containerHeight: units.gu(20)
                        width: parent.width
                        height: units.gu(4)
                    }

                    ListModel{
                        id:genderModel
                        ListElement {name:"Men"; description:"Men"; genderId:"1"}
                        ListElement {name:"Women"; description:"Women"; genderId:"2"}
                    }
                    OptionSelector {
                        id: competitionGenderSelect
                        expanded:false
                        selectedIndex: 0
                        delegate: OptionSelectorDelegate {
                            text: name
                        }
                        model: genderModel
                        containerHeight: units.gu(20)
                        width: parent.width
                        height: units.gu(4)
                        visible: {
                                    if (competitionClassSelect.currentlyExpanded)
                                        false;
                                    else
                                        true;
                                 }
                    }

                    ListModel{
                        id:sportModel
                        ListElement {name:"Road"; description:"Road"; sportId:"102"}
                        ListElement {name:"Cyclocross"; description:"Cyclocross"; sportId:"306"}
                    }
                    OptionSelector {
                        id: competitionSportSelect
                        expanded:false
                        selectedIndex: 0
                        delegate: OptionSelectorDelegate {
                            text: name
                        }
                        model: sportModel
                        containerHeight: units.gu(20)
                        width: parent.width
                        height: units.gu(4)
                        visible: {
                            if (competitionClassSelect.currentlyExpanded
                                    || competitionGenderSelect.currentlyExpanded)
                                false;
                            else
                                true;
                        }
                    }

                }
            }
        }
        Tab {
            title: i18n.tr("About...")
            page: AboutPage{ id:aboutPage }
        }






    /// JAVASCRIPT FUNCTIONS ///
    function getLastMonthCompetitions(){
        var cTime = new Date();
        var year = cTime.getFullYear();
        var month = cTime.getMonth()+1;
        var date = cTime.getDate();
        var finishDate = ""+year+(month<10 ? "0"+month : month)+(date<10 ? "0"+date : date);
        month = month -1;
        var initDate = ""+year+(month<10 ? "0"+month : month)+(date<10 ? "0"+date : date);
        var gender = "1";
        var sportId="102";
        pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                       {"initDate":initDate,
                        "finishDate":finishDate,
                        "genderID":gender,
                        "sportID":sportId,
                        "classID":"1",
                        "classificationType":"ALL"}
                       );
    }

    function getLastYearCompetitions(){
        var cTime = new Date();
        var year = cTime.getFullYear();
        var finishDate = ""+year+"1231";
        var initDate = ""+year+"0101";
        var gender = "1";
        var sportId="102";
        pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                           {"initDate":initDate,
                           "finishDate":finishDate,
                           "genderID":gender,
                           "sportID":sportId,
                           "classID":"1",
                           "classificationType":"UWT"}
                       );
    }

}
