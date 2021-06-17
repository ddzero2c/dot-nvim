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
nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
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


local on_attach_general = function(client)
	documentHighlight(client)
	lsp_status.on_attach(client)
end

local capabilities = vim.tbl_deep_extend('keep', lsp_status.capabilities, snippet_capabilities)
local servers = {
	"gopls",
	"terraformls",
	"jsonls",
	"yamlls",
	"solargraph",
}
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach_general,
		capabilities = capabilities
	}
end

-- sumneko_lua --
local sumneko_root_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
  on_attach = on_attach_general,
  capabilities = capabilities,
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

-- tsserver --
local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

lspconfig.tsserver.setup {
  on_attach = function(client)
    if client.config.flags then
      client.config.flags.allow_incremental_sync = true
    end
    client.resolved_capabilities.document_formatting = false
    on_attach_general(client)
  end,
  capabilities = capabilities
}

lspconfig.efm.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    on_attach_general(client, bufnr)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      javascript = {eslint},
      javascriptreact = {eslint},
      ["javascript.jsx"] = {eslint},
      typescript = {eslint},
      ["typescript.tsx"] = {eslint},
      typescriptreact = {eslint}
    }
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
}

