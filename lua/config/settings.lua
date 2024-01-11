vim.o.pumblend = 5
vim.o.spell = true
vim.o.spelloptions = "camel"
vim.o.synmaxcol = 200
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.wrap = false
vim.o.mouse = "n"
vim.o.undofile = true
-- vim.o.winbar = "%f"
vim.o.showtabline = 2
vim.o.laststatus = 0
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
vim.o.updatetime = 25
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.fillchars = "eob: ,foldopen:▼,foldclose:⏵"
vim.g.omni_sql_no_default_maps = 1

-- Mappings
vim.g.mapleader = " "
vim.keymap.set('n', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', '<leader>t', '<C-w>v:Ex<CR>')

vim.cmd [[
" filetypes
autocmd FileType sh setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType java,go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType vim,lua setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact,graphql setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml,json,sql setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType helm,dockerfile,terraform,hcl setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css,sass,scss,html setlocal ts=2 sts=2 sw=2 expandtab

"Record cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
