# TV Remote Navigation for Hyprland - Setup Complete! 🎮

## 🎯 What's Been Installed

### Scripts Created:
- `~/bin/cec-daemon` - HDMI-CEC remote control daemon
- `~/bin/cec-detect` - CEC detection and diagnostic tool  
- `~/bin/test-remote-nav` - Test basic navigation functionality
- `~/bin/tv-remote-setup` - Complete setup script
- `~/bin/input-monitor.sh` - Alternative input device monitor

### Configuration:
- Enhanced `~/.config/hypr/bindings.conf` with TV-friendly keybinds
- Added daemon options to `~/.config/hypr/autostart.conf`

## 🚀 Quick Start

### 1. Test Basic Navigation
```bash
~/bin/test-remote-nav
```

### 2. Check CEC Compatibility  
```bash
~/bin/cec-detect
```

### 3. Enable Remote Control
Edit `~/.config/hypr/autostart.conf` and uncomment one of:
- `exec-once = /home/sco/bin/cec-daemon` (for HDMI-CEC)
- `exec-once = DEVICE_NAME="your-device-id" /home/sco/bin/input-monitor.sh` (for USB/Bluetooth remotes)

## 📺 HDMI-CEC Setup Requirements

1. **Connect via HDMI** (not DisplayPort)
2. **Enable CEC on TV** (called: Anynet+, Bravia Sync, Viera Link, etc.)
3. **Direct connection** (no HDMI switches without CEC support)
4. **Restart** if changing HDMI connections

## 🎮 Navigation Controls

### Basic Navigation:
- **D-pad/Arrows** → Move window focus
- **OK/Enter** → Launch terminal (kitty)
- **Back/Escape** → Close window
- **Menu/Home** → Open Walker launcher

### Advanced Controls:
- **Channel Up/Down** → Switch workspaces
- **Number Keys** → Direct workspace access (1-9)
- **Volume Controls** → System volume (already configured)

## 🔧 Troubleshooting

### CEC Not Working:
1. Run `~/bin/cec-detect` to check compatibility
2. Ensure HDMI connection and TV CEC enabled
3. Try restarting the system
4. Consider alternative input methods below

### Alternative Options:
- **USB IR Receiver + Universal Remote** (requires `sudo pacman -S lirc`)
- **Bluetooth Remote/Game Controller** (may need `evtest` package)
- **Network Control** (Home Assistant, web interface)

## 📁 File Locations

```
~/bin/                     # TV remote scripts
├── cec-daemon            # HDMI-CEC daemon
├── cec-detect            # CEC detection tool
├── test-remote-nav        # Navigation test script
├── tv-remote-setup        # Complete setup script
└── input-monitor.sh      # Input device monitor

~/.config/hypr/
├── bindings.conf         # Enhanced with TV keybinds
└── autostart.conf        # Daemon startup options
```

## 🔄 Next Steps

1. **Test basic navigation** with `~/bin/test-remote-nav`
2. **Check CEC compatibility** with `~/bin/cec-detect`  
3. **Enable preferred daemon** in `autostart.conf`
4. **Restart Hyprland** to load autostart changes
5. **Test with your actual remote!**

Your Hyprland setup is now ready for TV-style navigation! 🎉

For issues or enhancements, check the log files:
- `/tmp/cec-daemon.log`
- `/tmp/input-monitor.log` 
- `/tmp/remote-test.log`