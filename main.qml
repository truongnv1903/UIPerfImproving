import QtQuick 2.14
import QtQuick.Controls 2.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    CppLogic {
        id: cppLogicExample
    }

    CppModel {
        id: cppModel
    }

    Button {
        id: btn
        anchors {
            left: parent.left
            top: parent.top
        }
        width: 80
        height: 40
        text: qsTr("Test")
        onClicked: {
            if (swt.checked) {
                console.log("============ TEST LOGIC ============")
                var values = cppLogicExample.values()

                console.time("Sqrt - QML")
                var jsOutput = []
                for (var y = 0; y < values.length; y++) {
                    jsOutput.push(Math.sqrt(values[y]))
                }
                console.timeEnd("Sqrt - QML")

                console.time("Sqrt - Cpp")
                var cppOutput = cppLogicExample.calculateSqrt()
                console.timeEnd("Sqrt - Cpp")

                console.time("Sqrt - Cpp Asynch")
                var asynchOutput = cppLogicExample.calculateSqrtAsynch()
                console.timeEnd("Sqrt - Cpp Asynch")

                //Validation
                console.assert(compareArrays(cppOutput, jsOutput),
                               "Output differs!")
                console.assert(compareArrays(cppOutput, asynchOutput),
                               "Output differs!")
            } else {
                console.log("============ TEST MODEL ============")
                listViewWithoutModel.model = cppModel.rawList
                //                console.log(JSON.stringify(cppModel))
                console.log(JSON.stringify(cppModel.rawList))
                console.log(JSON.stringify(listViewWithoutModel.model))
            }
        }
    }

    Switch {
        id: swt
        anchors {
            top: parent.top
            left: btn.right
            leftMargin: 5
        }
        text: checked ? qsTr("Logic") : qsTr("Model")
    }

    Rectangle {
        id: divider
        height: parent.height
        width: 2
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ListView {
        id: listViewWithoutModel

        anchors {
            top: btn.bottom
            left: parent.left
            right: divider.left
            bottom: btnAppend.top
        }
        clip: true
        model: cppModel.rawList
        delegate: Text {
            width: ListView.width
            height: 30
            verticalAlignment: Text.AlignVCenter
            text: modelData

            Component.onCompleted: {
                console.count("****LIST: Delegate created")
            }

            Component.onDestruction: {
                console.count("****LIST: Delegate destroyed")
            }
        }
    }

    ListView {
        id: listViewWithModel

        anchors {
            top: btn.bottom
            left: divider.right
            right: parent.right
            bottom: btnAppend.top
        }

        model: cppModel

        delegate: Text {
            width: ListView.width
            height: 30
            verticalAlignment: Text.AlignVCenter
            text: model.text

            Component.onCompleted: {
                console.count("####MODEL: Delegate created")
            }

            Component.onDestruction: {
                console.count("####MODEL: Delegate destroyed")
            }
        }
    }

    Button {
        id: btnAppend
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        width: 80
        height: 40
        text: qsTr("Append")
        onClicked: {
            console.log("============ APPEND TO MODEL ============")
            cppModel.prependValueToModel()
        }
    }

    //...
    function compareArrays(left, right) {
        return left.length === right.length && left.every(
                    function (value, index) {
                        return value.toFixed(6) === right[index].toFixed(6)
                    })
    }
}
