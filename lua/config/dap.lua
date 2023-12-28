local dap = require("dap")
local dapui = require("dapui")
local nnoremap = require("ddzero2c.keymap").nnoremap

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "ErrorMsg", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "ErrorMsg", linehl = "", numhl = "Error" })

dapui.setup({
    icons = { expanded = "▼", collapsed = "⏵", circular = "" },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                -- { id = "scopes", size = 0.25 },
                "scopes",
                "repl"
            },
            size = 12,
            position = "bottom",
        },
        {
            elements = {
                "stacks",
            },
            size = 40,
            position = "right",
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
    vim.cmd([[
        nnoremap <silent> c :lua require('dap').continue()<CR>
        nnoremap <silent> b :lua require('dap').toggle_breakpoint()<CR>
        nnoremap <silent> ; :lua require('dap').step_over()<CR>
        nnoremap <silent> i :lua require('dap').step_into()<CR>
        nnoremap <silent> o :lua require('dap').step_out()<CR>
        nnoremap <silent> p :lua require("dapui").eval()<CR>
    ]])
end

vim.keymap.set('n', '<F4>', function()
    vim.cmd([[
        unmap c
        unmap b
        unmap ;
        unmap i
        unmap o
        unmap p
    ]])
    dapui.close()
    dap.disconnect()
    dap.close()
end, { noremap = true })

dap.adapters.go = function(callback)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
        stdio = { nil, stdout },
        args = { "dap", "-l", "127.0.0.1:" .. port },
        detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
        stdout:close()
        handle:close()
        if code ~= 0 then
            print('dlv exited with code', code)
        end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
        assert(not err, err)
        if chunk then
            vim.schedule(function()
                require('dap.repl').append(chunk)
            end)
        end
    end)
    -- Wait for delve to start
    vim.defer_fn(
        function()
            callback({ type = "server", host = "127.0.0.1", port = port })
        end,
        100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "go",
        name = "debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "go",
        name = "debug test",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
    }
}

require("dap.ext.vscode").load_launchjs(nil, { go = { "go" } })
