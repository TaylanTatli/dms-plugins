import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
  id: pluginRoot

  // Automatically loaded from settings
  property string saveLocation: pluginData.saveLocation || "~/Pictures/Screenshots"

  // State for dynamic height calculation
  property int openSubmenuIndex: -1
  property int baseHeight: 282  // Header + 4 main items + padding
  property int submenuHeight: 170  // Height of one open submenu (4 items + padding)

  property var commands: [
    {
      label: "Copy to Clipboard",
      command: "grimblast",
      args: ["copy", "area"],
      submenu: [
        {
          label: "Area",
          command: "grimblast",
          args: ["copy", "area"]
        },
        {
          label: "Active Window",
          command: "grimblast",
          args: ["copy", "active"]
        },
        {
          label: "Current Output",
          command: "grimblast",
          args: ["copy", "output"]
        },
        {
          label: "All Screens",
          command: "grimblast",
          args: ["copy", "screen"]
        }
      ]
    },
    {
      label: "Save to File",
      command: "grimblast",
      args: ["save", "area"],
      submenu: [
        {
          label: "Area",
          command: "grimblast",
          args: ["save", "area"]
        },
        {
          label: "Active Window",
          command: "grimblast",
          args: ["save", "active"]
        },
        {
          label: "Current Output",
          command: "grimblast",
          args: ["save", "output"]
        },
        {
          label: "All Screens",
          command: "grimblast",
          args: ["save", "screen"]
        }
      ]
    },
    {
      label: "Copy & Save",
      command: "grimblast",
      args: ["copysave", "area"],
      submenu: [
        {
          label: "Area",
          command: "grimblast",
          args: ["copysave", "area"]
        },
        {
          label: "Active Window",
          command: "grimblast",
          args: ["copysave", "active"]
        },
        {
          label: "Current Output",
          command: "grimblast",
          args: ["copysave", "output"]
        },
        {
          label: "All Screens",
          command: "grimblast",
          args: ["copysave", "screen"]
        }
      ]
    },
    {
      label: "Edit Screenshot",
      command: "grimblast",
      args: ["edit", "area"],
      submenu: [
        {
          label: "Area",
          command: "grimblast",
          args: ["edit", "area"]
        },
        {
          label: "Active Window",
          command: "grimblast",
          args: ["edit", "active"]
        },
        {
          label: "Current Output",
          command: "grimblast",
          args: ["edit", "output"]
        },
        {
          label: "All Screens",
          command: "grimblast",
          args: ["edit", "screen"]
        }
      ]
    }
  ]

  function executeCommand(command, args) {
    if (ToastService) {
      ToastService.showInfo("Taking screenshot...");
    }

    const fullCommand = [command].concat(args);
    console.log("Grimblast: Executing command:", fullCommand.join(" "));

    Proc.runCommand("grimblast.execute", fullCommand, (output, exitCode) => {
      if (exitCode !== 0) {
        console.error("Grimblast: Command failed with code:", exitCode);
        if (output) {
          console.error("Grimblast: Error output:", output);
        }
        if (ToastService) {
          ToastService.showError("Screenshot failed (code: " + exitCode + ")");
        }
      } else {
        console.log("Grimblast: Command succeeded");
        if (ToastService) {
          ToastService.showInfo("Screenshot taken successfully");
        }
      }
    });
  }

  horizontalBarPill: Component {
    DankIcon {
      name: "screenshot_region"
      color: Theme.surfaceText
      size: Theme.iconSize
    }
  }

  verticalBarPill: Component {
    DankIcon {
      name: "screenshot_region"
      color: Theme.surfaceText
      size: Theme.iconSize
    }
  }

  popoutWidth: 300
  popoutHeight: openSubmenuIndex >= 0 ? baseHeight + submenuHeight : baseHeight

  popoutContent: Component {
    PopoutComponent {
      id: popoutRoot

      headerText: "Grimblast"
      detailsText: "Select screenshot action and target"
      showCloseButton: true

      // Reset submenu state when popout is closed
      onVisibleChanged: {
        if (!visible) {
          pluginRoot.openSubmenuIndex = -1;
        }
      }

      Column {
        id: mainColumn
        width: parent.width
        spacing: Theme.spacingS

        Repeater {
          id: commandRepeater
          model: pluginRoot.commands

          Column {
            id: menuItemColumn
            width: parent.width
            spacing: 0

            property int itemIndex: index
            property bool submenuOpen: pluginRoot.openSubmenuIndex === index

            StyledRect {
              width: parent.width
              height: 44
              color: mainItemMouseArea.containsMouse ? Theme.surfaceContainerHighest : Theme.surfaceContainerHigh
              radius: Theme.cornerRadius
              border.width: 0

              RowLayout {
                anchors.fill: parent
                anchors.leftMargin: Theme.spacingM
                anchors.rightMargin: Theme.spacingM
                spacing: Theme.spacingS

                StyledText {
                  Layout.fillWidth: true
                  text: modelData.label
                  color: Theme.surfaceText
                  font.pixelSize: Theme.fontSizeMedium
                  elide: Text.ElideRight
                }

                DankIcon {
                  name: modelData.submenu ? (menuItemColumn.submenuOpen ? "expand_more" : "chevron_right") : ""
                  color: Theme.surfaceVariantText
                  size: Theme.iconSizeSmall
                  visible: modelData.submenu !== undefined
                }
              }

              MouseArea {
                id: mainItemMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                  if (!modelData.submenu) {
                    pluginRoot.executeCommand(modelData.command, modelData.args);
                    popoutRoot.closePopout();
                  } else {
                    // Accordion behavior: toggle current, close others
                    pluginRoot.openSubmenuIndex = (pluginRoot.openSubmenuIndex === itemIndex) ? -1 : itemIndex;
                  }
                }
              }
            }

            // Submenu items
            Column {
              width: parent.width
              spacing: Theme.spacingXS
              leftPadding: Theme.spacingL
              topPadding: Theme.spacingXS
              bottomPadding: Theme.spacingXS
              visible: menuItemColumn.submenuOpen && modelData.submenu
              opacity: visible ? 1 : 0
              height: visible ? implicitHeight : 0
              clip: true

              Behavior on height {
                NumberAnimation {
                  duration: 200
                  easing.type: Easing.InOutQuad
                }
              }

              Behavior on opacity {
                NumberAnimation {
                  duration: 150
                }
              }

              Repeater {
                model: modelData.submenu ? modelData.submenu : []

                StyledRect {
                  width: parent.width - Theme.spacingL
                  height: 38
                  color: subMouseArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                  radius: Theme.cornerRadius
                  border.width: 0

                  StyledText {
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.spacingM
                    anchors.verticalCenter: parent.verticalCenter
                    text: modelData.label
                    color: Theme.surfaceVariantText
                    font.pixelSize: Theme.fontSizeSmall
                  }

                  MouseArea {
                    id: subMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                      pluginRoot.executeCommand(modelData.command, modelData.args);
                      popoutRoot.closePopout();
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
