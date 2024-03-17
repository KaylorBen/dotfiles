{
  programs.nixvim = {
    autoCmd = [
      {
        desc = "Sets the tabwidth to 4 when interacting with .java files";
        event = [ "BufNewFile" "BufRead" ];
        pattern = [ "*.java" ".c" ".cpp" ".h" ".py" ".rs" ".go" ".zig" ".s" ".sql" ];
        command = "<cmd>set tabstop=4<cr><cmd>set shiftwidth=4<cr>";
      }
    ];
  };
}
