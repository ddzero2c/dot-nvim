--Border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local M = {}

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
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _)
	local config = { -- your config
		underline = true,
		virtual_text = true,
		signs = true,
		update_in_insert = false,
	}
	local uri = params.uri
	local bufnr = vim.uri_to_bufnr(uri)

	if not bufnr then
		return
	end

	local diagnostics = params.diagnostics

	for i, v in ipairs(diagnostics) do
		diagnostics[i].message = string.format("%s: %s", v.source, v.message)
	end

	vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

	if not vim.api.nvim_buf_is_loaded(bufnr) then
		return
	end

	vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end

-- symbols highlight
local function documentHighlight(client)
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
local snippet_capabilities = vim.lsp.protocol.make_client_capabilities()
snippet_capabilities.textDocument.completion.completionItem.snippetSupport = true
snippet_capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

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
	buf_set_keymap("n", "<C-p>", ":lua vim.lsp.diagnostic.goto_prev({focusable=false})<CR>", opts)
	buf_set_keymap("n", "<C-n>", ":lua vim.lsp.diagnostic.goto_next({focusable=false})<CR>", opts)
	--vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = Border })
	--vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = Border })
	--	vim.api.nvim_command([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
	--	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true })

	--vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
	documentHighlight(client)
	require("lsp_signature").on_attach({
		bind = true,
		handler_opts = {
			border = "none",
		},
		hint_enable = false,
		doc_lines = 0,
		max_height = 1,
		max_width = 140,
	})
end

M.ensure_capabilities = function(cfg)
	local spec1 = {
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	}
	local spec2 = {
		capabilities = {
			textDocument = {
				completion = {
					completionItem = {
						snippetSupport = true,
					},
				},
			},
		},
	}
	local maps = (cfg or {}).capabilities and { spec2 } or { spec1, spec2 }
	local new = vim.tbl_deep_extend("force", cfg or vim.empty_dict(), unpack(maps))
	return new
end

return M
