--local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local lsp = require("lspconfig")
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
	virtual_text = {
		source = "always", -- Or "if_many"
	},
	float = {
		source = "always", -- Or "if_many"
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
})

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])

local function on_attach_general(client, bufnr)
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
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	--vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
	--vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
	--vim.api.nvim_command([[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
	--vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>l", "<Cmd>lua vim.lsp.codelens.run()<CR>", { silent = true })

	--vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]])
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Lua LSP --
-- :PlugInstall lua-language-server
local sumneko_root_path = vim.fn.stdpath("data") .. "/plugged/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lsp.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
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
	capabilities = capabilities,
	on_attach = on_attach_general,
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
	capabilities = capabilities,
	-- Needed for inlayHints. Merge this table with your settings or copy
	-- it from the source if you want to add your own init_options.
	init_options = require("nvim-lsp-ts-utils").init_options,
	--
	on_attach = function(client, bufnr)
		on_attach_general(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require("nvim-lsp-ts-utils")

		-- defaults
		ts_utils.setup({
			auto_inlay_hints = false,
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

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.completion.spell,
	},
	on_attach = function(client, bufnr)
		on_attach_general(client, bufnr)
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end,
})

-- Python LSP --
lsp.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})

lsp.solargraph.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})

-- CSS LSP --
-- npm i -g vscode-langservers-extracted
lsp.cssls.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})
lsp.jsonls.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach_general(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})
-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})

-- Rust LSP --
-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
lsp.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})
--require("rust-tools").setup({})

lsp.solang.setup({
	capabilities = capabilities,
	on_attach = on_attach_general,
})
