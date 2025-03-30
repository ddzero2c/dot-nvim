local mini_df = require('mini.diff')
mini_df.setup()
vim.api.nvim_set_hl(0, 'MiniDiffOverAdd', { fg = 'none', bg = 'none' })
vim.api.nvim_set_hl(0, 'MiniDiffOverChange', { reverse = true })
vim.api.nvim_set_hl(0, 'MiniDiffOverDelete', { fg = 'Gray', strikethrough = true })
vim.api.nvim_set_hl(0, 'MiniDiffOverContext', { fg = 'Gray', strikethrough = true })

require('aider').setup({
    mode = 'inline',
    float_opts = {
        border = 'single',
    },
})

vim.keymap.set({ 'v', 'n' }, 'ga', ':AiderEdit<CR>', {
    silent = true,
    noremap = true,
    desc = 'Run Aider on selected text'
})

vim.keymap.set('n', '<leader>g', function()
    mini_df.toggle_overlay()
end, {
    silent = true,
    noremap = true,
    desc = 'Toggle git diff'
})
