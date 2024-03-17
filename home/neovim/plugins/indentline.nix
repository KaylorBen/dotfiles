{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    exclude = {
      filetypes = [
        "help"
        "startify"
        "dashboard"
        "lazy"
        "neogitstatus"
        "NvimTree"
        "Trouble"
        "text"
      ];
      buftypes = [
        "terminal"
        "nofile"
      ];
    };
    indent = {
      tabChar = [ "│" ];
    };
    whitespace.removeBlanklineTrail = false;
  };
}
