require("lspconfig").gopls.setup(coq.lsp_ensure_capabilities({
	on_attach = require("settings.lsp").on_attach,
	cmd = {
		"gopls", -- share the gopls instance if there is one already
		"-remote=auto", --[[ debug options ]] --
		"-remote.debug=:0",
	},
	flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			codelenses = {
				test = true,
				tidy = true,
				vendor = true,
				upgrade_dependency = true,
				generate = true,
				gc_details = true,
			},
			completeUnimported = true,
			staticcheck = true,
			usePlaceholders = true,
			matcher = "fuzzy",
			symbolMatcher = "fuzzy",
			experimentalWatchedFileDelay = "100ms",
			diagnosticsDelay = "500ms",
		},
	},
}))

require("go").setup({
	goimport = "gopls",
	gofmt = "gopls",
	dap_debug = true,
	dap_debug_gui = true,
	dap_debug_vt = false,
})
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
