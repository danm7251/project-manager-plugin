import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

Item {
    id: root

    property var pluginApi: null

    // SmartPanel properties (required for panel behavior)
    readonly property var geometryPlaceholder: panelContainer
    readonly property bool allowAttach: true

    property real contentPreferredWidth: 300 * Style.uiScaleRatio
    property real contentPreferredHeight: 400 * Style.uiScaleRatio

    anchors.fill: parent

    // Hardcoded for now
    property var projects: [
        {
            name: "Quantum Simulator"
        },
        {
            name: "Crypto Price Aggregator"
        },
        {
            name: "Project Manager Plugin"
        }
    ]

    Rectangle {
        id: panelContainer
        anchors.fill: parent
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.marginM
            spacing: Style.marginM

            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Text {
                    text: "Projects"
                    font.pointSize: Style.fontSizeL
                    font.weight: Font.Medium
                    color: Color.mOnSurface
                }

                NIconButton {
                    icon: "plus"
                    baseSize: Style.baseWidgetSize * 0.8
                }
            }

            ListView {
                property var buttonSize: 0.8

                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: Style.marginL
                model: projects

                delegate: Rectangle {
                    width: ListView.view.width
                    height: itemLayout.implicitHeight + Style.marginM * 2
                    color: Color.mSurfaceVariant
                    radius: 8
                    border.color: Color.mOutline
                    border.width: 1

                    ColumnLayout {
                        id: itemLayout
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            margins: Style.marginM
                        }
                        spacing: Style.marginM

                        RowLayout {
                            Layout.fillWidth: true

                            NText {
                                Layout.fillWidth: true
                                text: modelData.name
                                font.pointSize: font.fontSizeM
                            }

                            NIconButton {
                                icon: "brand-github"
                                baseSize: Style.baseWidgetSize * buttonSize
                            }

                            NIconButton {
                                icon: "folder"
                                baseSize: Style.baseWidgetSize * buttonSize
                            }

                            NIconButton {
                                icon: "trash"
                                baseSize: Style.baseWidgetSize * buttonSize
                            }
                        }
                    }
                }
            }
        }
    }
}