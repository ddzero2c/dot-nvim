set nu
set ic
set ts=2
set sts=2
set sw=2
set mouse=a
set expandtab
set undofile
set showtabline=2
set signcolumn=yes
set termguicolors
set icm=nosplit " live preview
imap <C-c> <Esc>

" system clipboard
set clipboard+=unnamed

" json comment
autocmd FileType json syntax match Comment +\/\/.\+$+

" record cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" hightlight on yank
augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
