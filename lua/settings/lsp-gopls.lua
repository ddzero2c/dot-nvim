local lsp = require("settings.lsp")
require("lspconfig").gopls.setup(lsp.ensure_capabilities({
	on_attach = lsp.on_attach,
	cmd = {
		"gopls", -- share the gopls instance if there is one already
		"-remote.debug=:0",
	},
	message_level = vim.lsp.protocol.MessageType.Error,
	flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
			-- not supported
			analyses = { unusedparams = true, unreachable = false },
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, --  // Show a code lens toggling the display of gc's choices.
				test = true,
				tidy = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			matcher = "fuzzy",
			-- experimentalDiagnosticsDelay = "500ms",
			diagnosticsDelay = "500ms",
			experimentalWatchedFileDelay = "100ms",
			symbolMatcher = "fuzzy",
			gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
			buildFlags = { "-tags", "integration" },
			-- buildFlags = {"-tags", "functional"}
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
vim.fn.sign_define("DapBreakpoint", { text = "•", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "→", texthl = "", linehl = "Cursor", numhl = "" })
