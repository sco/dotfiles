source ~/.bash/aliases
source ~/.bash/completions
source ~/.bash/paths
source ~/.bash/config
source ~/.dotfiles/bin/git-completion.sh

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
  

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
