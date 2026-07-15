{ config, ... }:

{
  home.file.".openclaw/workspace/medina".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/medina";
  home.file.".openclaw/workspace/dotfiles".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles";
  home.file.".openclaw/workspace/yoga-practice-app".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/yoga-practice-app";
}
