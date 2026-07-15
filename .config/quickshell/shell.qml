import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

ShellRoot {
  property color bg: "#1a1b26"
  property color panel: "#24283b"
  property color panelSoft: "#32344a"
  property color fg: "#a9b1d6"
  property color bright: "#c0caf5"
  property color accent: "#7aa2f7"
  property color urgent: "#f7768e"

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
      implicitHeight: 36
      color: "transparent"

      anchors {
        top: true
        left: true
        right: true
      }

      exclusiveZone: implicitHeight

      Rectangle {
        anchors.fill: parent
        color: bg

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 10
          anchors.rightMargin: 10
          spacing: 10

          Rectangle {
            Layout.alignment: Qt.AlignVCenter
            width: 56
            height: 24
            radius: 6
            color: panel
            border.width: 1
            border.color: panelSoft

            Text {
              anchors.centerIn: parent
              text: "mini"
              color: bright
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: 12
              font.bold: true
            }
          }

          Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 5

            Repeater {
              model: 9

              Rectangle {
                property bool isActive: activeWorkspaceId === index + 1

                width: isActive ? 28 : 22
                height: 22
                radius: 6
                color: isActive ? accent : panel
                border.width: isActive ? 0 : 1
                border.color: panelSoft

                Text {
                  anchors.centerIn: parent
                  text: index + 1
                  color: isActive ? bg : fg
                  font.family: "JetBrainsMono Nerd Font"
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
            color: fg
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 13
            elide: Text.ElideRight
          }

          Rectangle {
            Layout.alignment: Qt.AlignVCenter
            width: 156
            height: 24
            radius: 6
            color: panel
            border.width: 1
            border.color: panelSoft

            Text {
              anchors.centerIn: parent
              text: Qt.formatDateTime(clock.date, "ddd MMM d  h:mm AP")
              color: bright
              font.family: "JetBrainsMono Nerd Font"
              font.pixelSize: 12
              font.bold: true
            }
          }
        }
      }
    }
  }
}
