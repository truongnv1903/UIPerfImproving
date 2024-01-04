import QtQuick 2.14
import QtQuick.Controls 2.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    Rectangle {
        id: backgroundRect
        width: 200
        height: 200
        color: "red"
        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Assume multiple clicks happen in quick succession
                Qt.callLater(backgroundRect.changeBackgroundColor, "yellow")
                Qt.callLater(backgroundRect.changeBackgroundColor, "blue")
                Qt.callLater(backgroundRect.changeBackgroundColor, "green")
            }
        }
        function changeBackgroundColor(newColor) {
            console.log("Hi! I'm switching to color " + newColor)
            backgroundRect.color = newColor
        }
    }

    Item {
        id: example

        property int callLaterCounter: 0
        property int counter: 0
        readonly property int executionTargetCount: 5

        function callLaterExample() {
            for (var x = 0; x < example.executionTargetCount; x++) {
                example.foo()
            }
            for (var y = 0; y < example.executionTargetCount; y++) {
                Qt.callLater(example.bar)
            }
            console.log("Counter: " + example.counter)
            Qt.callLater(function () {
                console.log("CallLaterCounter: " + example.callLaterCounter)
            })
        }

        function foo() {
            console.log("Doing a thing!")
            example.counter++
        }

        function bar() {
            console.log("Need to be executed once!")
            example.callLaterCounter++
        }

        Component.onCompleted: {
            example.callLaterExample()
        }
    }
}
