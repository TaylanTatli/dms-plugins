# Grimblast Plugin

Quick screenshot menu for DankMaterialShell using grimblast (Hyprland).

![Grimblast preview](screenshot.png)

## Features

- 🖼️ **Multiple Capture Modes**: Area, Active Window, Current Output, All Screens
- 📋 **Flexible Actions**: Copy to Clipboard, Save to File, Copy & Save, Edit
- ⚙️ **Configurable**: Set custom save location
- 🎯 **Easy Access**: Click bar icon to open screenshot menu
- 🎨 **Smooth UI**: Animated expandable submenus

## Requirements

- **Hyprland** - This plugin is designed for Hyprland
- **grimblast** - Screenshot tool for Hyprland/Wayland

  ```bash
  # Install on Arch Linux
  yay -S grimblast-git

  # Or install from AUR
  paru -S grimblast-git
  ```

## Installation

1. Copy plugin to DMS plugins directory:

   ```bash
   mkdir -p ~/.config/DankMaterialShell/plugins
   cp -r grimblast ~/.config/DankMaterialShell/plugins/
   ```

2. Reload DankMaterialShell or restart Quickshell

3. Enable the plugin in DMS Settings → Plugins

4. Add grimblast to DankBar

## Usage

### Taking Screenshots

1. Click the screenshot icon in the DankBar
2. Select an action (Copy, Save, Copy & Save, or Edit)
3. Choose a target:
   - **Area**: Select region with cursor
   - **Active Window**: Capture current window
   - **Current Output**: Capture current monitor
   - **All Screens**: Capture all monitors

### Configuration

Open DMS Settings → Plugins → Grimblast to configure:

- **Save Location**: Default directory for saved screenshots
  - Default: `~/Pictures/Screenshots`
  - Examples: `~/Pictures/Screenshots`, `~/Documents`, `/tmp`

## Actions Explained

| Action                | Description                                     |
| --------------------- | ----------------------------------------------- |
| **Copy to Clipboard** | Screenshot copied to clipboard (paste anywhere) |
| **Save to File**      | Screenshot saved to configured directory        |
| **Copy & Save**       | Both copy to clipboard AND save to file         |
| **Edit Screenshot**   | Open screenshot in default image editor         |

## Troubleshooting

**Screenshot fails with error code**

- Make sure `grimblast` is installed: `which grimblast`
- Check grimblast works: `grimblast save area /tmp/test.png`

**Plugin doesn't appear in bar**

- Enable plugin in DMS Settings → Plugins
- Add to DankBar widgets section in settings
- Restart Quickshell if needed

**Save location doesn't work**

- Ensure directory exists: `mkdir -p ~/Pictures/Screenshots`
- Use absolute paths or `~` for home directory
- Check directory permissions

## License

MIT License - Feel free to modify and distribute

## Author

Taylan TATLI

## Version

1.0.0 - Initial release
