--local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local lsp = require("lspconfig")
local err_sign = ""
local warn_sign = ""
local hint_sign = ""
local info_sign = ""
local err_hl = "LspDiagnosticsSignError"
local warn_hl = "LspDiagnosticsSignWarning"
local hint_hl = "LspDiagnosticsSignHint"
local info_hl = "LspDiagnosticsSignInformation"
vim.fn.sign_define(err_hl, { texthl = err_hl, text = err_sign, numhl = err_hl })
vim.fn.sign_define(warn_hl, { texthl = warn_hl, text = warn_sign, numhl = warn_hl })
vim.fn.sign_define(hint_hl, { texthl = hint_hl, text = hint_sign, numhl = hint_hl })
vim.fn.sign_define(info_hl, { texthl = info_hl, text = info_sign, numhl = info_hl })

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, context, _)
	local config = { -- your config
		underline = true,
		virtual_text = true,
		signs = true,
		update_in_insert = false,
	}
	local uri = result.uri
	local bufnr = vim.uri_to_bufnr(uri)
	if not bufnr then
		return
	end

	local diagnostics = result.diagnostics
	for i, v in ipairs(diagnostics) do
		diagnostics[i].message = string.format("%s: %s", v.source, v.message)
	end

	local client_id = context.client_id
	vim.lsp.diagnostic.save(diagnostics, bufnr, client_id)

	if not vim.api.nvim_buf_is_loaded(bufnr) then
		return
	end

	vim.lsp.diagnostic.display(diagnostics, bufnr, client_id, config)
end

-- symbols highlight
local function lsp_highlight_document(client)
	if vim.lsp.document_highlight == false then
		return -- we don't need further
	end
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
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

local function on_attach(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gy", ":lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
	--buf_set_keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ac", ":lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<C-p>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<C-n>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	--vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	--vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
	--vim.api.nvim_command([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
	--vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true })

	--vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
	lsp_highlight_document(client)
end

--local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Lua LSP --
-- :PlugInstall lua-language-server
local sumneko_root_path = vim.fn.stdpath("data") .. "/plugged/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp.sumneko_lua.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		sumneko_binary,
		"-E",
		sumneko_root_path .. "/main.lua",
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Go LSP --
lsp.gopls.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"gopls", -- share the gopls instance if there is one already
		"-remote.debug=:0",
	},
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
			-- not supported
			analyses = { unusedparams = true },
			staticcheck = true,
		},
	},
})
require("go").setup({
	goimport = "gopls",
	gofmt = "gopls",
	dap_debug = false,
	dap_debug_gui = false,
	dap_debug_vt = false,
	lsp_on_attach = false,
	lsp_codelens = false,
})
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- Typescript & Javascript LSP --
-- npm install -g typescript typescript-language-server
-- enable null-ls integration (optional)
lsp.tsserver.setup({
	-- Needed for inlayHints. Merge this table with your settings or copy
	-- it from the source if you want to add your own init_options.
	init_options = require("nvim-lsp-ts-utils").init_options,
	--
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		vim.cmd("command -buffer Formatting lua vim.lsp.buf.formatting()")
		vim.cmd("command -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
		-- format on save
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			filter_out_diagnostics_by_severity = { "hint" },
			update_imports_on_move = true,
			require_confirmation_on_move = true,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)
	end,
})
local null_ls = require("null-ls")
null_ls.config({
	sources = {
		null_ls.builtins.diagnostics.eslint, -- eslint or eslint_d
		null_ls.builtins.code_actions.eslint, -- eslint or eslint_d
		null_ls.builtins.formatting.prettier, -- prettier, eslint, eslint_d, or prettierd
	},
})

require("lspconfig")["null-ls"].setup({})

-- Python LSP --
lsp.pyright.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})

lsp.solargraph.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})

-- CSS LSP --
-- npm i -g vscode-langservers-extracted
lsp.cssls.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})
lsp.jsonls.setup({
	-- capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})]])
	end,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
	commands = {
		Format = {
			function()
				vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
			end,
		},
	},
})
-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})

-- Rust LSP --
-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
lsp.rust_analyzer.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})
--require("rust-tools").setup({})

lsp.solang.setup({
	-- capabilities = capabilities,
	on_attach = on_attach,
})
