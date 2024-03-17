{pkgs, ...}:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with pkgs.tree-sitter-grammars; [
        tree-sitter-nu
      ];
      ensureInstalled = [
        "nix"
        "zig"
        "lua"
        "java"
      ];
      indent = true;
      nixvimInjections = true;
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
