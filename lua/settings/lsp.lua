local lsp_status = require("lsp-status")
lsp_status.register_progress()
local lspconfig = require("lspconfig")

-- key bindings
vim.cmd [[
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>a <cmd>lua lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
]]

local err_sign = ""
local warn_sign = ""
local hint_sign = ""
local info_sign = ""
local err_hl = 'LspDiagnosticsSignError'
local warn_hl = 'LspDiagnosticsSignWarning'
local hint_hl = 'LspDiagnosticsSignHint'
local info_hl = 'LspDiagnosticsSignInformation'
vim.fn.sign_define(err_hl, { texthl = err_hl, text = err_sign, numhl = err_hl })
vim.fn.sign_define(warn_hl, { texthl = warn_hl, text = warn_sign, numhl = warn_hl })
vim.fn.sign_define(hint_hl, { texthl = hint_hl, text = hint_sign, numhl = hint_hl })
vim.fn.sign_define(info_hl, { texthl = info_hl, text = info_sign, numhl = info_hl })

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		virtual_text = { prefix = "襁", spacing = 1 },
		signs = true,
		underline = true
	}
)

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
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}

-- lsp status
lsp_status.config({
  status_symbol = "",
  indicator_errors = err_sign,
  indicator_warnings = warn_sign,
  indicator_hint = hint_sign,
  indicator_info = info_sign,
  indicator_ok = "✔️",
  spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
})

vim.cmd [[
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction
set statusline+=\ %{LspStatus()}
]]


local on_attach = function(client, bufnr)
	documentHighlight(client, bufnr)
	lsp_status.on_attach(client, bufnr)
end

local capabilities = vim.tbl_deep_extend('keep', lsp_status.capabilities, snippet_capabilities)
local servers = {
	"gopls",
	"terraformls",
	"jsonls",
	"yamlls",
	"tsserver",
	"solargraph",
	"sumneko_lua"
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}
end

local sumneko_root_path = "/Users/ryder.hsu/dev/poc/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
	cmd = {
		sumneko_binary,
		"-E",
		sumneko_root_path .. "/main.lua"
	},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim"
				}
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true)
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false
			}
		}
	}
}

--function go_organize_imports_sync(timeout_ms)
--   vim.lsp.buf.formatting_sync(nil, 1000)
--
--   local context = { source = { organizeImports = true } }
--   vim.validate { context = { context, 't', true } }
--   local params = vim.lsp.util.make_range_params()
--   params.context = context
--
--   local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--   if not result then return end
--   result = result[1].result
--   if not result then return end
--   local edit = result[1].edit
--   vim.lsp.util.apply_workspace_edit(edit)
--end
--
----vim.cmd("autocmd BufWritePre *.go lua vim.lsp.buf.code_action({ source = { organizeImports = true } })")
--vim.cmd("au BufWritePre *.go lua go_organize_imports_sync(1000)")
--vim.cmd("au BufWritePre *.go lua vim.lsp.buf.formatting_sync()")
