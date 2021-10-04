local lsp = require("settings.lsp")
require("lspconfig").pyright.setup(lsp.ensure_capabilities({
	on_attach = require("settings.lsp").on_attach,
}))
