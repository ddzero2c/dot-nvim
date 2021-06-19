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
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'rlue/vim-barbaric'
  use 'editorconfig/editorconfig-vim'
  use 'AndrewRadev/tagalong.vim'
  use 'ntpeters/vim-better-whitespace'
  use 'sheerun/vim-polyglot'
  use 'f-person/git-blame.nvim'

  use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, config = [[require('settings.gitsign')]] }
  use { 'iamcco/markdown-preview.nvim', ft = {'markdown'}, run = 'cd app && npm install' }

  -- LSP
  local lsp_ft = {'go', 'terraform', 'ruby', 'lua', 'sh'}
  use { 'neovim/nvim-lspconfig',
    config = function()
      vim.cmd [[
      packadd lsp-status.nvim
      packadd trouble.nvim
      packadd nvim-compe
      packadd lspkind-nvim
      packadd friendly-snippets
      packadd vim-vsnip
      ]]
      require('settings.lsp')
      require("trouble").setup()
      require('settings.compe')
      require("lspkind").init({with_text = false})
      vim.cmd [[
      imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
      smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
      imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
      smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
      nnoremap <silent> <C-l> <cmd>TroubleToggle<cr>
      ]]
    end,
    requires = {
      { 'nvim-lua/lsp-status.nvim', ft = lsp_ft },
      { 'hrsh7th/nvim-compe' , ft = lsp_ft},
      { 'onsails/lspkind-nvim', ft = lsp_ft },
      { 'rafamadriz/friendly-snippets', ft = lsp_ft },
      { 'hrsh7th/vim-vsnip', ft = lsp_ft },
      { 'folke/trouble.nvim', ft = lsp_ft },
    },
    ft = lsp_ft,
  }

  use { 'neoclide/coc.nvim',
    branch = 'release',
    ft = {
      'javascript', 'javascriptreact', 'typescript', 'typescriptreact',
      'html', 'css', 'scss', 'yaml', 'json', 'graphql',
    },
    config = function ()
      require("settings.coc")
    end
  }

  use { 'https://github.com/sumneko/lua-language-server',
    opt = true,
    run = [[
    git submodule update --init --recursive
    cd 3rd/luamake
    compile/install.sh
    cd ../..
    ./3rd/luamake/luamake rebuild
    ]]
  }

  use { 'fatih/vim-go',
    run = ':GoUpdateBinaries',
    ft = {'go'},
    config = function()
      vim.g.go_code_completion_enabled = 0
      vim.g.go_gopls_enabled = 0
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_doc_keywordprg_enabled = 0
    end
  }

  -- Formatter
  use { 'sbdchd/neoformat',
    ft = { 'terraform', 'markdown' },
    config = function()
      vim.cmd[[
      augroup fmt
        autocmd!
        autocmd BufWritePre * silent! undojoin | silent! Neoformat
      augroup END
      ]]
    end
  }
  --use 'lukas-reineke/format.nvim'

  -- Treesitter
  use 'nvim-treesitter/playground'
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require "nvim-treesitter.configs".setup {
        ensure_installed = "maintained",
        ignore_install = { "haskell" },
        highlight = { enable = true }
      }
    end
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'kyazdani42/nvim-web-devicons',
      'ryanoasis/vim-devicons',
    },
    config = [[require('settings.telescope')]]
  }

  -- Color
  use { 'norcalli/nvim-colorizer.lua',
    config = function()
      require "colorizer".setup({"*"}, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end
  }

  -- Indentline
  use { 'lukas-reineke/indent-blankline.nvim',
    branch = 'lua',
    config = function()
      vim.g.indent_blankline_show_trailing_blankline_indent = false
    end
  }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
}})
