import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

Control {
    id: root

    // -- Modules
    Module { id: module }

    Item {
        Shape {
            id: shape

            width: 16
            height: 16

            property var path: [
                Qt.point(0, 0),
                Qt.point(16, 0),
            ]

            ShapePath {
                PathPolyline {
                    path: shape.path
                }
            }

            ShapePath {
                strokeStyle: ShapePath.DashLine

                SequentialAnimation on dashOffset {
                    loops: Animation.Infinite
                    PropertyAnimation {
                        duration: 1000
                        to: 2.5
                    }
                }

                PathPolyline {
                    path: shape.path
                }
            }
        }

        Button {
            text: "Open"
            onClicked: {
                module.dialog.open()
            }
        }
    }
}
