{
  programs.nixvim.plugins = {
    nvim-tree = {
      enable = true;
      disableNetrw = false;
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
