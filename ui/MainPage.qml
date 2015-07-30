import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components.Pickers 1.0


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

    head.sections.model:[i18n.tr("query"), i18n.tr("last")]

    Loader {
        id: view

        anchors {
            fill: parent
            margins: units.gu(2)
        }

        sourceComponent: {
            if (mainPage.head.sections.selectedIndex === 0)
                return querySection

            if (mainPage.head.sections.selectedIndex === 1)
                return lastSection

        }
    }


    Component{
        id: querySection
        Column{
            anchors.fill:parent
            Button {
                objectName: "button"
                width: parent.width

                text: i18n.tr("Select month competitions")

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

    Component{
        id:lastSection
        Column {
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

                onClicked: {
                    console.log("");

                    var cTime = new Date();
                    var year = cTime.getFullYear();
                    var month = cTime.getMonth()+1;
                    var date = cTime.getDate();
                    var finishDate = ""+year+(month<10 ? "0"+month : monht)+(date<10 ? "0"+date : date);
                    month = month -1;
                    var initDate = ""+year+(month<10 ? "0"+month : monht)+(date<10 ? "0"+date : date);

                    pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                       {
                                               "initDate":initDate,
                                               "finishDate":finishDate,
                                               "genderID":"1",
                                               "classID":"1",
                                               "classificationType":"ALL"}
                                   );
                }
            }
            Button {
                id: btnUwt
                objectName: "button"
                width: parent.width
                height: units.gu(20)

                text: i18n.tr("UCI World Tour")

                onClicked: {
                    console.log("");

                    var cTime = new Date();
                    var year = cTime.getFullYear();
                    var finishDate = ""+year+"1231";
                    var initDate = ""+year+"0101";

                    pageStack.push(Qt.resolvedUrl("competitionsList.qml"),
                                       {
                                               "initDate":initDate,
                                               "finishDate":finishDate,
                                               "genderID":"1",
                                               "classID":"1",
                                               "classificationType":"UWT"}
                                   );
                }
            }
        }
    }



}
