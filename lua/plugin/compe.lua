vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = {kind = "  "},
        buffer = {kind = "  "},
        calc = {kind = "  "},
        vsnip = {kind = "  "},
        nvim_lsp = {kind = "  "},
        -- nvim_lua = {kind = "  "},
        nvim_lua = false,
        spell = {kind = "  "},
        tags = false,
        vim_dadbod_completion = true,
        -- snippets_nvim = {kind = "  "},
        -- ultisnips = {kind = "  "},
        -- treesitter = {kind = "  "},
        emoji = {kind = " ﲃ ", filetypes = {"markdown"}}
        -- for emoji press : (idk if that in compe tho)
    }
}

vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })",
                        {silent = true, expr = true, noremap = true})
vim.api.nvim_set_keymap("i", "<C-b>", "compe#scroll({ 'delta': -4 })",
                        {silent = true, expr = true, noremap = true})

-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- ﬘
-- 
-- 
-- 
-- m
-- 
-- 
-- 
-- 

