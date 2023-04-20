call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" lsp & language
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'uga-rosa/cmp-dictionary'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'kosayoda/nvim-lightbulb'
Plug 'RRethy/vim-illuminate'
Plug 'simrat39/symbols-outline.nvim'

let g:copilot_no_tab_map = v:true
Plug 'github/copilot.vim'
imap <silent><script><expr> <C-Y> copilot#Accept("\<CR>")

Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

Plug 'b0o/schemastore.nvim'
Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'olexsmir/gopher.nvim'

" helpers
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'lewis6991/gitsigns.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'windwp/nvim-ts-autotag'
Plug 'folke/todo-comments.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" UI
" Plug 'rcarriga/nvim-notify'
" Plug 'MunifTanjim/nui.nvim'
" Plug 'folke/noice.nvim'
Plug 'kevinhwang91/nvim-ufo'
Plug 'kevinhwang91/promise-async'

" treesitter & syntax
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" fuzzy searcher
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" color
Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

" set guicursor=n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:hor20

colorscheme white
set background=light
set pumblend=5

set nu
set rnu
set ic
set nowrap
set mouse=n
set undofile
" set winbar=%f
set showtabline=2
set laststatus=0
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
set fillchars=eob:\ ,foldopen:▼,foldclose:⏵

let g:mapleader = "\<Space>"
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
nnoremap <leader>t <C-w>v:Ex<CR>

autocmd FileType sh setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType java,go setlocal ts=4 sts=4 sw=4 noexpandtab
autocmd FileType vim,lua setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType javascript,javascriptreact,typescript,typescriptreact,graphql setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml,json,sql setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType helm,dockerfile,terraform,hcl setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css,sass,scss,html setlocal ts=2 sts=2 sw=2 expandtab

" json comment
autocmd FileType json syntax match Comment +\/\/.\+$+

" record cursor
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" hightlight on yank
" augroup LuaHighlight
"     autocmd!
"     autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
" augroup END

let g:omni_sql_no_default_maps = 1
