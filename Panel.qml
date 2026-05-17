import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets

Item {
    id: root

    property var pluginApi: null

    property real contentPreferredWidth: 700 * Style.uiScaleRatio
    property real contentPreferredHeight: 500 * Style.uiScaleRatio

    anchors.fill: parent

    Rectangle {
        id: panel
        anchors.fill: parent
        color: Style.mOnSurface

        NText {
            text: "Projects:"
            color: Style.mOnSurface
        }
    }
}