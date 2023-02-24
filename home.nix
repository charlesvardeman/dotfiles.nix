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
    micromamba
    ] ++ lib.optionals stdenv.isDarwin [
      m-cli
  ];
  
    home.sessionVariables = {
    PAGER = "less";
    EDITOR = "vim";
    PATH =
      "/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:$HOME/.nix-profile/bin:$HOME/go/bin:$PATH";
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
        grep="grep  --color=auto --exclude-dir={.git}";

        # Jupyter Aliases
        jl="jupyter lab --no-browser";
        jn="jupyter notebook --no-browser";
        ip="ipython --no-banner";
        nvi="nvidia-smi";
        nvdm="nvidia-smi dmon";
        pip-update="pip install --upgrade pip && pip freeze --local | grep -v \
  '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U";

      # Linked Data Aliases
        sparql="curl -H 'Accept: application/sparql-results+json' --data-urlencode query@- http://localhost:3030/ds/query";
        fuseki="java -jar /Users/cvardema/Downloads/apache-jena-fuseki-3.17.0/fuseki-server.jar";
        fuseki-start="java -jar /Users/cvardema/Downloads/apache-jena-fuseki-3.17.0/fuseki-server.jar --update --mem /ds";
        fuseki-stop="curl -X POST http://localhost:3030/$ds/update --data 'update=DROP ALL'";
        fuseki-kill="kill -9 $(lsof -t -i:3030)";
        fuseki-kill-all="kill -9 $(lsof -t -i:3030) $(lsof -t -i:3031)";

        curtle="curl -H 'Accept: text/turtle'";
        curltrig="curl -H 'Accept: application/trig'";
        curltriples="curl -H 'Accept: application/n-triples'";
        curlquads="curl -H 'Accept: application/n-quads'";
        curlson="curl -H 'Accept: application/json'";
        curld="curl -H 'Accept: application/ld+json'";

        # Docker Aliases
        d="docker";
        dc="docker-compose";

        # N-Triples aliases from http://blog.datagraph.org/2010/03/grepping-ntriples
        rdf-count="awk '/^\s*[^#]/ { n += 1 } END { print n }'";
        rdf-lengths="awk '/^\s*[^#]/ { print length }'";
        rdf-length-avg="awk '/^\s*[^#]/ { n += 1; s += length } END { print s/n }'";
        rdf-length-max="awk 'BEGIN { n=0 } /^\s*[^#]/ { if (length>n) n=length } END { print n }'";
        rdf-length-min="awk 'BEGIN { n=1e9 } /^\s*[^#]/ { if (length>0 && length<n) n=length } END { print (n<1e9 ? n : 0) }'";
        rdf-subjects="awk '/^\s*[^#]/ { print \$1 }' | uniq";
        rdf-predicates="awk '/^\s*[^#]/ { print \$2 }' | uniq";
        rdf-objects="awk '/^\s*[^#]/ { ORS=\"\"; for (i=3;i<=NF-1;i++) print \$i \" \"; print \"\n\" }' | uniq";
        rdf-datatypes="awk -F'\x5E' '/\"\^\^</ { print substr(\$3, 2, length(\$3)-4) }' | uniq";


      };
      defaultKeymap = "emacs";
      sessionVariables = {
        # EDITOR = "${pkgs.helix}/bin/hx";
        EDITOR = "${pkgs.vim}/bin/vim";
        VISUAL = "${pkgs.vim}/bin/vim";

      };
      initExtra = ''
        bindkey  "^[[H"   beginning-of-line
        bindkey  "^[[F"   end-of-line
        bindkey  "^[[3~"  delete-char
      '';
    };
  };
}
