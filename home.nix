{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "cvardema";
  home.homeDirectory = "/Users/cvardema";

# Packages to install
  home.packages = with pkgs; [
    tmux
    vim
    jq
    universal-ctags
  ];
  
  # Set build manpages for false on afs due to time out issues
  manual.manpages.enable = false;
  programs = {
    git = {
      enable = true;
      lfs.enable = true;

      difftastic = {
        enable = true;
        background = "dark";
      };

      userName = "Charles Vardeman";
      userEmail = "cvardema@gmail.com";

      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
      };
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    
  };
}