{pkgs, ...}:
{
  programs.nixvim.plugins.nvim-jdtls = {
    enable = true;
    cmd = [
      "${pkgs.jdt-language-server}/bin/jdtls"
      "-data" "/home/ben/Code/Mines/SoftwareEngineering-CSCI306/gradleProjects/Clue"
    ];
  };
}
