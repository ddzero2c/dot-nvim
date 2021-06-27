vim.cmd("source ~/.config/nvim/vimrc")

require('settings.telescope')
require('settings.nvim-treesitter')
require('settings.gitsign')
require('settings.nvim-colorizer')
require('settings.indent-blankline')

require('settings.lsp')
require('settings.compe')
require("lspkind").init({with_text = false})
require('settings.lsp-sumneko_lua')
require('settings.lsp-gopls')
require('settings.lsp-tsserver')
