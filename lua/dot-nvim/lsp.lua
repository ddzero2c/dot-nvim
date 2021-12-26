--local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local lsp = require 'lspconfig'
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local flag = { debounce_text_changes = 150 }

for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
	virtual_text = {
		source = 'always', -- Or "if_many"
	},
	float = {
		source = 'always', -- Or "if_many"
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = false,
}

local function on_attach_general(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'gy', ':lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
	--buf_set_keymap("n", "<C-k>", ":lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<leader>ac', ':lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '<leader>f', ':lua vim.lsp.buf.formatting()<CR>', opts)
	buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

	vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
	-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
	-- if client.resolved_capabilities.document_highlight then
	-- 	vim.cmd [[
	--        augroup lsp_document_highlight
	--            autocmd! * <buffer>
	--            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
	--            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
	--        augroup END
	--        ]]
	-- end
end

-- Lua LSP --
-- :PlugInstall lua-language-server
local sumneko_root_path = vim.fn.stdpath 'data' .. '/plugged/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin/macOS/lua-language-server'
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
lsp.sumneko_lua.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
	cmd = {
		sumneko_binary,
		'-E',
		sumneko_root_path .. '/main.lua',
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					'vim',
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- Go LSP --
lsp.gopls.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
	cmd = {
		'gopls', -- share the gopls instance if there is one already
		'-remote.debug=:0',
	},
	settings = {
		gopls = {
			analyses = { unusedparams = true },
			staticcheck = true,
		},
	},
}
require('go').setup {
	goimport = 'gopls',
	gofmt = 'gopls',
	dap_debug = false,
	dap_debug_gui = false,
	dap_debug_vt = false,
	lsp_on_attach = false,
	lsp_codelens = false,
}
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- Typescript & Javascript LSP --
-- npm install -g typescript typescript-language-server
lsp.tsserver.setup {
	flag = flag,
	capabilities = capabilities,
	-- Needed for inlayHints. Merge this table with your settings or copy
	-- it from the source if you want to add your own init_options.
	init_options = require('nvim-lsp-ts-utils').init_options,
	--
	on_attach = function(client, bufnr)
		on_attach_general(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		local ts_utils = require 'nvim-lsp-ts-utils'

		-- defaults
		ts_utils.setup {
			auto_inlay_hints = false,
			filter_out_diagnostics_by_severity = { 'hint' },
			update_imports_on_move = true,
			require_confirmation_on_move = true,
		}

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local opts = { silent = true }
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gS', ':TSLspImportAll<CR>', opts)
	end,
}

-- local null_ls = require 'null-ls'
-- null_ls.setup {
-- 	flag = flag,
-- 	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.formatting.prettier.with {
-- 			prefer_local = 'node_modules/.bin',
-- 			filetypes = {
-- 				'javascript',
-- 				'javascriptreact',
-- 				'typescript',
-- 				'typescriptreact',
-- 				'vue',
-- 				'css',
-- 				'scss',
-- 				'less',
-- 				'html',
-- 				'json',
-- 				'yaml',
-- 				'markdown',
-- 				'graphql',
-- 				'solidity',
-- 			},
-- 		},
-- 		null_ls.builtins.diagnostics.eslint,
-- 		null_ls.builtins.code_actions.eslint,
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		on_attach_general(client, bufnr)
-- 		vim.cmd 'autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()'
-- 	end,
-- }
lsp.eslint.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

-- Python LSP --
lsp.pyright.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

lsp.solargraph.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

-- CSS LSP --
-- npm i -g vscode-langservers-extracted
lsp.cssls.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}
lsp.jsonls.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach_general(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
	settings = {
		json = {
			schemas = require('schemastore').json.schemas(),
		},
	},
}
-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

-- Rust LSP --
-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
lsp.rust_analyzer.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}
--require("rust-tools").setup({})

-- Solidity --
lsp.solang.setup {
	-- cmd = {
	-- 	"solang",
	-- 	"--language-server",
	-- 	"--target",
	-- 	"ewasm",
	-- },
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

lsp.solidity_ls.setup {
	flag = flag,
	capabilities = capabilities,
	on_attach = on_attach_general,
}

vim.cmd(
	[[
let g:neoformat_try_node_exe = 1
augroup fmt
  autocmd!
  autocmd BufWritePre *.sol,*.lua,*.css,*.scss,*.js,*.jsx,*.ts,*.tsx undojoin | Neoformat
augroup END
]],
	true
)
