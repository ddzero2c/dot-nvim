local M = {}
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
local lsp = require("lspconfig")

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
}

local function lsp_setup_signs()
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

local function lsp_setup_diagnositc()
    vim.diagnostic.config({
        virtual_text = { source = "always", },
        float = { source = "always", border = "single", focusable = false, },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
    })
end

local function lsp_format_autocmd(bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ timeout_ms = 3000 })
        end,
    })
end

local function lsp_setup_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "<leader>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
    )
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>sf', ':lua require("go-embedded-sql").format_sql_visual()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>sf', ':lua require("go-embedded-sql").format_sql()<CR>', opts)
end

local function lsp_setup_highlight(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = "lsp_document_highlight",
            desc = "Clear All the References",
        })
    end
end

local function on_attach(client, bufnr)
    lsp_setup_keymaps(bufnr)
    lsp_setup_highlight(client, bufnr)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
-- Lua LSP --
-- brew install lua-language-server
-- :PlugInstall lua-language-server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

-- brew install lua-language-server
lsp.lua_ls.setup({
    handlers = handlers,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT", path = runtime_path },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
})

M.go_import = function()
    local clients = vim.lsp.get_active_clients()
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
-- go install golang.org/x/tools/gopls@latest
lsp.gopls.setup({
    cmd = {
        "gopls",
        "-remote=auto",
    },
    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = { "*.go" },
            callback = function()
                M.go_import()
                vim.lsp.buf.format({ timeout_ms = 3000 })
            end,
        })
    end,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                -- shadow = true,
            },
            staticcheck = true,
            env = {
                GOFLAGS = "-tags=wireinject,e2e",
            },
            gofumpt = false,
        },
    },
})

-- npm install -g typescript typescript-language-server
-- require("typescript-tools").setup {}
--[[ require("typescript").setup({
    server = {
        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
        init_options = {
            preferences = {
                disableSuggestions = true,
            },
        },
    },
}) ]]
lsp.tsserver.setup({
    capabilities = capabilities,
    handlers = handlers,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

lsp.eslint.setup({
    capabilities = capabilities,
    handlers = handlers,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.cmd([[autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll]])
    end,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
    },
    settings = {
        codeActionOnSave = {
            enable = true,
            mode = "all",
        },
    },
})

-- Python LSP --
lsp.pyright.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

lsp.solargraph.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

-- CSS LSP --
-- npm i -g vscode-langservers-extracted
lsp.cssls.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

-- npm i -g vscode-langservers-extracted
lsp.jsonls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        lsp_format_autocmd(bufnr)
    end,
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
        },
    },
})

-- npm i -g yaml-language-server
lsp.yamlls.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = true
        client.server_capabilities.documentRangeFormattingProvider = true
        on_attach(client, bufnr)
    end,
    settings = {
        yaml = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
            format = {
                singleQuote = true,
            },
        },
    },
})
-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Rust LSP --
-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
lsp.rust_analyzer.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = on_attach,
})

-- npm install @ignored/solidity-language-server -g
lsp.solidity.setup({
    handlers = handlers,
    cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
    filetypes = { 'solidity' },
    root_dir = require("lspconfig.util").find_git_ancestor,
    single_file_support = true,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

-- npm install -g graphql-language-service-cli
lsp.graphql.setup({
    handlers = handlers,
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
})

require("conform").setup({
    formatters_by_ft = {
        sql = { "pg_format" },
        css = { "prettier" },
        graphql = { "prettier" },
        yaml = { "prettier" },
        solidity = { "solidity" },
        -- ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
    formatters = {
        solidity = {
            inherit = false,
            command = require("conform.util").find_executable({
                "node_modules/.bin/prettier",
            }, "prettier"),
            args = {
                "--stdin-filepath",
                "$FILENAME",
                "--plugin",
                "prettier-plugin-solidity",
            },
        },
    },
})

M.setup = function()
    lsp_setup_signs()
    lsp_setup_diagnositc()
end

return M
