
local nvim_lsp = require("lspconfig")

-- enable null-ls integration (optional)
require("null-ls").setup {}

nvim_lsp.tsserver.setup {
  flags = require('settings.lsp').flags,
  capabilities = require('settings.lsp').capabilities,
  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false

    -- format on save
    vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()")
    local ts_utils = require("nvim-lsp-ts-utils")

    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,
      import_all_timeout = 5000, -- ms

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = true,

      -- formatting
      enable_formatting = true,
      formatter = "prettier",
      formatter_config_fallback = nil,

      -- parentheses completion
      complete_parens = false,
      signature_help_in_parens = true,

      -- update imports on file move
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      watch_dir = nil,
    }

    -- required to fix code action ranges
    ts_utils.setup_client(client)

    require('settings.lsp').on_attach(client, bufnr)
    -- no default maps, so you may want to define some here
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
  end
}
