-- vim.cmd [[packadd packer.nvim]]
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- General Plugins
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'rlue/vim-barbaric'
    use 'liuchengxu/vim-which-key'
    use 'MattesGroeger/vim-bookmarks'
    use { 'dstein64/nvim-scrollview', branch = 'main' }

    -- LSP
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Status Line and Bufferline
    use 'glepnir/galaxyline.nvim'

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Color
    use 'ddzero2c/lumiere.vim'
    use 'sheerun/vim-polyglot'
    use 'ntpeters/vim-better-whitespace'

    -- Markdown
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}

    -- Git
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Easily Create Gists
    use 'mattn/vim-gist'
    use 'mattn/webapi-vim'

    -- Chinese Input Source Switching
    use 'rlue/vim-barbaric'
end)
