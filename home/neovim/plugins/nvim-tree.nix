{
  programs.nixvim.plugins = {
    nvim-tree = {
      enable = true;
      view.relativenumber = true;
      renderer = {
        rootFolderLabel = ":t";
        indentMarkers = {
          enable = false;
          inlineArrows = true;
        };
      };
      updateFocusedFile = {
        enable = true;
        updateRoot = true;
      };
      diagnostics.enable = true;
    };
  };
}
