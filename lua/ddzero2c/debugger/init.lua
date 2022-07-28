local dap = require("dap")
local dapui = require("dapui")
local nnoremap = require("ddzero2c.keymap").nnoremap

vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = 'ErrorMsg', linehl = '', numhl = 'Error' })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dapui.setup {
    layouts = {
        {
            elements = {
                "console",
            },
            size = 7,
            position = "bottom",
        },
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "watches",
            },
            size = 60,
            position = "right",
        }
    },
}

require('dap.ext.vscode').load_launchjs(nil, { go = { 'go' } })
require("ddzero2c.debugger.go");

nnoremap("<leader><leader>", function()
    dapui.close()
    dap.disconnect()
    dap.close()
end)
nnoremap("<Up>", function()
    dap.continue()
end)
nnoremap("<Down>", function()
    dap.step_over()
end)
nnoremap("<Right>", function()
    dap.step_into()
end)
nnoremap("<Left>", function()
    dap.step_out()
end)
nnoremap("<Leader>b", function()
    dap.toggle_breakpoint()
end)
