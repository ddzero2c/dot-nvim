require("blink.cmp").setup({
    keymap = { preset = 'default' },
    signature = { enabled = true, trigger = { enabled = true } },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        list = {
            selection = { preselect = true, auto_insert = true, }
        },
        documentation = { auto_show = true },
        ghost_text = { enabled = false },
        keyword = { range = 'prefix' },
        menu = {
            draw = {
                columns = {
                    { "label",     "label_description", gap = 1 },
                    { "kind_icon", "source_name",       gap = 1 },
                },
            }
        },
    },
    sources = {
        default = { 'lsp', 'path', 'buffer' },
    },
    fuzzy = { implementation = "lua" }
})

vim.diagnostic.config({
    virtual_text = { source = true },
    float = { source = true, focusable = true },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        -- grn in Normal mode maps to vim.lsp.buf.rename()
        -- grr in Normal mode maps to vim.lsp.buf.references()
        -- gri in Normal mode maps to vim.lsp.buf.implementation()
        -- gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
        -- gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
        -- CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
        -- [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)

        -- [q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
        -- [l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location list
        -- [t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag matchlist
        -- [a, ]a, [A, ]A navigate through the argument list
        -- [b, ]b, [B, ]B navigate through the buffer list
        -- [<Space>, ]<Space> add an empty line above and below the cursor
        local opts = { buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = args.buf })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf })
                end,
            })
        end
    end,
})

local capabilities = require('blink.cmp').get_lsp_capabilities({
    textDocument = {
        foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }
    }
})

local setup_lsp = function(server, opts)
    vim.lsp.config(server, opts, capabilities)
    vim.lsp.enable(server)
end

setup_lsp('zls', {})
setup_lsp('lua_ls', {})
setup_lsp('pylsp', {
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
setup_lsp('graphql', {})
setup_lsp('tailwindcss', {})
setup_lsp('cssls', {})
setup_lsp('eslint', {
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, command = "EslintFixAll" })
    end,
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    settings = { codeActionOnSave = { enable = true, mode = "all" } }

})
local jsonschemas = require("schemastore").json.schemas()
setup_lsp('jsonls', { settings = { json = { schemas = jsonschemas } } })
setup_lsp('yamlls', {
    settings = {
        yaml = {
            schemas = jsonschemas,
            validate = { enable = true },
            format = { enable = true, singleQuote = true }
        }
    }
})
setup_lsp('solidity_ls_nomicfoundation', {})
setup_lsp('gopls', {
    on_attach = function(client, bufnr)
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
                require('go.format').goimports()
            end,
            group = format_sync_grp,
        })
    end,
    cmd = { "gopls" },
    settings = { gopls = { env = { GOFLAGS = "-tags=wireinject" } } }
})
