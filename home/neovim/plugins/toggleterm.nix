{
  programs.nixvim.plugins.toggleterm = {
    enable = true;
    openMapping = "<c-\\>";
    hideNumbers = true;
    shadeTerminals = true;
    shadingFactor = 2;
    persistSize = false;
    direction = "float";
    floatOpts = {
      border = "single";
      winblend = 0;
    };
    winbar = {
      enabled = true;
      nameFormatter = "function(term) return term.count end ";
    };
  };
}
