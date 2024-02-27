{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      ensureInstalled = [
        "nix"
      ];
      indent = true;
    };
    treesitter-refactor = {
      enable = true;
      highlightingCurrentScope.enable = true;
      highlightDefinitions.enable = true;
      smartRename = {
        enable = true;
        keymaps.smartRename = "grR";
      };
    };
  };
}
