vim.cmd('source ~/.config/nvim/plugins.vim')
require('global')
vim.cmd('source ~/.config/nvim/rc.vim')
vim.cmd('source ~/.config/nvim/coc.vim')

vim.cmd('source ~/.config/nvim/whichkey.vim')
require('plugin.colorscheme')
require('plugin.fuzzyfinder')
require('plugin.syntax')
require('plugin.indentline')
-- require('plugin.statusline')
require('plugin.gitsign')
require('plugin.colorizer')

-- require('plugin.formatter')
-- require('plugin.snippet')
-- require('plugin.compe')
-- require('plugin.kind')
--
---- require('lsp.install')
-- require('lsp')
-- require('lsp.ts')
-- require('lsp.efm')
-- require('lsp.lua')
-- require('lsp.yaml')
-- require('lsp.json')
-- require('lsp.virtual_text')
-- require('lsp.go')
-- require('lsp.python')
-- require('lsp.bash')
