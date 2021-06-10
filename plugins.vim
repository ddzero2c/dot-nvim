call plug#begin(stdpath('data') . '/plugged')
    " General Plugins
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'rlue/vim-barbaric'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'AndrewRadev/tagalong.vim'
    Plug 'junegunn/vim-easy-align'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    let g:go_doc_keywordprg_enabled = 0
    Plug 'hashivim/vim-terraform'
    let g:terraform_align=1
    let g:terraform_fmt_on_save=1

    " Snippets
    Plug 'hrsh7th/vim-vsnip'
    Plug 'rafamadriz/friendly-snippets'

    " Formatter
    "Plug 'sbdchd/neoformat'

    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/playground'
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }

    " Icons
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ryanoasis/vim-devicons'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-media-files.nvim'

    " Color
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
call plug#end()
