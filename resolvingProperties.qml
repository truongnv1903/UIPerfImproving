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
    //    Rectangle {
    //        id: rect
    //        anchors.fill: parent
    //        color: "blue"
    //    }

    //    function printValue(which, value) {
    //        console.log(which + " = " + value)
    //    }

    //    Component.onCompleted: {
    //        var t0 = new Date()
    //        for (var i = 0; i < 1000; ++i) {
    //            printValue("red", rect.color.r)
    //            printValue("green", rect.color.g)
    //            printValue("blue", rect.color.b)
    //            printValue("alpha", rect.color.a)
    //        }
    //        var t1 = new Date()
    //        console.log("Took: " + (t1.valueOf() - t0.valueOf(
    //                                    )) + " milliseconds for 1000 iterations")
    //    }

    //good
    //    Rectangle {
    //        id: rect
    //        anchors.fill: parent
    //        color: "blue"
    //    }

    //    function printValue(which, value) {
    //        console.log(which + " = " + value)
    //    }

    //    Component.onCompleted: {
    //        var t0 = new Date()
    //        for (var i = 0; i < 1000; ++i) {
    //            var rectColor = rect.color
    //            // resolve the common base.
    //            printValue("red", rectColor.r)
    //            printValue("green", rectColor.g)
    //            printValue("blue", rectColor.b)
    //            printValue("alpha", rectColor.a)
    //        }
    //        var t1 = new Date()
    //        console.log("Took: " + (t1.valueOf() - t0.valueOf(
    //                                    )) + " milliseconds for 1000 iterations")
    //    }

    //better
    Rectangle {
        id: rect
        anchors.fill: parent
        color: "blue"
    }

    function printValue(which, value) {
        console.log(which + " = " + value)
    }

    Component.onCompleted: {
        var t0 = new Date()
        var rectColor = rect.color
        // resolve the common base outside the tight loop.
        for (var i = 0; i < 1000; ++i) {
            printValue("red", rectColor.r)
            printValue("green", rectColor.g)
            printValue("blue", rectColor.b)
            printValue("alpha", rectColor.a)
        }
        var t1 = new Date()
        console.log("Took: " + (t1.valueOf() - t0.valueOf(
                                    )) + " milliseconds for 1000 iterations")
    }
}
