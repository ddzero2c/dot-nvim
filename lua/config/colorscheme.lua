-- vim.cmd.colorscheme('ghostly')
-- vim.o.background = "light"
-- vim.o.background = "dark"

-- syntax
if vim.o.background == 'dark' then
    vim.api.nvim_set_hl(0, 'String', { fg = 'none', bg = '#3a3a3a' })
    vim.api.nvim_set_hl(0, 'Statement', { fg = 'NvimLightGray4', bold = true })
    vim.api.nvim_set_hl(0, 'Special', { fg = '#6a91bc', bold = true })
    vim.api.nvim_set_hl(0, 'Type', { bold = true })
    vim.api.nvim_set_hl(0, 'Constant', { bold = true, italic = true })
    vim.api.nvim_set_hl(0, 'Comment', { fg = 'NvimLightGray4', italic = true })
else
    vim.api.nvim_set_hl(0, 'String', { fg = 'none', bg = 'NvimLightGray4' })
    vim.api.nvim_set_hl(0, 'Statement', { fg = 'NvimDarkGray4', bold = true })
    vim.api.nvim_set_hl(0, 'Special', { fg = '#6a91bc', bold = true })
    vim.api.nvim_set_hl(0, 'Type', { bold = true })
    vim.api.nvim_set_hl(0, 'Constant', { bold = true, italic = true })
    vim.api.nvim_set_hl(0, 'Comment', { fg = 'NvimDarkGray3', italic = true })
    vim.api.nvim_set_hl(0, 'Visual', { bg = 'NvimLightGray3' })
    vim.api.nvim_set_hl(0, 'Cursor', { bg = 'NvimDarkGray3' })
end

-- ui
vim.api.nvim_set_hl(0, 'Normal', {})
vim.api.nvim_set_hl(0, 'NormalFloat', {})
vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#444444' })
vim.api.nvim_set_hl(0, "TabLine", {})

local highlight_links = {
    Normal = { 'Identifier', 'Delimiter', 'Function', '@constructor' },
    -- NormalFloat = { 'Pmenu' },
    Comment = { 'IndentLine' },
    Constant = { 'Character', 'Number', 'Boolean', 'Float', '@constant' },
    Special = { 'Operator' },
    Visual = { 'TabLineSel', 'StatusLine', 'PmenuSel', 'TelescopeMatching', 'QuickFixLine' },
    Statement = { 'PreProc' },
    LineNr = { 'SignColumn', 'ColorColumn' },
}

for to, entries in pairs(highlight_links) do
    for _, from in ipairs(entries) do
        vim.api.nvim_set_hl(0, from, { link = to })
    end
end
