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
    rtorrent.enable = true; #cli torrent client
  };

  home.packages = with pkgs; [
    fastfetch # neofetch but faster since it's written in C

    # archiving
    unzip
    xz
    unzip
    p7zip

    # utils
    lsd # ls deluxe, a modern replacement for ls
    vivid # LS_COLORS generator
    ripgrep # recursive grep
    fzf # cli fuzzy finder
    qbittorrent-nox # torrent client
    python3 # python
    xdragon # simple drag-and-drop source/sink for X

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
