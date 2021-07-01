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
		},
	},
})

function goimports(wait_ms)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
	for _, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				vim.lsp.util.apply_workspace_edit(r.edit)
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

vim.cmd("autocmd BufWritePre *.go lua goimports(1000)")
vim.cmd("autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync()")
