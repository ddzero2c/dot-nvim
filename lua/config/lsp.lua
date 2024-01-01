local M = {}

require("neodev").setup({})
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
require('gopher').setup({})
local jsonschemas = require("schemastore").json.schemas()
local go_embedded_sql = require('go-embedded-sql')
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

local function lsp_setup_diagnostic()
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
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "<leader>sf", go_embedded_sql.format_sql, opts)
    vim.keymap.set("v", "<leader>sf", go_embedded_sql.format_sql_visual, opts)
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

local function go_import()
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

local lsp_configurations = {
    -- brew install lua-language-server
    lua_ls = {},
    tsserver = {},
    typos_lsp = { root_dir = require("lspconfig.util").find_git_ancestor },
    pyright = {},
    -- npm install -g graphql-language-service-cli
    graphql = {},
    -- npm install -g @tailwindcss/language-server
    tailwindcss = {},
    -- npm i -g yaml-language-server
    yamlls = {
        settings = { yaml = { schemas = jsonschemas, validate = { enable = true } } },
    },
    -- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/download/2021-10-18/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/bin/rust-analyzer && chmod +x ~/bin/rust-analyzer
    rust_analyzer = {},
    -- npm install @ignored/solidity-language-server -g
    solidity = {
        cmd = { 'nomicfoundation-solidity-language-server', '--stdio' },
        filetypes = { 'solidity' },
        root_dir = require("lspconfig.util").find_git_ancestor,
        single_file_support = true,
    },
    -- go install golang.org/x/tools/gopls@latest
    gopls = {
        cmd = {
            "gopls",
            "-remote=auto",
        },
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.go" },
                callback = function()
                    go_import()
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
    },
    -- npm i -g vscode-langservers-extracted
    cssls = {},
    jsonls = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            lsp_format_autocmd(bufnr)
        end,
        settings = { json = { schemas = jsonschemas } },
    },
    eslint = {
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
        },
        settings = {
            codeActionOnSave = {
                enable = true,
                mode = "all",
            },
        },
    },
}


M.setup = function()
    lsp_setup_signs()
    lsp_setup_diagnostic()
    for name, config in pairs(lsp_configurations) do
        config.capabilities = config.capabilities or capabilities
        config.handlers = config.handlers or handlers
        config.on_attach = config.on_attach or on_attach
        if lsp[name] then
            lsp[name].setup(config)
        end
    end
end

return M
