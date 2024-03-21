{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # gaming
    winetricks  # wine helper
    protontricks  # winetricks wrapper for proton
    discord # chat for gamers
    vesktop # alternate discord client
    stable.xivlauncher # ffxiv launcher
    ace-of-penguins # linux version of classic windows games
    airshipper  # Provides automatic updates for the voxel RPG Veloren
    angband # roguelike game
    sil # LOTR roguelike based on angband
    forge-mtg # magic the gathering client
    openmw  # open source morrowind engine
    openttd # open source transport tycoon
    pacvim  # vim mini game to learn vim
    rogue # the original roguelike
    prismlauncher # minecraft launcher
    jdk17   # java required for minecraft
    starsector  # space game
    stockfish # chess engine
    steamPackages.steamcmd # Steam command-line tools
  ];
}

