{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      ensureInstalled = [
        "nix"
        "zig"
        "java"
      ];
      indent = true;
    };
    treesitter-refactor = {
      enable = true;
      highlightCurrentScope.enable = false;
      highlightDefinitions.enable = true;
      smartRename = {
        enable = true;
        keymaps.smartRename = "grR";
      };
    };
  };
}
