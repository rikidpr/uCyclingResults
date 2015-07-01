import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.Popups 1.0
import QtQuick.XmlListModel 2.0
import Ubuntu.Components.Pickers 1.0


Page {
    id: mainPage

    title: i18n.tr("Cycling Results")

    Column {
        spacing: units.gu(1)
        anchors {
            margins: units.gu(2)
            fill: parent
        }
        Button {
            objectName: "button"
            width: parent.width

            text: i18n.tr("Last month")

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
        DatePicker {
            id:datePicker
            mode: "Years|Months"
        }

        Button {
            objectName: "button"
            width: parent.width

            text: i18n.tr("Resultados 2013")

            onClicked: {
                console.log("vamos p'alli");
                var initDate = Qt.formatDate(datePicker.date, "yyyyMM")+"01";
                var finishDate =Qt.formatDate(datePicker.date, "yyyyMM")+"31";
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
