import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

ShellRoot {
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      property var hyprMonitor: Hyprland.monitorFor(modelData)
      property int activeWorkspaceId: hyprMonitor && hyprMonitor.activeWorkspace ? hyprMonitor.activeWorkspace.id : -1

      screen: modelData
      implicitHeight: 34
      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      exclusiveZone: implicitHeight

      Rectangle {
        anchors.fill: parent
        color: "#181818"

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 12
          anchors.rightMargin: 12
          spacing: 12

          Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 6

            Repeater {
              model: 9

              Rectangle {
                property bool isActive: activeWorkspaceId === index + 1

                width: 22
                height: 22
                radius: 4
                color: isActive ? "#8aadf4" : "#2a2a2a"

                Text {
                  anchors.centerIn: parent
                  text: index + 1
                  color: isActive ? "#101010" : "#d6d6d6"
                  font.pixelSize: 12
                  font.bold: isActive
                }

                MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
              }
            }
          }

          Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : "mini"
            color: "#d6d6d6"
            font.pixelSize: 13
            elide: Text.ElideRight
          }

          Text {
            Layout.alignment: Qt.AlignVCenter
            text: Qt.formatDateTime(clock.date, "ddd MMM d  h:mm AP")
            color: "#f0f0f0"
            font.pixelSize: 13
            font.bold: true
          }
        }
      }
    }
  }
}
