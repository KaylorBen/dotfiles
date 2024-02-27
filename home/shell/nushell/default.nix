{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    shellAliases = {
      "l" = "ls -l";
      "la" = "ls -a";
      "lla" = "ls -la";
      "lt" = "lsd --tree";
      "lsa" = "ls -a";
    };
  };
}
