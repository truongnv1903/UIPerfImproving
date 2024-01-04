import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    // bad
    property int accumulatedValue: 0

    Text {
        anchors.fill: parent
        text: root.accumulatedValue.toString()
        onTextChanged: console.log("text binding re-evaluated")
    }

    Component.onCompleted: {
        var someData = [1, 2, 3, 4, 5, 20]
        for (var i = 0; i < someData.length; ++i) {
            accumulatedValue = accumulatedValue + someData[i]
        }
    }

    //good
    //    property int accumulatedValue: 0

    //    Text {
    //        anchors.fill: parent
    //        text: root.accumulatedValue.toString()
    //        onTextChanged: console.log("text binding re-evaluated")
    //    }

    //    Component.onCompleted: {
    //        var someData = [1, 2, 3, 4, 5, 20]
    //        var temp = accumulatedValue
    //        for (var i = 0; i < someData.length; ++i) {
    //            temp = temp + someData[i]
    //        }
    //        accumulatedValue = temp
    //    }
}
