call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" lsp & language
Plug 'neovim/nvim-lspconfig'
Plug 'rcarriga/nvim-notify'
Plug 'ray-x/go.nvim'
"Plug 'simrat39/rust-tools.nvim'
Plug 'tomlion/vim-solidity'
Plug 'towolf/vim-helm'
Plug 'b0o/schemastore.nvim'
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

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-emoji'
Plug 'hrsh7th/cmp-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'ray-x/lsp_signature.nvim'

" snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'rlue/vim-barbaric'
Plug 'lewis6991/gitsigns.nvim'

" treesitter & syntax
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-treesitter/playground'
Plug 'simrat39/symbols-outline.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

" fuzzy searcher
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'

" operation
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
"Plug 'dhruvasagar/vim-table-mode', { 'ft': ['mardown']}
Plug 'AndrewRadev/tagalong.vim'
Plug 'windwp/nvim-ts-autotag'
Plug 'folke/todo-comments.nvim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'chentau/marks.nvim'
Plug 'folke/which-key.nvim'
Plug 'b3nj5m1n/kommentary'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install', 'for': ['markdown', 'vimwiki'] }

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'norcalli/nvim-colorizer.lua'

call plug#end()

"colorscheme bored
colorscheme single
set background=light
set pumblend=10

set nu
set ic
set nowrap
set mouse=
set undofile
set showtabline=2
set ls=1
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
map  s <Plug>(easymotion-bd-f)
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-table-mode
"let g:table_mode_corner='|'
"function! s:isAtStartOfLine(mapping)
"  let text_before_cursor = getline('.')[0 : col('.')-1]
"  let mapping_pattern = '\V' . escape(a:mapping, '\')
"  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
"  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
"endfunction
"
"inoreabbrev <expr> <bar><bar>
"          \ <SID>isAtStartOfLine('\|\|') ?
"          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
"inoreabbrev <expr> __
"          \ <SID>isAtStartOfLine('__') ?
"          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

" symbols-outline
nnoremap <silent> <leader>y :SymbolsOutline<CR>

