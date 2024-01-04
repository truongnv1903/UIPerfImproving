import QtQuick 2.14
import QtQuick.Controls 2.12
import qt.io 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Improving performance")

    StackView {
        id: stack

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: divider.left
        }

        Button {
            id: stackButton

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            text: "Push to stack"

            onClicked: {
                console.time("Stack")
                stack.push(nastyComponent)
                console.timeEnd("Stack")
            }
        }
    }

    Rectangle {
        id: divider
        height: parent.height
        width: 2
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Loader {
        id: loader

        anchors {
            top: parent.top
            bottom: parent.bottom
            left: divider.right
            right: parent.right
        }

        asynchronous: true
        active: false
        sourceComponent: nastyComponent

        Button {
            id: loaderButton

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

            text: "Load component"

            onClicked: {
                console.time("Loader")
                loader.active = true
            }
        }
        onLoaded: console.timeEnd("Loader")
    }

    Component {
        id: nastyComponent

        Flickable {
            contentHeight: grid.height

            Grid {
                id: grid

                Repeater {
                    model: 100
                    delegate: Image {
                        height: 50
                        fillMode: Image.PreserveAspectFit
                        source: "https://upload.wikimedia.org/wikipedia/commons/0/0b/Qt_logo_2016.svg"
                        sourceSize {
                            width: 578
                            height: 424
                        }

                        Component.onCompleted: {
                            let millis = 20
                            var date = Date.now()
                            var curDate = null
                            do {
                                curDate = Date.now()
                            } while (curDate - date < millis)
                        }
                    }
                }
            }
        }
    }
}
