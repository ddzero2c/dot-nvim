-- vim.cmd.colorscheme('ghostly')
-- vim.o.background = "light"
-- vim.o.background = "dark"

-- syntax
vim.api.nvim_set_hl(0, 'Normal', {})
vim.api.nvim_set_hl(0, 'NormalFloat', {})
vim.api.nvim_set_hl(0, 'String', { fg = 'none', bg = 'NvimDarkGray3' })
vim.api.nvim_set_hl(0, 'Statement', { fg = 'NvimLightGray4', bold = true })
vim.api.nvim_set_hl(0, 'Special', { fg = '#6a91bc', bold = true })
vim.api.nvim_set_hl(0, 'Type', { bold = true })
vim.api.nvim_set_hl(0, 'Constant', { bold = true, italic = true })
vim.api.nvim_set_hl(0, 'Comment', { fg = 'NvimLightGray4', italic = true })

-- ui
vim.api.nvim_set_hl(0, "TabLine", {})

local highlight_links = {
    Normal = { 'Identifier', 'Delimiter', 'Function', '@constructor' },
    NormalFloat = { 'Pmenu' },
    Comment = { 'IndentLine' },
    Constant = { 'Character', 'Number', 'Boolean', 'Float', '@constant' },
    Special = { 'Operator' },
    Visual = { 'TabLineSel', 'StatusLine', 'PmenuSel', 'TelescopeMatching' },
    Statement = { 'PreProc' },
    LineNr = { 'SignColumn', 'ColorColumn' },
}

for to, entries in pairs(highlight_links) do
    for _, from in ipairs(entries) do
        vim.api.nvim_set_hl(0, from, { link = to })
    end
end
