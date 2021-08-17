require("lspconfig").solargraph.setup(coq.lsp_ensure_capabilities({
	on_attach = require("settings.lsp").on_attach,
}))
