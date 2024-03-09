{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    environmentVariables = {
      MANROFFOPT = "-c";
      MANPAGER = "\"sh -c 'col -bx | bat -l man -p'\"";
      BAT_THEME = "gruvbox-dark";
    };
    shellAliases = {
      "l" = "ls -l";
      "la" = "ls -a";
      "lla" = "ls -la";
      "lt" = "lsd --tree";
      "lsa" = "ls -a";
    };
  };
}
