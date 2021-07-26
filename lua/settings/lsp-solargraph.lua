require("lspconfig").solargraph.setup({
	flags = require("settings.lsp").flags,
	on_attach = require("settings.lsp").on_attach,
	capabilities = require("settings.lsp").capabilities,
})
