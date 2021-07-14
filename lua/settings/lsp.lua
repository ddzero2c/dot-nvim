local M = {}
local lsp_status = require("lsp-status")
lsp_status.register_progress()
local lspconfig = require("lspconfig")

local err_sign = ""
local warn_sign = ""
local hint_sign = ""
local info_sign = ""
local err_hl = "LspDiagnosticsSignError"
local warn_hl = "LspDiagnosticsSignWarning"
local hint_hl = "LspDiagnosticsSignHint"
local info_hl = "LspDiagnosticsSignInformation"
vim.fn.sign_define(err_hl, { texthl = err_hl, text = err_sign, numhl = err_hl })
vim.fn.sign_define(warn_hl, { texthl = warn_hl, text = warn_sign, numhl = warn_hl })
vim.fn.sign_define(hint_hl, { texthl = hint_hl, text = hint_sign, numhl = hint_hl })
vim.fn.sign_define(info_hl, { texthl = info_hl, text = info_sign, numhl = info_hl })

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
})

-- symbols highlight
local function documentHighlight(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.cmd(
			[[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]],
			false
		)
	end
end

-- snippet support
local snippet_capabilities = {
	textDocument = { completion = { completionItem = { snippetSupport = true } } },
}

-- lsp status
lsp_status.config({
	status_symbol = "",
	indicator_errors = err_sign,
	indicator_warnings = warn_sign,
	indicator_hint = hint_sign,
	indicator_info = info_sign,
	indicator_ok = "✔️",
	spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
})

M.on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ac", ":lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<C-l>", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<C-p>", ":lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<C-n>", ":lua vim.lsp.diagnostic.goto_next()<CR>", opts)

	documentHighlight(client, bufnr)
	lsp_status.on_attach(client, bufnr)
	require("lsp_signature").on_attach({
		floating_window = true,
	})
end

M.capabilities = vim.tbl_deep_extend("keep", lsp_status.capabilities, snippet_capabilities)
M.flags = {
	debounce_text_changes = 150,
}

return M
