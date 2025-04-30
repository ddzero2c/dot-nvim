require('codecompanion').setup({
    strategies = {
        chat = {
            adapter = "copilot",
            keymaps = {
                send = { modes = { n = "<C-s>", i = "<C-s>" } },
                close = { modes = { n = "<C-x>", i = "<C-x>" } },
            },
        },
        cmd = { adapter = "copilot" },
        inline = {
            adapter = "copilot",
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
