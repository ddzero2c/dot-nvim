local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
require("packer").startup({function(use)
  use "wbthomason/packer.nvim"

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'rlue/vim-barbaric'
  use 'editorconfig/editorconfig-vim'
  use 'AndrewRadev/tagalong.vim'

  -- LSP
  use { 'neovim/nvim-lspconfig',
    config = function()
      require('settings.lsp')
      require('settings.compe')
      require('settings.kind')
    end,
    requires = {
      'nvim-lua/lsp-status.nvim',
      'hrsh7th/nvim-compe',
      'onsails/lspkind-nvim',
    },
    ft = {'go', 'terraform', 'ruby', 'lua'}
  }

  use { 'neoclide/coc.nvim', branch = 'release',
    ft = {
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
      'html', 'css', 'scss', 'yaml', 'json', 'graphql',
    },
    config = function ()
      require("settings.coc")
    end
  }

  use { 'https://github.com/sumneko/lua-language-server', opt = true,
    run = [[
    git submodule update --init --recursive
    cd 3rd/luamake
    compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild
    ]]
  }

  use { 'fatih/vim-go', run = ':GoUpdateBinaries', ft = {'go'}, config = function()
    vim.g.go_code_completion_enabled = 0
    vim.g.go_gopls_enabled = 0
    vim.g.go_def_mapping_enabled = 0
    vim.g.go_doc_keywordprg_enabled = 0
  end }

  -- Snippets
  use 'rafamadriz/friendly-snippets'
  use { 'hrsh7th/vim-vsnip', config = function()
    vim.cmd [[
    imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
    smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'

    ]]
  end }

  -- Formatter
  use { 'sbdchd/neoformat', ft = {
    'terraform',
  }}
  --use 'lukas-reineke/format.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/playground'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use 'sheerun/vim-polyglot'
  use 'ntpeters/vim-better-whitespace'

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = {
    'nvim-lua/popup.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-media-files.nvim',
    'kyazdani42/nvim-web-devicons',
    'ryanoasis/vim-devicons',
  }}

  -- Color
  use { 'norcalli/nvim-colorizer.lua', config = function()
    require "colorizer".setup(
      {"*"},
      {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
      }
    )
  end }

  -- Markdown
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install' }

  -- Git
  use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'f-person/git-blame.nvim'
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
