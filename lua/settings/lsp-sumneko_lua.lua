local sumneko_root_path = vim.fn.stdpath("data") .. "/plugged/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').sumneko_lua.setup {
  flags = require('settings.lsp').flags,
  on_attach = require('settings.lsp').on_attach,
  capabilities = require('settings.lsp').capabilities,
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
