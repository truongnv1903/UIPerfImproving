import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    CppModel {
        id: cppModel
    }

    Rectangle {
        id: divider
        height: parent.height
        width: 2
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Flickable {
        id: flickableWithRepeater

        anchors {
            top: parent.top
            left: parent.left
            right: divider.left
            bottom: parent.bottom
        }

        ColumnLayout {
            anchors.fill: parent
            Repeater {
                model: cppModel
                delegate: Text {
                    width: parent.width
                    height: 30
                    verticalAlignment: Text.AlignVCenter
                    text: model.text

                    Component.onCompleted: {
                        console.count("****FLICKABLE: Delegate created")
                    }

                    Component.onDestruction: {
                        console.count("****FLICKABLE: Delegate destroyed")
                    }
                }
            }
        }
    }

    ListView {
        id: listViewWithModel

        anchors {
            top: parent.top
            left: divider.right
            right: parent.right
            bottom: parent.bottom
        }

        model: cppModel

        delegate: Text {
            width: ListView.width
            height: 30
            verticalAlignment: Text.AlignVCenter
            text: model.text

            Component.onCompleted: {
                console.count("####LISTVIEW: Delegate created")
            }

            Component.onDestruction: {
                console.count("####LISTVIEW: Delegate destroyed")
            }
        }
    }
}
