# sco's dotfiles

Portable dotfiles using the bare git repo method. Works on Arch, NixOS, and anything with bash.

## Structure

```
.shell.common   # Portable config: PATH, aliases, prompt (sourced everywhere)
.shell.local    # Machine-specific overrides (not tracked, optional)
.bashrc         # Arch: sources .shell.common
.profile        # Arch: login shell, sources .bashrc
.gitconfig      # Git identity and preferences
bin/            # Scripts added to PATH
```

## Installation

### Any machine (Arch, Ubuntu, etc.)

```bash
git clone --bare git@github.com:sco/dotfiles.git ~/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

If checkout complains about existing files, back them up first:
```bash
mkdir -p ~/.dotfiles-backup
dotfiles checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/
dotfiles checkout
```

### NixOS with Home Manager

On NixOS, Home Manager owns `.bashrc` and `.profile`. Instead of checking those out, configure Home Manager to source `.shell.common`:

1. Clone the bare repo (same as above):
   ```bash
   git clone --bare git@github.com:sco/dotfiles.git ~/.dotfiles
   alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
   dotfiles config --local status.showUntrackedFiles no
   ```

2. Checkout only non-conflicting files:
   ```bash
   dotfiles checkout .shell.common .gitconfig bin/
   ```

3. Configure `~/.config/home-manager/home.nix`:
   ```nix
   home.sessionVariables = {
     PATH = "$HOME/.npm-global/bin:$HOME/bin:$PATH";
   };

   programs.bash = {
     enable = true;
     initExtra = ''
       # Source portable dotfiles config
       [[ -f ~/.shell.common ]] && source ~/.shell.common
       
       # Auto-attach to tmux for SSH sessions
       if [[ -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
         tmux attach-session -t main || tmux new-session -s main
       fi
     '';
   };

   programs.tmux = {
     enable = true;
     # ... your tmux config
   };
   ```

4. Apply: `home-manager switch`

## Usage

```bash
# Add a file
dotfiles add ~/.config/something

# Commit
dotfiles commit -m "Add something config"

# Push
dotfiles push

# Pull on another machine
dotfiles pull
```

## Machine-local overrides

Create `~/.shell.local` for machine-specific config (not tracked):
```bash
# Example: machine-specific aliases or env vars
export EDITOR=nvim
alias proj='cd ~/work/myproject'
```

## SSH shortcuts

```bash
tailscale status        # See machines
ssh sco@raymond-maxi    # Or just: maxi (alias)
tmux attach -t main     # Attach to session
```

## Other setup

```bash
gh auth login           # GitHub CLI
```
