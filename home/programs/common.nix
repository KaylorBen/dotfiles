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
    zathura # pdf viewer
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
