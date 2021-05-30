call plug#begin(stdpath('data') . '/plugged')
    " General Plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'rlue/vim-barbaric'
    Plug 'liuchengxu/vim-which-key'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'dstein64/nvim-scrollview'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'AndrewRadev/tagalong.vim'
    Plug 'junegunn/vim-easy-align'

    " LSP
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'honza/vim-snippets'
    Plug 'hashivim/vim-terraform'
    let g:terraform_align=1
    let g:terraform_fmt_on_save=1

    "Plug 'fatih/vim-go'
    "let g:go_doc_popup_window = 1

    "Plug 'neovim/nvim-lspconfig'
    "Plug 'hrsh7th/nvim-compe'
    "Plug 'glepnir/lspsaga.nvim'
    "Plug 'onsails/lspkind-nvim'
    "Plug 'mfussenegger/nvim-jdtls'
    "Plug 'kabouzeid/nvim-lspinstall'

    " Snippets
    "Plug 'hrsh7th/vim-vsnip'
    Plug 'cstrap/python-snippets'
    Plug 'ylcnfrht/vscode-python-snippet-pack'
    Plug 'xabikos/vscode-javascript'
    Plug 'golang/vscode-go'
    Plug 'andys8/vscode-jest-snippets'
    "Plug 'rust-lang/vscode-rust'

    " Formatter
    "Plug 'sbdchd/neoformat'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/playground'
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Status Line
    "Plug 'glepnir/galaxyline.nvim'
    "Plug 'liuchengxu/eleline.vim'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'

    " Explorer
    Plug 'kyazdani42/nvim-tree.lua'

    " Color
    "Plug 'ddzero2c/lumiere.vim'
    "Plug 'norcalli/nvim-colorizer.lua'
    Plug 'sheerun/vim-polyglot'
    Plug 'ntpeters/vim-better-whitespace'
    "Plug 'https://git.sr.ht/~romainl/vim-bruin'

    " Markdown
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

    " Git
    Plug 'lewis6991/gitsigns.nvim' ", requires = {'nvim-lua/plenary.nvim'}
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'f-person/git-blame.nvim'
call plug#end()
