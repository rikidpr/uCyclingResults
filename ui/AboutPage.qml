import QtQuick 2.0
import Ubuntu.Components 1.2
import Ubuntu.Components.ListItems 1.0 as ListItem
import "../js/StringFormats.js" as StringFormat;

Page{
    id: aboutPage;
    title: i18n.tr("About")
    Item {
            id: aboutSection
            anchors.fill:parent

            Column {
                anchors.fill: parent

                ListItem.Header {
                    text: i18n.tr("Credits:")
                }

                ListItem.Subtitled {
                    text: "2015 anDprSoft"
                    subText: "https://github.com/andprsoft/UCyclingResults"
                    onClicked: Qt.openUrlExternally("https://github.com/andprsoft/UCyclingResults")
                }

                ListItem.Subtitled {
                    text: "Developer"
                    subText: "Ricardo Sáez"
                }

                ListItem.Subtitled {
                    text: "Contact us:"
                    subText: "andprsoft@gmail.com"
                }

                ListItem.Subtitled {
                    text: "License: GNU GPLv3"
                    subText: "Run, study, modify, and distribute!"
                }
            }
        }   // END CREDI
}
