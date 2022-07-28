local dap = require 'dap'
local dapui = require 'dapui'

-- GO --
dap.adapters.go = function(callback, config)
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
-- GO --

-- RUST --
dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/local/bin/lldb-vscode', -- adjust as needed
    name = 'lldb',
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
        runInTerminal = false,
    },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
-- RUST --

vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'ErrorMsg', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = 'ErrorMsg', linehl = '', numhl = 'Error' })

dapui.setup {
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 40, -- 40 columns
            position = "right",
        },
        {
            elements = {
                "repl",
                -- "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
}

function debugger_start()
    vim.cmd [[
    set mouse=a
    nnoremap <silent> c :lua require('dap').continue()<CR>
    nnoremap <silent> b :lua require('dap').toggle_breakpoint()<CR>
    nnoremap <silent> n :lua require('dap').step_over()<CR>
    nnoremap <silent> i :lua require('dap').step_into()<CR>
    nnoremap <silent> o :lua require('dap').step_out()<CR>
    nnoremap <silent> p :lua require("dapui").eval()<CR>
    ]]
    dap.continue()
    dapui.open()
end

function debugger_stop()
    dapui.close()
    dap.close()
    vim.cmd [[
    set mouse=
    unmap c
    unmap b
    unmap n
    unmap i
    unmap o
    unmap p
    ]]
end

vim.cmd [[
nnoremap <silent> <F5> :lua debugger_start()<CR>
nnoremap <silent> <F4> :lua debugger_stop()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
]]

require('dap.ext.vscode').load_launchjs(nil, { go = { 'go' } })
