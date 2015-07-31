import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components.Pickers 1.0
import Ubuntu.Layouts 0.1
import "../js/StringFormats.js" as SF;

Page {
    id: mainPage

    title: i18n.tr("Cycling Results")

    head.actions: [//15.04 en adelante
        Action {
            id: openAbout
            text: i18n.tr("About...")
            iconName: "help"
            onTriggered: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
        }
    ]

    Tabs {
        id: tabs
        Tab {
            tittle: i18n.tr("query")
            page: Page{
                Column{
                    spacing: units.gu(1)
                    anchors {
                        margins: units.gu(2)
                        fill: parent
                    }
                    Button {
                        id:btnSelectedMonth
                        objectName: "button"
                        width: parent.width
                        height: units.gu(10)
                        text: i18n.tr("Select month competitions")
                        color:SF.getPositiveButtonColor()

                        onClicked: {
                            var initDate = Qt.formatDate(datePicker.date, "yyyyMM")+"01";
                            var finishDate =Qt.formatDate(datePicker.date, "yyyyMM")+"31";
                            var uciClass = uciClassModel.get(competitionClassSelect.selectedIndex).name;
                            pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                               {
                                                       "initDate":initDate,
                                                       "finishDate":finishDate,
                                                       "genderID":"1",
                                                       "classID":"1",
                                                       "classificationType":uciClass}
                                           );
                        }
                    }
                    Button {
                        id:btnSelectedYear
                        objectName: "button"
                        width: parent.width
                        height: units.gu(10)
                        text: i18n.tr("Select year competitions")
                        color:SF.getPositiveButtonColor()

                        onClicked: {
                            var initDate = Qt.formatDate(datePicker.date, "yyyy")+"0101";
                            var finishDate =Qt.formatDate(datePicker.date, "yyyy")+"1231";
                            var uciClass = uciClassModel.get(competitionClassSelect.selectedIndex).name;
                            pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                               {
                                                       "initDate":initDate,
                                                       "finishDate":finishDate,
                                                       "genderID":"1",
                                                       "classID":"1",
                                                       "classificationType":uciClass}
                                           );
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

                    Label{
                        text: i18n.tr("Uci Class:")
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
                        ListElement {name:"CN"; description:"CN"}
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
                        height: units.gu(2)
                    }
                }
            }
        }
        Tab{
            title: i18n.tr("Lasts")
            page: Page{
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
                                Row {
                                    id:lastLandscapeLayout
                                    spacing: units.gu(1)
                                    anchors {
                                        margins: units.gu(2)
                                        fill: parent
                                    }
                                    Button {
                                        id: btnLastLandscape
                                        objectName: "button"
                                        anchors {
                                            top: parent.top
                                            left: parent.left
                                        }
                                        height: units.gu(20)
                                        text: i18n.tr("Last month Competitions")
                                        color:SF.getPositiveButtonColor()

                                        onClicked: getLastMonthCompetitions();
                                    }
                                    Button {
                                        id: btnUwtLandscape
                                        objectName: "button"
                                        anchors {
                                            top: parent.top
                                            right: parent.right
                                        }
                                        height: units.gu(20)
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
    }



    /// JAVASCRIPT FUNCTIONS ///
    function getLastMonthCompetitions(){
        var cTime = new Date();
        var year = cTime.getFullYear();
        var month = cTime.getMonth()+1;
        var date = cTime.getDate();
        var finishDate = ""+year+(month<10 ? "0"+month : monht)+(date<10 ? "0"+date : date);
        month = month -1;
        var initDate = ""+year+(month<10 ? "0"+month : monht)+(date<10 ? "0"+date : date);

        pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                       {"initDate":initDate,
                        "finishDate":finishDate,
                        "genderID":"1",
                        "classID":"1",
                        "classificationType":"ALL"}
                       );
    }

    function getLastYearCompetitions(){
        var cTime = new Date();
        var year = cTime.getFullYear();
        var finishDate = ""+year+"1231";
        var initDate = ""+year+"0101";

        pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                           {"initDate":initDate,
                           "finishDate":finishDate,
                           "genderID":"1",
                           "classID":"1",
                           "classificationType":"UWT"}
                       );
    }

}
