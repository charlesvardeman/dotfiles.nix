{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "cvardema";
  home.homeDirectory = "/Users/cvardema";

# Packages to install
  home.packages = with pkgs; [
    universal-ctags
    curl
    wget
    httpie 
    ] ++ lib.optionals stdenv.isDarwin [
      m-cli
  ];
  
    home.sessionVariables = {
    PAGER = "less";
    EDITOR = "vim";
    PATH =
      "/nix/var/nix/profiles/default/bin:/usr/local/go/bin:$HOME/.nix-profile/bin:$HOME/go/bin:$PATH";
    GOPATH = "$HOME/go";
    NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    MANPAGER = "less -s -M +Gg";
  };

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
      userEmail = "charles.vardeman@gmail.com";

      extraConfig = {
        init.defaultBranch = "master";
        push.autoSetupRemote = true;
        color.ui = "true";
      };
    };

    fzf.enable = true;
    exa.enable = true;
    jq.enable = true;
    
    ## Starship Prompt Configuration
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      settings = { add_newline = false; };
    };

    ## Direnv Configuration
    direnv = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    ## VIM Congiguration
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-sensible
        vim-dispatch
        vim-eunuch
        vim-fugitive
        vim-surround
        vim-indentwise
        ];
      settings = {ignorecase = false;};
    };
    
    ## Tmux Configuration
    tmux = {
    enable = true;
    sensibleOnTop = true;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = true;
    terminal = "screen-256color";
    prefix = "C-a";
    historyLimit = 5000;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
       yank
        ];

  };

  ## Common prompt configuration


   ## Bash Configuration
    bash = {
    enable = true;
    shellAliases = {
      du = "du -h";
      df = "df -h";
      ls = "${pkgs.exa}/bin/exa";
      ll = "ls -al";
    };
    profileExtra = ''
      # Source default profile
      if [ -f /etc/profile ] ; then
        . /etc/profile
      fi
    '';
    initExtra = ''
      # Get home-manager working
      export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      # Taken from https://metaredux.com/posts/2020/07/07/supercharge-your-bash-history.html
      # don't put duplicate lines or lines starting with space in the history.
      # See bash(1) for more options
      HISTCONTROL=ignoreboth
      # append to the history file, don't overwrite it
      shopt -s histappend
      # append and reload the history after each command
      PROMPT_COMMAND="history -a; history -n"
      # ignore certain commands from the history
      HISTIGNORE="ls:ll:cd:pwd:bg:fg:history"
      # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
      HISTSIZE=100000
      HISTFILESIZE=10000000
    '';
  };

    ## ZSH Configuration
    zsh = {
      enable = true;
      autocd = true;
      shellAliases = {
        update-home = "$HOME/.config/nixpkgs/update.sh";
        ls = "${pkgs.exa}/bin/exa";
        ll = "ls -al";
        du = "du -h";
        df = "df -h";
      };
      defaultKeymap = "emacs";
      sessionVariables = {
        EDITOR = "${pkgs.helix}/bin/hx";
      };
      initExtra = ''
        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char
      '';
    };
  };
}