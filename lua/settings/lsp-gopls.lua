require("lspconfig").gopls.setup({
	flags = require("settings.lsp").flags,
	on_attach = require("settings.lsp").on_attach,
	capabilities = require("settings.lsp").capabilities,
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			usePlaceholders = true,
		},
	},
})

require("go").setup({
	goimport = "gopls",
	gofmt = "gopls",
	dap_debug = true,
	dap_debug_gui = true,
	dap_debug_vt = false,
})
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "Cursor", numhl = "" })
