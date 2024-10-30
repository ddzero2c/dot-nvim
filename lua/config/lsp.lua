-- vim.opt.signcolumn = 'yes'

require("neodev").setup({})
require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
require("gopher").setup({})
require("typescript-tools").setup({
    {
        settings = {
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeCompletionsForModuleExports = true,
                quotePreference = "auto",
            },
        },
    }
})
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)
lspconfig_defaults.handlers = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.handlers,
    { ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }) }
)

vim.diagnostic.config({
    virtual_text = { source = true, },
    float = { source = true, border = "single", focusable = true, },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
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
    end,
})

local jsonschemas = require("schemastore").json.schemas()
local lsp = require('lspconfig')
lsp.zls.setup({})
lsp.lua_ls.setup({})
lsp.pyright.setup({})
lsp.graphql.setup({})
lsp.tailwindcss.setup({})
lsp.cssls.setup({})
lsp.eslint.setup({
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
})
lsp.jsonls.setup({
    settings = { json = { schemas = jsonschemas } },
})
lsp.yamlls.setup({
    settings = {
        yaml = {
            schemas = jsonschemas,
            validate = { enable = true },
            format = { enable = true, singleQuote = true }
        }
    },
})
lsp.solidity_ls_nomicfoundation.setup({})
lsp.gopls.setup({
    cmd = { "gopls", "--remote=auto" },
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
            hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                -- assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
            },
        },
    },
})

require("cmp_git").setup()
local cmp = require('cmp')

cmp.setup({
    window = {
        completion = {
            border = "single",
            scrollbar = true,
        },
        documentation = {
            border = "single",
            scrollbar = "║",
        },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help", view = { entries = { name = 'wildmenu', separator = '|' } } },
        { name = "nvim_lua" },
        { name = "path" },
        {
            name = "buffer",
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "emoji" },
        { name = "dictionary", keyword_length = 2 },
        { name = "git" },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = function()
            if vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                cmp.select_next_item()
            end
        end,
        ['<C-p>'] = function()
            if vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                cmp.select_prev_item()
            end
        end,

        -- ["<C-j>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
        -- ["<C-y>"] = cmp.config.disable,
    }),
})
