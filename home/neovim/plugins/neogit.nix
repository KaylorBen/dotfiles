{
  programs.nixvim.plugins.neogit = {
    enable = true;
    settings = {
      signs = {
        section = [ "" "" ];
        item = [ "" "" ];
        hunk = [ "" "" ];
      };
      integrations.diffview = true;
    };
  };
}
