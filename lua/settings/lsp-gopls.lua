local lsp = require("settings.lsp")
require("lspconfig").gopls.setup(lsp.ensure_capabilities({
	on_attach = lsp.on_attach,
	cmd = {
		"gopls", -- share the gopls instance if there is one already
		"-remote.debug=:0",
	},
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
			-- not supported
			analyses = { unusedparams = true, unreachable = false },
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
		},
	},
}))

require("go").setup({
	goimport = "gopls",
	gofmt = "gopls",
	dap_debug = false,
	dap_debug_gui = false,
	dap_debug_vt = false,
})
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
