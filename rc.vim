colorscheme bored

set nu
set ic
set mouse=
set undofile
set showtabline=2
set laststatus=2
set ts=4
set sts=4
set sw=4
set expandtab
set signcolumn=yes
set termguicolors
set icm=nosplit " live preview
"set shortmess+=c
set exrc

map <C-c> <Esc>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType java,go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType lua setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml,json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sass,scss,html setlocal ts=2 sts=2 sw=2 expandtab

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
