require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = "copilot",
            keymaps = { close = { modes = { n = "<C-x>", i = "<C-x>", } } }
        },
        inline = { adapter = "copilot", },
        agent = { adapter = "copilot", },
    },
})
vim.api.nvim_set_keymap("v", "ga", "<cmd>'<,'>CodeCompanion<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ai", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.cmd.ca('cc', 'CodeCompanion')
