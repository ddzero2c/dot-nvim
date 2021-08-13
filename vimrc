call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rlue/vim-barbaric'
Plug 'editorconfig/editorconfig-vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug 'towolf/vim-helm'
Plug 'sbdchd/neoformat', { 'for': ['terraform', 'markdown', 'yaml', 'lua'] }

Plug 'lewis6991/gitsigns.nvim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install', 'for': ['markdown', 'vimwiki'] }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'hrsh7th/nvim-compe'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'https://github.com/sumneko/lua-language-server', {
            \ 'frozen': 1,
            \  'do': 'git submodule update --init --recursive &&
            \  cd 3rd/luamake &&
            \  compile/install.sh &&
            \  cd ../.. &&
            \  ./3rd/luamake/luamake rebuild'
            \  }

Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
call plug#end()

"colorscheme bored
colorscheme pinkfloyd
set background=light

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
set exrc
set diffopt+=algorithm:histogram,indent-heuristic

" system clipboard
set clipboard^=unnamed,unnamedplus

set hidden
set nobackup
set nowritebackup
set noswapfile
set cmdheight=1
set updatetime=300
set shortmess+=c

set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»

let g:mapleader = "\<Space>"
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

autocmd FileType sh setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType java,go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType vim,lua setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml,json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType helm,dockerfile,terraform,hcl setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css,sass,scss,html setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufRead,BufNewFile *.hcl set filetype=terraform

" json comment
autocmd FileType json syntax match Comment +\/\/.\+$+

" record cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" hightlight on yank
augroup LuaHighlight
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
