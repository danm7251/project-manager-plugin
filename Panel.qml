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

    property var projects: pluginApi?.pluginSettings?.projects || []
    property bool showAddDialog: false

    function addProject(name) {
        var updated  = projects.slice()
        updated.push({ name: name })
        pluginApi.pluginSettings.projects = updated
        pluginApi.saveSettings()
        projects = updated
    }

    function removeProject(index) {
        var updated = projects.slice()
        updated.splice(index, 1)
        pluginApi.pluginSettings.projects = updated
        pluginApi.saveSettings()
        projects = updated
    }

    Rectangle {
        id: panelContainer
        anchors.fill: parent
        color: "transparent"

        Loader {
            anchors.fill: parent
            sourceComponent: root.showAddDialog ? addDialogComponent : projectListComponent
        }

        Component {
            id: projectListComponent

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

                        onClicked: root.showAddDialog = true
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

                                    onClicked: root.removeProject(index)
                                }
                            }
                        }
                    }
                }
            }
        }

        Component {
            id: addDialogComponent

            ColumnLayout {
                id: dialogLayout
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: Style.marginL
                }
                spacing: Style.marginM

                NText {
                    text: "New project"
                }

                NTextInput {
                    id: nameInput
                }

                // Optional
                // Will have a graphical selector as well
                Item {
                    Layout.fillWidth: true
                    implicitHeight: pathInput.implicitHeight

                    NTextInput {
                        id: pathInput
                        anchors.fill: parent
                    }

                    NIconButton {
                        icon: "folder-open"
                        anchors {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            rightMargin: 3
                            // rightMargin: Style.marginS
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    NButton {
                        text: "Cancel"
                        onClicked: {
                            root.showAddDialog = false
                            nameInput.text = ""
                        }
                    }

                    NButton {
                        text: "Save"
                        enabled: nameInput.text.trim() !== ""
                        onClicked: {
                            root.addProject(nameInput.text.trim())
                            root.showAddDialog = false
                            nameInput.text = ""
                        }
                    }
                }
            }
        }
    }
}