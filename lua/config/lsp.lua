require("neodev").setup({})
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
require("gopher").setup({})
require("flutter-tools").setup({
    flutter_lookup_cmd = "asdf where flutter"
})
-- require("vtsls").config({})
require("typescript-tools").setup({
    {
        settings = {
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeCompletionsForModuleExports = true,
                quotePreference = "auto"
            }
        }
    }
})
local lspconfig_defaults = require('lspconfig').util.default_config
-- lspconfig_defaults.capabilities = require('blink.cmp').get_lsp_capabilities(lspconfig_defaults.capabilities)
lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities())
lspconfig_defaults.handlers = vim.tbl_deep_extend('force',
    lspconfig_defaults.handlers, {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover,
            { border = "single" })
        -- ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
    })

vim.diagnostic.config({
    virtual_text = { source = true },
    float = { source = true, border = "single", focusable = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)
        -- Setup document highlight autocmds only if server supports it
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            local group = vim.api.nvim_create_augroup("LSPDocumentHighlight",
                { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = group,
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                group = group,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references
            })
        end
    end
})

local lsp = require('lspconfig')
-- lsp.vtsls.setup({})
lsp.zls.setup({})
lsp.lua_ls.setup({})
lsp.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                rope_autoimport = {
                    enable = true,
                    completions = { enabled = true },
                    code_actions = { enabled = true }
                },
                pycodestyle = { enabled = false }
            }
        }
    }
})
lsp.graphql.setup({})
lsp.tailwindcss.setup({})
lsp.cssls.setup({})
lsp.eslint.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre",
            { buffer = bufnr, command = "EslintFixAll" })
    end,
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    settings = { codeActionOnSave = { enable = true, mode = "all" } }

})
local jsonschemas = require("schemastore").json.schemas()
lsp.jsonls.setup({ settings = { json = { schemas = jsonschemas } } })
lsp.yamlls.setup({
    settings = {
        yaml = {
            schemas = jsonschemas,
            validate = { enable = true },
            format = { enable = true, singleQuote = true }
        }
    }
})
lsp.solidity_ls_nomicfoundation.setup({})
lsp.gopls.setup({
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                local clients = vim.lsp.get_clients()
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
            end,
        })
    end,
    cmd = { "gopls", "--remote=auto" },
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true
            },
            staticcheck = true,
            env = { GOFLAGS = "-tags=wireinject" },
            gofumpt = false,
            hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                -- assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true
            }
        }
    }
})

local cmp = require('cmp')

cmp.setup({
    window = {
        completion = { border = "single", scrollbar = true },
        documentation = { border = "single", scrollbar = "║" }
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help", view = { entries = { name = 'wildmenu', separator = '|' } } },
        { name = "nvim_lua" }, { name = "path" },
        { name = "buffer",     option = { get_bufnrs = function() return vim.api.nvim_list_bufs() end } },
        { name = "emoji" },
        { name = "dictionary", keyword_length = 2 },
    },
    snippet = { expand = function(args) vim.snippet.expand(args.body) end },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
    })
})
