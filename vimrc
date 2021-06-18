colorscheme bored

set nu rnu
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
set exrc

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c

let g:mapleader = "\<Space>"
inoremap <C-c> <Esc>
xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

autocmd FileType sh setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType java,go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType vim,lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml,json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType helm,dockerfile,terraform,hcl setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css,sass,scss,html setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufRead,BufNewFile *.hcl set filetype=terraform

" system clipboard
set clipboard^=unnamed,unnamedplus

" json comment
autocmd FileType json syntax match Comment +\/\/.\+$+

" record cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" hightlight on yank
augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
