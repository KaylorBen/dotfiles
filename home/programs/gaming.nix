{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # gaming
    steam
    winetricks  # wine helper
    protontricks  # winetricks wrapper for proton
    xivlauncher # ffxiv launcher
    airshipper  # Provides automatic updates for the voxel RPG Veloren
    openmw  # open source morrowind engine
    starsector  # space game
    stockfish # chess engine
    fflogs
    wowup
    gamemode
  ];
}

