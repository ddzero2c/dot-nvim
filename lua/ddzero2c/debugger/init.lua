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
				"stacks",
			},
			size = 40,
			position = "right",
		},
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				-- { id = "scopes", size = 0.25 },
				"scopes",
			},
			size = 12,
			position = "bottom",
		},
	},
})

require("ddzero2c.debugger.go")
require("dap.ext.vscode").load_launchjs(nil, { go = { "go" } })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	vim.cmd([[
        nnoremap <silent> c :lua require('dap').continue()<CR>
        nnoremap <silent> b :lua require('dap').toggle_breakpoint()<CR>
        nnoremap <silent> n :lua require('dap').step_over()<CR>
        nnoremap <silent> i :lua require('dap').step_into()<CR>
        nnoremap <silent> o :lua require('dap').step_out()<CR>
        nnoremap <silent> p :lua require("dapui").eval()<CR>
    ]])
end

nnoremap("<F5>", function()
	dap.continue({})
end)
nnoremap("<F4>", function()
	vim.cmd([[
        unmap c
        unmap b
        unmap n
        unmap i
        unmap o
        unmap p
    ]])
	dapui.close()
	dap.disconnect()
	dap.close()
end)
nnoremap("<Leader>b", function()
	dap.toggle_breakpoint()
end)
