require("cmp_nvim_lsp").setup()
local cmp = require("cmp")
local lspkind = require("lspkind")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.cmd([[
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
]])

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local cmp_next = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
    elseif has_words_before() then
        cmp.complete()
    else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
    end
end

local cmp_prev = function()
    if cmp.visible() then
        cmp.select_prev_item()
    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
    end
end

cmp.setup({
    window = {
        completion = {
            border = "single",
            scrollbar = "║",
            col_offset = -3,
            side_padding = 0,
        },
        documentation = {
            border = "single",
            scrollbar = "║",
        },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    -- preselect = cmp.PreselectMode.None,
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<C-j>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            -- select = true,
        }),
        ["<Tab>"] = cmp.mapping(cmp_next, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(cmp_prev, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(cmp_next, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(cmp_prev, { "i", "s" }),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help", view = { entries = { name = 'wildmenu', separator = '|' } } },
        { name = "nvim_lua" },
        -- { name = 'vsnip' },
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
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 50,
            })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"
            return kind
        end,
    },
})

require("cmp_dictionary").setup({
    dic = {
        ["*"] = { os.getenv("HOME") .. "/.config/nvim/10k.txt" },
    },
})

require("cmp_git").setup()
