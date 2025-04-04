-- vim.o.pumblend = 5
-- vim.o.spell = true
-- vim.o.spelloptions = "camel"
vim.o.winborder = 'single'
vim.o.synmaxcol = 200
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.mouse = "n"
vim.o.undofile = true
-- vim.o.winbar = "%f" vim.o.showtabline = 2
vim.o.autoread = true
vim.o.laststatus = 3
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.signcolumn = "yes"
vim.o.inccommand = "nosplit"
vim.o.exrc = true
vim.o.diffopt = vim.o.diffopt .. ",algorithm:histogram,indent-heuristic"
vim.o.clipboard = "unnamed,unnamedplus"
vim.o.hidden = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.cmdheight = 1
vim.o.updatetime = 50
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.fillchars = "eob: ,foldopen:▼,foldclose:⏵"
vim.g.omni_sql_no_default_maps = 1
