vim.opt.number = -- set numbered lines
	not vim.g.started_by_firenvim
vim.opt.relativenumber = true -- set relative numbered lines

vim.opt.ignorecase = true -- ignore case in search patterns

vim.opt.undofile = true -- enable persistent undo

vim.opt.cursorline = true -- highlight the current line

vim.opt.wrap = false -- display lines as one long line

vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.tabstop = 2 -- insert 4 spaces for a tab
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each
-- indentation

vim.opt.splitright = true -- open new split windows to the right
vim.opt.splitbelow = true -- open new split windows below

vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it
-- would shift the text each time

vim.opt.title = not vim.g.started_by_firenvim
