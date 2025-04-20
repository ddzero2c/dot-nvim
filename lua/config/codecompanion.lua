require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = "anthropic",
            keymaps = {
                send = { modes = { n = "<C-s>", i = "<C-s>" } },
                close = { modes = { n = "<C-c>", i = "<C-c>" } },
            },
        },
        cmd = { adapter = "anthropic" },
        inline = {
            adapter = "anthropic",
            keymaps = {
                accept_change = {
                    modes = { n = "ga" },
                    description = "Accept the suggested change",
                },
                reject_change = {
                    modes = { n = "gr" },
                    description = "Reject the suggested change",
                },
            },
        },
    },
})
vim.cmd.ca('cc', 'CodeCompanion')
vim.cmd.ca('ccc', 'CodeCompanionChat')
