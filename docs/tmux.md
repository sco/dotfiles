# Tmux Learning Guide for Arch Linux

## Overview
This guide helps you use tmux for persistent development sessions on your Arch Linux machine, accessible remotely from your laptop via Tailscale SSH.

## Quick Start Commands
```bash
# Create new session
tmux new -s my-experiment

# Attach to existing session
tmux attach -t default

# List all sessions
tmux ls

# Detach from session (keeps running)
Ctrl+b d

# Kill session
tmux kill-session -t my-experiment
```

## Remote Development Workflow

### 1. From Your Laptop
```bash
# Connect via Tailscale
ssh sco@raymond-maxi # or alias 'maxi'

# Once connected, attach to your session
tmux attach -t default
```

### 2. Work in Your Session
- Edit code, run commands, build packages
- Your work continues even if you disconnect
- Multiple windows/panes for different tasks

### 3. Safe Disconnect
- Press `Ctrl+b d` to detach
- Session keeps running in background
- Reconnect anytime with `tmux attach -t arch-dev`

## Essential tmux Commands

### Session Management
- `tmux new -s name` - Create new session
- `tmux attach -t name` - Attach to session
- `tmux ls` - List sessions
- `tmux kill-session -t name` - Kill session
- `Ctrl+b d` - Detach from current session

### Window Management
- `Ctrl+b c` - Create new window
- `Ctrl+b 0-9` - Switch to window by number
- `Ctrl+b n` - Next window
- `Ctrl+b p` - Previous window
- `Ctrl+b ,` - Rename window

### Pane Management
- `Ctrl+b |` - Split vertical
- `Ctrl+b -` - Split horizontal
- `Ctrl+b arrow keys` - Navigate panes
- `Ctrl+b x` - Close current pane
- `Ctrl+b z` - Zoom/unzoom current pane

### Copy/Paste (Vi mode)
- `Ctrl+b [` - Enter copy mode
- `v` - Start selection
- `y` - Copy selection
- `Ctrl+b ]` - Paste

## Development Layout Preset

Your config includes a development layout (`Ctrl+b D`):
- **Window 1**: Editor + file browser (vertical split)
- **Window 2**: Terminal + command output (horizontal split)
- **Window 3**: System monitoring (htop + package updates)

## Arch Linux Integration

### Package Management in tmux
```bash
# In dedicated pane/window
sudo pacman -Syu
yay -Syu
pacman -Qs package_name
```

### AUR Building
```bash
# Create separate window for AUR builds
# Use yay or makepkg in dedicated pane
# Monitor build progress while working elsewhere
```

### System Monitoring
```bash
# Built into development layout
htop                    # Process monitoring
watch -n 5 'pacman -Syup'  # Package updates
journalctl -f          # System logs
```

## Configuration Features

### Enabled in Your Config
- **Mouse support**: Click to select panes/windows
- **256 colors**: Proper terminal colors
- **Vi keybindings**: Familiar navigation
- **Custom status bar**: Nord theme with session info
- **Activity monitoring**: Visual alerts for background activity

### Custom Keybindings
- `Alt+Arrow keys`: Navigate panes without prefix
- `Ctrl+b |`: Vertical split (stays in current directory)
- `Ctrl+b -`: Horizontal split (stays in current directory)
- `Ctrl+b S`: Create new named session
- `Ctrl+b X`: Kill current session with confirmation

## Shell Aliases (Add to ~/.bashrc or ~/.zshrc)
```bash
# Quick tmux commands
alias tmux-dev='tmux new -s arch-dev'
alias tmux-attach='tmux attach -t arch-dev'
alias tmux-list='tmux ls'
alias tmux-kill='tmux kill-session -t arch-dev'

# Project-specific sessions
alias tmux-project='tmux new -s project-name'
alias tmux-monitor='tmux new -s monitor'
```

## Advanced Usage

### Session Persistence
- Sessions survive SSH disconnections
- Work continues across reboots (with proper setup)
- Multiple concurrent sessions for different projects

### Nested tmux
- If you SSH into a machine already running tmux:
- Use `Ctrl+b b` to send commands to inner tmux
- Or change prefix key in one instance

### Automation
```bash
# Auto-start tmux on SSH (add to ~/.bashrc)
if [ -n "$SSH_CLIENT" ] && [ -z "$TMUX" ]; then
    tmux attach -t arch-dev || tmux new -s arch-dev
fi
```

## Troubleshooting

### Common Issues
- **Colors not working**: Ensure `tmux-256color` terminal
- **Mouse not working**: Check `set -g mouse on` in config
- **Can't attach**: Session might be attached elsewhere, use `tmux attach -d -t session-name`

### Recovery Commands
```bash
# Kill all tmux sessions
tmux kill-server

# Force attach (detach other clients)
tmux attach -d -t session-name

# List all sessions including dead ones
tmux ls -a
```

## Best Practices

### Session Organization
- Use descriptive session names (`arch-dev`, `project-name`, `monitoring`)
- Create separate sessions for different projects
- Use window naming for clarity (`Ctrl+b ,`)

### Resource Management
- Limit session history: `set -g history-limit 10000`
- Close unused windows/panes
- Regular session cleanup

### Security
- Use SSH keys for Tailscale authentication
- Lock sessions when away: `Ctrl+b x`
- Monitor attached clients: `tmux list-clients`

## File Locations
- **Config**: `~/.config/tmux/tmux.conf`
- **Dev layout**: `~/.config/tmux/dev-layout.conf`
- **Sessions**: Stored in `/tmp/tmux-*` (temporary)

## Next Steps
1. Try the basic commands
2. Create your first development session
3. Test remote access from your laptop
4. Customize the layout for your workflow
5. Add project-specific aliases

Happy tmux-ing! 🚀
