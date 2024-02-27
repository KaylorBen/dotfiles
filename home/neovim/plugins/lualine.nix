{
  programs.nixvim.plugins = {
    lualine = {
      enable = true;
      ignoreFocus = [ "nvimtree" ];
      sectionSeparators.left = "";
      sectionSeparators.right = "";
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" "diff" "diagnostics" ];
        lualine_c = [ "filename" ];
#            lualine_x = [ "copilot" "encoding" "fileformat" "filetype" ];
        lualine_x = [ "encoding" "fileformat" "filetype" ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
      extensions = [ "quickfix" "man" "fugitive" ];
    };
  };
}
