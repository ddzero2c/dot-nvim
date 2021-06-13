local lsp_status = require('lsp-status')
lsp_status.register_progress()
local lspconfig = require('lspconfig')

-- key bindings
vim.cmd("nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> gR <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>")
vim.cmd("nnoremap <silent> ga <cmd>lua lua vim.lsp.buf.code_action()<CR>")
vim.cmd("nnoremap <silent> g= <cmd>lua vim.lsp.buf.formatting()<CR>")
vim.cmd("nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>")
vim.cmd("nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
vim.cmd("nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>")

vim.fn.sign_define(
	"LspDiagnosticsSignError",
	{texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"}
)
vim.fn.sign_define(
	"LspDiagnosticsSignWarning",
	{texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"}
)
vim.fn.sign_define(
	"LspDiagnosticsSignHint",
	{texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"}
	)
vim.fn.sign_define(
	"LspDiagnosticsSignInformation",
	{texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"}
	)

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = {
			prefix = "",
			spacing = 0,
		},
		signs = true,
		underline = true,
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
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		'documentation',
		'detail',
		'additionalTextEdits',
	}
}

-- lsp status
lsp_status.config({
	status_symbol = '',
	indicator_errors = '',
	indicator_warnings = '',
	indicator_info = '',
	indicator_hint = '',
	indicator_ok = '✔️',
	spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})
for _,v in pairs(capabilities) do table.insert(lsp_status.capabilities, v) end
vim.cmd([[
	function! LspStatus() abort
	  if luaeval('#vim.lsp.buf_get_clients() > 0')
		return luaeval("require('lsp-status').status()")
	  endif
	  return ''
	endfunction

	set statusline+=\ %{LspStatus()}
]])


local on_attach = function(client, bufnr)
	documentHighlight(client, bufnr)
	lsp_status.on_attach(client, bufnr)
end

local servers = { "gopls", "terraformls", "jsonls", "yamlls", "solargraph", "tsserver", "sumneko_lua" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup { on_attach = on_attach, capabilities = capabilities }
end

local sumneko_root_path = "/Users/ryder.hsu/dev/poc/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
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
        globals = {'vim'},
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
}

function go_organize_imports_sync(timeout_ms)
   vim.lsp.buf.formatting_sync(nil, 1000)

   local context = { source = { organizeImports = true } }
   vim.validate { context = { context, 't', true } }
   local params = vim.lsp.util.make_range_params()
   params.context = context

   local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
   if not result then return end
   result = result[1].result
   if not result then return end
   local edit = result[1].edit
   vim.lsp.util.apply_workspace_edit(edit)
end

--vim.cmd("autocmd BufWritePre *.go lua vim.lsp.buf.code_action({ source = { organizeImports = true } })")
vim.cmd("au BufWritePre *.go lua go_organize_imports_sync(1000)")
vim.cmd("au BufWritePre *.go lua vim.lsp.buf.formatting_sync()")
vim.cmd("au BufWritePre *.yaml lua vim.lsp.buf.formatting_sync()")
