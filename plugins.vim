call plug#begin(stdpath('data') . '/plugged')
    " General Plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'rlue/vim-barbaric'
    Plug 'liuchengxu/vim-which-key'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
    Plug 'honza/vim-snippets'

    " LSP
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'

    " Explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " Color
    Plug 'ddzero2c/lumiere.vim', { 'branch': 'main' }
    Plug 'sheerun/vim-polyglot'
    Plug 'ntpeters/vim-better-whitespace'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

    " Git
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'

    " Easily Create Gists
    Plug 'mattn/vim-gist'
    Plug 'mattn/webapi-vim'

    " Chinese Input Source Switching
    Plug 'rlue/vim-barbaric'
call plug#end()
