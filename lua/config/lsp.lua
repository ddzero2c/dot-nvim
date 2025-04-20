vim.o.completeopt = "menu,noselect,popup,fuzzy"
local cmp = require 'cmp'
cmp.setup({
    snippet = { expand = function(args) vim.snippet.expand(args.body) end },
    window = {
        completion = { border = "single", scrollbar = true },
        documentation = { border = "single", scrollbar = "." }
    },
    entries = { name = 'custom', selection_order = 'near_cursor' },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    }),
    sources = cmp.config.sources(
        { { name = 'nvim_lua' } },
        { { name = 'nvim_lsp' }, { name = 'nvim_lsp_signature_help' } },
        { { name = 'buffer' }, { name = 'path' } },
        { { name = 'emoji' } }
    ),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                nvim_lua = "[LUA]",
                nvim_lsp = "[LSP]",
                buffer = "[BUF]",
                emoji = "[EMO]",
            })[entry.source.name]
            return vim_item
        end
    }
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
    callback = function(ev)
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
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
        vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<C-n>", vim.diagnostic.goto_next, opts)

        -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client == nil then
        --     return
        -- end
        -- local ms = vim.lsp.protocol.Methods
        -- if client:supports_method(ms.textDocument_completion) then
        --     client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm.", "")
        --     vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        -- end

        -- if client:supports_method(ms.textDocument_documentHighlight) then
        --     local group = vim.api.nvim_create_augroup("LSPDocumentHighlight",
        --         { clear = true })
        --     vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        --         group = group,
        --         buffer = ev.buf,
        --         callback = vim.lsp.buf.document_highlight
        --     })
        --     vim.api.nvim_create_autocmd("CursorMoved", {
        --         group = group,
        --         buffer = ev.buf,
        --         callback = vim.lsp.buf.clear_references
        --     })
        -- end

        --     if client:supports_method(ms.textDocument_signatureHelp) then
        --         vim.api.nvim_create_autocmd("InsertCharPre", {
        --             buffer = ev.buf,
        --             callback = function()
        --                 local char = vim.v.char
        --                 if char == "(" or char == "," or char == " " then
        --                     vim.schedule(function()
        --                         vim.lsp.buf_request(
        --                             ev.buf,
        --                             ms.textDocument_signatureHelp,
        --                             vim.lsp.util.make_position_params(),
        --                             function(err, result, ctx, config)
        --                                 if err or not result or not result.signatures or #result.signatures == 0 then
        --                                     return
        --                                 end
        --
        --                                 -- 使用 vim.lsp.handlers 處理結果
        --                                 vim.lsp.handlers['textDocument/signatureHelp'](err, result, ctx, config)
        --                             end
        --                         )
        --                     end)
        --                 end
        --             end
        --         })
        --     end
    end,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.util.default_config.capabilities = capabilities

lspconfig.zls.setup({})
lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({
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
lspconfig.graphql.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.cssls.setup({})
lspconfig.eslint.setup({
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
lspconfig.jsonls.setup({ settings = { json = { schemas = jsonschemas } } })
lspconfig.yamlls.setup({
    settings = {
        yaml = {
            schemas = jsonschemas,
            validate = { enable = true },
            format = { enable = true, singleQuote = true }
        }
    }
})
lspconfig.solidity_ls_nomicfoundation.setup({})
lspconfig.gopls.setup({
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
    cmd = { "gopls" },
    settings = { gopls = { env = { GOFLAGS = "-tags=wireinject" } } }
})
