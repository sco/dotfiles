# ~/.profile - Login shell config (Arch)
# For NixOS, Home Manager manages this via home.sessionVariables

# Source .bashrc for interactive bash login shells
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
