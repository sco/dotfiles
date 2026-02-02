# ~/.bashrc - Arch Linux
# For NixOS, Home Manager owns .bashrc and sources .shell.common directly

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Load portable config
[[ -f ~/.shell.common ]] && source ~/.shell.common

# Arch-specific: bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Auto-attach to tmux for SSH sessions
if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]] && command -v tmux &>/dev/null; then
    tmux new-session -A -s main
fi
