call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" lsp & language
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/go.nvim'
"Plug 'simrat39/rust-tools.nvim'
" Plug 'tomlion/vim-solidity'
Plug 'towolf/vim-helm'
Plug 'b0o/schemastore.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
" Plug 'nanotee/sqls.nvim'
" Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'sbdchd/neoformat'
Plug 'mfussenegger/nvim-lint'
Plug 'mhartington/formatter.nvim'

Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'RRethy/vim-illuminate'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
" Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'

let g:copilot_no_tab_map = v:true
Plug 'github/copilot.vim'
imap <silent><script><expr> <C-Y> copilot#Accept("\<CR>")

" debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" sql
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Plug 'rlue/vim-barbaric'
Plug 'lewis6991/gitsigns.nvim'

" treesitter & syntax
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-treesitter/playground'
Plug 'lukas-reineke/indent-blankline.nvim'

" fuzzy searcher
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" operation
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'wellle/targets.vim'
" Plug 'AndrewRadev/sideways.vim'

Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
"Plug 'dhruvasagar/vim-table-mode', { 'ft': ['mardown']}
Plug 'windwp/nvim-ts-autotag'
" Plug 'windwp/nvim-autopairs'

Plug 'folke/todo-comments.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'chentoast/marks.nvim'
" Plug 'folke/which-key.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }

" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install', 'for': ['markdown', 'vimwiki'] }

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Plug 'NTBBloodbath/galaxyline.nvim'
" Plug 'j-hui/fidget.nvim'
" Plug 'yfiua/tabline.vim'
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

colorscheme white
set background=light
" set pumblend=10

set nu
set ic
set nowrap
set mouse=n
set undofile
set stal=2
set ls=3
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
set updatetime=250
set shortmess+=c

" set list
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:↲,precedes:«,extends:»

let g:mapleader = "\<Space>"
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
nnoremap <C-s>s :w<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>S :wa<cr>
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt

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

" luatree
nnoremap <leader>t :NvimTreeToggle<CR>

" fzf
" let g:fzf_preview_window = []
" let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
" nnoremap <leader>p :Files<cr>
" nnoremap <leader>g :Rg<cr>
" nnoremap <leader>G :Ag<cr>

" vim-easymotion
map  L <Plug>(easymotion-bd-f)
nmap L <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" nnoremap <c-h> :SidewaysJumpLeft<cr>
" nnoremap <c-l> :SidewaysJumpRight<cr>
