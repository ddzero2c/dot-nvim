--local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local M = {}
local lsp = require 'lspconfig'

local function lsp_setup_signs()
    local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
    for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local function lsp_setup_diagnositc()
    vim.diagnostic.config {
        -- virtual_text = false,
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
end

local function lsp_format_autocmd(bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
        end
    })
end

local function lsp_diagnostic_floating_autocmd(bufnr)
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                source = 'always',
                scope = 'cursor',
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end

local function lsp_lightbulb_autocmd(bufnr)
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = function()
            require 'nvim-lightbulb'.update_lightbulb()
        end
    })
end

local function lsp_setup_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
        '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local function on_attach(client, bufnr)
    lsp_setup_keymaps(bufnr)
    -- lsp_diagnostic_floating_autocmd(bufnr)
    lsp_lightbulb_autocmd(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
-- Lua LSP --
-- brew install lua-language-server
-- :PlugInstall lua-language-server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT', path = runtime_path },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            telemetry = { enable = false },
        },
    },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
}

M.go_import = function()
    local clients = vim.lsp.buf_get_clients()
    for _, client in pairs(clients) do

        local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
        params.context = { only = { "source.organizeImports" } }

        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                else
                    vim.lsp.buf.execute_command(r.command)
                end
            end
        end
    end
end

-- Go LSP --
lsp.gopls.setup {
    cmd = {
        'gopls',
        '-remote=auto',
    },
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.go" },
            callback = function()
                M.go_import()
                vim.lsp.buf.formatting_sync()
            end
        })
    end,
    settings = {
        gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
        },
    },
}

require("typescript").setup({})

lsp.eslint.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.cmd [[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]]
    end,
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = 'all',
        },
    }
}

-- Python LSP --
lsp.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

lsp.solargraph.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- CSS LSP --
-- npm i -g vscode-langservers-extracted
lsp.cssls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lsp.jsonls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
        },
    },
}

lsp.yamlls.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = true
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
    settings = {
        yaml = {
            schemas = require('schemastore').json.schemas(),
        },
    },
}
-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Rust LSP --
-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
lsp.rust_analyzer.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
--require("rust-tools").setup({})

-- Solidity --
-- lsp.solc.setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }
-- lsp.solang.setup {
--     cmd = { "solang", "--language-server", "--target", "ewasm", "--importmap=@openzeppelin=node_modules/@openzeppelin" },
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }

lsp.solidity_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        solidity = {
            linter = 'solhint',
            editor = {
                formatOnSave = true,
            },
        }
    }
}

-- lsp.sqls.setup {
--     on_attach = function(client, bufnr)
--         require('sqls').on_attach(client, bufnr)
--     end
-- }

lsp.graphql.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
}
M.setup = function()
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    lsp_setup_signs()
    lsp_setup_diagnositc()
end

return M
