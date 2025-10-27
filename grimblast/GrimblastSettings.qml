import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
  pluginId: "grimblast"

  StyledText {
    width: parent.width
    text: "Grimblast Settings"
    font.pixelSize: Theme.fontSizeLarge
    font.weight: Font.Bold
    color: Theme.surfaceText
  }

  StyledText {
    width: parent.width
    text: "Configure grimblast screenshot tool settings"
    font.pixelSize: Theme.fontSizeSmall
    color: Theme.surfaceVariantText
    wrapMode: Text.WordWrap
  }

  StringSetting {
    settingKey: "saveLocation"
    label: "Save Location"
    description: "Default directory where screenshots will be saved"
    placeholder: "~/Pictures/Screenshots"
    defaultValue: "~/Pictures/Screenshots"
  }

  StyledText {
    width: parent.width
    text: "Examples: ~/Pictures/Screenshots, ~/Documents, /tmp"
    font.pixelSize: Theme.fontSizeSmall
    color: Theme.surfaceVariantText
    leftPadding: Theme.spacingM
  }

  Rectangle {
    width: parent.width
    height: 1
    color: Theme.outlineVariant
  }

  StyledText {
    width: parent.width
    text: "This plugin uses grimblast for screenshots. Make sure it's installed on your system."
    font.pixelSize: Theme.fontSizeSmall
    color: Theme.surfaceVariantText
    wrapMode: Text.WordWrap
  }
}
