{ pkgs, ... }:
{
  programs = {
    btop = {  # top and htop alternative
      enable = true;
      settings = {
        color_theme = "nord";
        vim_keys = true;
      };
    };
    less.enable = true;
    bat = {
      enable = true;
      # themes = {
      #   gruvbox = {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "peaceant";
      #       repo = "gruvbox";
      #       rev = "e3db74d0e5de7bc09cab76377723ccf6bcc64e8c";
      #       hash = "sha256-gsk3qdx+OHMvaOVOlbTapqp8iakA350yWT9Jf08uGoU=";
      #     };
      #     file = "gruvbox.tmTheme";
      #   };
      # };
    };
    zathura = {
      enable = true;
      options = {
        notification-error-bg = "#282828"; # bg
        notification-error-fg = "#fb4934"; # bright:red
        notification-warning-bg = "#282828"; # bg
        notification-warning-fg = "#fabd2f"; # bright:yellow
        notification-bg = "#282828"; # bg
        notification-fg = "#b8bb26"; # bright:green

        completion-bg = "#504945"; # bg2
        completion-fg = "#ebdbb2"; # fg
        completion-group-bg = "#3c3836"; # bg1
        completion-group-fg = "#928374"; # gray
        completion-highlight-bg = "#83a598"; # bright:blue
        completion-highlight-fg = "#504945"; # bg2

        # Define the color in index mode
        index-bg = "#504945"; # bg2
        index-fg = "#ebdbb2"; # fg
        index-active-bg = "#83a598"; # bright:blue
        index-active-fg = "#504945"; # bg2

        inputbar-bg = "#282828"; # bg
        inputbar-fg = "#ebdbb2"; # fg

        statusbar-bg = "#504945"; # bg2
        statusbar-fg = "#ebdbb2"; # fg

        highlight-color = "#fabd2f"; # bright:yellow
        highlight-active-color = "#fe8019"; # bright:orange

        default-bg = "#282828"; # bg
        default-fg = "#ebdbb2"; # fg
        render-loading = true;
        render-loading-bg = "#282828"; # bg
        render-loading-fg = "#ebdbb2"; # fg

        # Recolor book content's color
        recolor-lightcolor = "#282828"; # bg
        recolor-darkcolor = "#ebdbb2"; # fg
        recolor = "true";
        # set recolor-keephue             true      # keep original color
      };
    };
    rtorrent.enable = true; #cli torrent client
  };

  home.packages = with pkgs; [
    fastfetch # neofetch but faster since it's written in C

    # archiving
    unzip
    xz
    unzip
    p7zip

    # wine
    wineWowPackages.stable

    # utils
    lsd # ls deluxe, a modern replacement for ls
    vivid # LS_COLORS generator
    ripgrep # recursive grep
    fzf # cli fuzzy finder
    qbittorrent-nox # torrent client
    python3 # python
    xdragon # simple drag-and-drop source/sink for X
    appimagekit # A tool to package desktop applications as AppImages
    libreoffice # GNU office

    # fun TUIs
    cowsay
    sl
    cbonsai
    steam-tui
    steamcmd
    among-sus
    todo
    cava
    lolcat

    # I want to uninstall these
    eclipses.eclipse-sdk
  ];
}
