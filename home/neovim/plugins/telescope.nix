{
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      extensions.fzf-native = {
        enable = true;
        fuzzy = true;
        caseMode = "smart_case";
        overrideFileSorter = true;
        overrideGenericSorter = true;
      };
      keymaps = {
        "<esc>" = {
          action = "close";
          mode = "n";
        };
        "j" = {
          action = "move_selection_next";
          mode = "n";
        };
        "k" = {
          action = "move_selection_previous";
          mode = "n";
        };
        "<C-j>" = {
          action = "move_selection_next";
          mode = "i";
        };
        "<C-k>" = {
          action = "move_selection_previous";
          mode = "i";
        };
        "q" = {
          action = "close";
          mode = "n";
        };
      };
    };
  };
}
