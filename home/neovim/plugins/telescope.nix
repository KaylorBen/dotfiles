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
    };
  };
}
