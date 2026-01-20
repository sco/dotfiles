# sco's .dotfiles

This is my .dotfiles and standard home dir agent setup.

## Contents

- README.md - this file
- AGENT.md - advice for agents
- .bashrc - config


### dotfiles

This repo is meant for use with "dotfiles"(TODO link). To manage dotfiles, use commands like:

    dotfiles add ~/.zshrc ~/.config/nvim/init.lua
    dotfiles commit -m "Add shell and Neovim config"
    
To set up a new machine, install git and add your SSH key to Github. Then:

    git clone --bare git@github.com:sco/dotfiles.git ~/.dotfiles
    alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotfiles config --local status.showUntrackedFiles no
    dotfiles checkout


### connecting to other machines

    tailscale status
    ssh sco@raymond-maxi
    tmux attach -t default

- 
