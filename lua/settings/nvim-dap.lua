local dap = require("dap")
dap.adapters.go = function(callback, config)
	local handle
	local pid_or_err
	local port = 38697
	handle, pid_or_err = vim.loop.spawn("dlv", {
		args = { "dap", "-l", "127.0.0.1:" .. port },
		detached = true,
	}, function(code)
		handle:close()
		print("Delve exited with exit code: " .. code)
	end)
	-- Wait 100ms for delve to start
	vim.defer_fn(function()
		--dap.repl.open()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)

	--callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = ".",
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "Cursor", numhl = "" })

vim.cmd([[
nnoremap <silent> <F4> :lua require'dap'.stop()<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F8> :lua require("dapui").toggle()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
]])

require("dapui").setup({
	icons = {
		expanded = "▼",
		collapsed = "▶",
	},
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
	},
	sidebar = {
		open_on_start = true,
		elements = {
			-- You can change the order of elements in the sidebar
			"scopes",
			"stacks",
		},
		width = 40,
		position = "right", -- Can be "left" or "right"
	},
	tray = {
		open_on_start = true,
		elements = {
			"watches",
		},
		height = 5,
		position = "bottom", -- Can be "bottom" or "top"
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
	},
})
