call plug#begin(stdpath('data') . '/plugged')
    " General Plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'rlue/vim-barbaric'
    Plug 'liuchengxu/vim-which-key'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'dstein64/nvim-scrollview'

    " LSP
    "Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    "Plug 'honza/vim-snippets'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'mfussenegger/nvim-jdtls'
    Plug 'kabouzeid/nvim-lspinstall'

    " Snippets
    Plug 'hrsh7th/vim-vsnip'
    Plug 'cstrap/python-snippets'
    Plug 'ylcnfrht/vscode-python-snippet-pack'
    Plug 'xabikos/vscode-javascript'
    Plug 'golang/vscode-go'
    Plug 'andys8/vscode-jest-snippets'
    "Plug 'rust-lang/vscode-rust'

    " Formatter
    Plug 'sbdchd/neoformat'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Status Line
    Plug 'glepnir/galaxyline.nvim'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'

    " Explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " Color
    Plug 'ddzero2c/lumiere.vim'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'sheerun/vim-polyglot'
    Plug 'ntpeters/vim-better-whitespace'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

    " Git
    Plug 'lewis6991/gitsigns.nvim' ", requires = {'nvim-lua/plenary.nvim'}
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'f-person/git-blame.nvim'

    " Easily Create Gists
    Plug 'mattn/vim-gist'
    Plug 'mattn/webapi-vim'

    " Chinese Input Source Switching
    Plug 'rlue/vim-barbaric'
call plug#end()
