import QtQuick 2.14
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    // bad (tight loop)
    //    SequenceType {
    //        id: root
    //        width: 200
    //        height: 200

    //        Component.onCompleted: {
    //            var t0 = new Date()
    //            qrealListProperty.length = 100
    //            for (var i = 0; i < 500; ++i) {
    //                for (var j = 0; j < 100; ++j) {
    //                    qrealListProperty[j] = j
    //                }
    //            }
    //            var t1 = new Date()
    //            console.log("elapsed: " + (t1.valueOf() - t0.valueOf(
    //                                           )) + " milliseconds")
    //        }
    //    }

    //good (tight loop)
    //    SequenceType {
    //        id: root
    //        width: 200
    //        height: 200

    //        Component.onCompleted: {
    //            var t0 = new Date()
    //            var someData = []
    //            someData.length = 100
    //            for (var i = 0; i < 500; ++i) {
    //                for (var j = 0; j < 100; ++j) {
    //                    someData[j] = j
    //                }
    //                qrealListProperty = someData
    //            }
    //            var t1 = new Date()
    //            console.log("elapsed: " + (t1.valueOf() - t0.valueOf(
    //                                           )) + " milliseconds")
    //        }
    //    }

    //bad (re-evaluation)
    SequenceType {
        id: root
        property int firstBinding: qrealListProperty[1] + 10
        property int secondBinding: qrealListProperty[1] + 20
        property int thirdBinding: qrealListProperty[1] + 30

        Component.onCompleted: {
            var t0 = new Date()
            for (var i = 0; i < 1000; ++i) {
                qrealListProperty[2] = i
            }
            var t1 = new Date()
            console.log("elapsed: " + (t1.valueOf() - t0.valueOf(
                                           )) + " milliseconds")
        }
    }

    //good (re-evaluation)
    //        SequenceType {
    //            id: root

    //            property int intermediateBinding: qrealListProperty[1]
    //            property int firstBinding: intermediateBinding + 10
    //            property int secondBinding: intermediateBinding + 20
    //            property int thirdBinding: intermediateBinding + 30

    //            Component.onCompleted: {
    //                var t0 = new Date()
    //                for (var i = 0; i < 1000; ++i) {
    //                    qrealListProperty[2] = i
    //                }
    //                var t1 = new Date()
    //                console.log("elapsed: " + (t1.valueOf() - t0.valueOf(
    //                                               )) + " milliseconds")
    //            }
    //        }
}
