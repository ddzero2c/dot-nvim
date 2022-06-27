require('cmp_nvim_lsp').setup()
local cmp = require 'cmp'
local lspkind = require 'lspkind'

vim.cmd [[
set completeopt=menu,menuone,noselect
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
]]

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup {
    -- completion = {
    -- 	autocomplete = false,
    -- },
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        -- ['<Tab>'] = cmp.config.disable,
        -- ['<S-Tab>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ['<C-j>'] = cmp.mapping.confirm { select = true },
        ['<C-n>'] = function(fallback)
            if not cmp.select_next_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,

        ['<C-p>'] = function(fallback)
            if not cmp.select_prev_item() then
                if vim.bo.buftype ~= 'prompt' and has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        -- { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer', option = {
            get_bufnrs = function()
                return vim.api.nvim_list_bufs()
            end,
        } },
        { name = 'emoji' },
        { name = 'vim-dadbod-completion' }
    },
    formatting = {
        format = lspkind.cmp_format {
            -- with_text = false,
            -- menu = {
            -- 	vsnip = "[vsnip]",
            -- 	nvim_lsp = "[lsp]",
            -- 	nvim_lua = "[lua]",
            -- 	path = "[path]",
            -- 	buffer = "[buf]",
            -- 	emoji = "[emoji]",
            -- },
        },
    },
    --documentation = {
    --	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    --},
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
-- 	sources = {
-- 		{ name = 'buffer' },
-- 	},
-- })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

-- _G.vimrc = _G.vimrc or {}
-- _G.vimrc.cmp = _G.vimrc.cmp or {}
-- _G.vimrc.cmp.on_text_changed = function()
-- 	local cursor = vim.api.nvim_win_get_cursor(0)
-- 	local line = vim.api.nvim_get_current_line()
-- 	local before = string.sub(line, 1, cursor[2] + 1)
-- 	if before:match '%s*$' then
-- 		cmp.complete() -- Trigger completion only if the cursor is placed at the end of line.
-- 	end
-- end
-- vim.cmd [[
--   augroup vimrc
--     autocmd
--     autocmd TextChanged,TextChangedI,TextChangedP * call luaeval('vimrc.cmp.on_text_changed()')
--   augroup END
-- ]]

-- vim.cmd [[
-- imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
-- smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
-- imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
-- imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
-- smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

-- ]]
