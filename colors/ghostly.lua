-- Initialization
vim.cmd("hi clear")

if vim.fn.exists("syntax on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = 'ghostly'

local colors = {
    red = "#ec2100",
    blue = "#008EC4",
    green = "#5FD7A7",
    diff_delete = "#FCD5D2",
    diff_add = "#CAFFD8",
    yellow = "#A89C14",
    bg = "#eae9e6",
    bg_subtle = "#b2b2b2",
    bg_very_subtle = "#c6c6c6",
    bg_ui = "#949494",
    fg = "#323232",
    fg_subtle = "#585858",
    -- special = "#a94dbb",
    special = "#1d48ad",
    str = "#dadada",
    type = "#000000"
}

if vim.o.background == 'dark' then
    colors.bg = "#232323"
    colors.bg_subtle = "#777777"
    colors.bg_very_subtle = "#666666"
    colors.bg_ui = "#888888"
    colors.fg = "#eaeaea"
    colors.fg_subtle = "#999999"
    colors.special = "#a95dbb"
    colors.str = "#333333"
    colors.type = "#fffff"
    colors.diff_delete = "#9F2828"
    colors.diff_add = "#27422A"
end



-- NvimDarkBlue    NvimLightBlue
-- NvimDarkCyan    NvimLightCyan
-- NvimDarkGray1   NvimLightGray1
-- NvimDarkGray2   NvimLightGray2
-- NvimDarkGray3   NvimLightGray3
-- NvimDarkGray4   NvimLightGray4
-- NvimDarkGreen   NvimLightGreen
-- NvimDarkMagenta NvimLightMagenta
-- NvimDarkRed     NvimLightRed
-- NvimDarkYellow  NvimLightYellow

-- Highlight groups
-- vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
-- vim.api.nvim_set_hl(0, 'String', { bg = 'NvimDarkGray3' })
-- vim.api.nvim_set_hl(0, 'Comment', { fg = 'NvimLightGray4', italic = true })
-- vim.api.nvim_set_hl(0, 'Constant', { bold = true, italic = true })
-- vim.api.nvim_set_hl(0, 'Statement', { fg = 'NvimLightGray4', bold = true })
-- vim.api.nvim_set_hl(0, 'Type', { bold = true })
-- vim.api.nvim_set_hl(0, 'Special', { fg = '#a95dbb', bold = true })
-- vim.api.nvim_set_hl(0, 'NonText', { fg = 'NvimLightGray4' })

vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "String", { fg = colors.fg, bg = colors.str })
vim.api.nvim_set_hl(0, "Cursor", { fg = colors.fg, bg = colors.bg_ui })
vim.api.nvim_set_hl(0, "Comment", { fg = colors.bg_subtle, italic = true })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.fg_subtle, bold = true, italic = true })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.fg })
vim.api.nvim_set_hl(0, "Statement", { fg = colors.fg_subtle, bold = true })
vim.api.nvim_set_hl(0, "Type", { fg = colors.type, bold = true })
vim.api.nvim_set_hl(0, "Special", { fg = colors.special, bold = true })
vim.api.nvim_set_hl(0, "TreesitterContext", { italic = true })
vim.api.nvim_set_hl(0, "TreesitterContextBottom", { italic = true, underline = true })

vim.api.nvim_set_hl(0, "LspCodeLens", { fg = colors.bg_subtle, underline = true })
vim.api.nvim_set_hl(0, "LspInlayHint", { fg = colors.bg_subtle, underline = true })
vim.api.nvim_set_hl(0, "Underlined", { fg = colors.fg, underline = true })
vim.api.nvim_set_hl(0, "Ignore", { fg = colors.bg })
vim.api.nvim_set_hl(0, "Error", { fg = colors.bg, bg = colors.red, undercurl = true })
vim.api.nvim_set_hl(0, "Todo", { fg = colors.special, underline = true })
vim.api.nvim_set_hl(0, "SpecialKey", { fg = colors.green })
vim.api.nvim_set_hl(0, "NonText", { fg = colors.bg_very_subtle })
vim.api.nvim_set_hl(0, "Directory", { fg = colors.blue })
vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.yellow, bold = true })
vim.api.nvim_set_hl(0, "HintMsg", { fg = colors.fg })
vim.api.nvim_set_hl(0, "InfoMsg", { fg = colors.fg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.yellow, fg = colors.bg })
vim.api.nvim_set_hl(0, "Search", { bg = colors.yellow, fg = colors.bg })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = colors.bg_subtle, bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.bg_subtle })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.special, bg = colors.bg_very_subtle })
vim.api.nvim_set_hl(0, "Question", { fg = colors.red })
vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.bg, bg = colors.bg_ui })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.bg, bg = colors.bg_subtle })
vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.bg_ui })
vim.api.nvim_set_hl(0, "Title", { fg = colors.blue })
vim.api.nvim_set_hl(0, "Visual", { fg = colors.bg, bg = colors.bg_ui })
vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.bg_subtle })
vim.api.nvim_set_hl(0, "WildMenu", { fg = colors.bg, bg = colors.fg })
vim.api.nvim_set_hl(0, "Folded", { fg = colors.bg_subtle })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.bg_subtle })
vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.fg, bg = colors.diff_add })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.fg, bg = colors.diff_delete })
vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.fg, bg = colors.diff_add })
vim.api.nvim_set_hl(0, "DiffText", { reverse = true })
vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.green })

vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = colors.red })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = colors.green })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = colors.blue })
vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = colors.green })

vim.api.nvim_set_hl(0, "Pmenu", { fg = colors.fg })
vim.api.nvim_set_hl(0, "PmenuSel", { fg = colors.fg, bg = colors.bg_subtle, bold = true })
vim.api.nvim_set_hl(0, "PmenuSbar", { fg = colors.fg, bg = colors.bg_very_subtle })
vim.api.nvim_set_hl(0, "PmenuThumb", { fg = colors.bg, bg = colors.fg })

vim.api.nvim_set_hl(0, "TabLine", { fg = colors.fg, bg = colors.bg_very_subtle })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = colors.bg, bg = colors.bg_ui, bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = colors.bg_very_subtle })
vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.bg_subtle })

vim.api.nvim_set_hl(0, "MatchParen", { bg = colors.bg_subtle, fg = colors.fg })
vim.api.nvim_set_hl(0, "qfLineNr", { fg = colors.bg_subtle })

local highlight_links = {
    Normal = {
        'DapUIVariable',
        'DapUIFrameName',
        'Identifier',
    },
    Constant = {
        'Character',
        'Number',
        'Boolean',
        'Float',
        '@constant',

        'DapUIThread',
        'DapUIWatchesValue',
        'DapUIBreakpointsInfo',
        'DapUIBreakpointsCurrentLine',
        'DapUIThread',
        'DapUIWatchesValue',
        'DapUIBreakpointsInfo',
        'DapUIBreakpointsCurrentLine',
    },
    Identifier = {
        'Delimiter',
        'Function',
        'TSIdentifier',
        'TSConstructor',
        '@constructor',
        '@function',
        '@method',
    },
    Statement = {
        'Conditional',
        'Repeat',
        'Label',
        'Keyword',
        'Exception',
        'PreProc',
        'Include',
        'Define',
        'Macro',
        'PreCondit',
        'IndentLineCurrent',

        'DapUIScope',
        'DapUIDecoration',
        'DapUIStoppedThread',
        'DapUILineNumber',
        'DapUIFloatBorder',
        'DapUIWatchesHeader',
        'DapUIBreakpointsPath',
        'DapUIBreakpointsLine',
    },
    Type = {
        'StorageClass',
        'Structure',
        'Typedef',
        '@type',
        '@structure',
        '@namespace',

        'DapUIType',
        'DapUISource',
    },
    Special = {
        'Operator',
        'SpecialChar',
        'Tag',
        'SpecialComment',
        'Debug',
    },
    String = {
        "@text.literal.block"
    },
    Visual = {
        'TelescopeMatching',
    },
    Underlined = {
        'EyelinerPrimary',
        'EyelinerSecondary',
        'LspReferenceText',
        'LspReferenceRead',
        'LspReferenceWrite',
    },
    Pmenu = {
        'FloatBorder',
        'NormalFloat',
        'CmpItemAbbrDefault',
    },
    LineNr = {
        'SignColumn',
        'SignifySignAdd',
        'SignifySignDelete',
        'SignifySignChange',
        'GitGutterAdd',
        'GitGutterDelete',
        'GitGutterChange',
        'GitGutterChangeDelete',
    },
    DiffAdd = {
        'GitSignsAdd',
        'GitSignsAddNr',
        'GitSignsAddLn',
    },
    DiffChange = {
        'GitSignsChange',
        'GitSignsChangeNr',
        'GitSignsChangeLn',
    },
    DiffDelete = {
        'GitSignsDelete',
        'GitSignsDeleteNr',
        'GitSignsDeleteLn',
    },
    Comment = {
        'GitSignsCurrentLineBlame',
        'IndentLine',
        'TreesitterContext',
        'TreesitterContextSeparator',
    },
    Error = {
        'DapUIWatchesEmpty',
        'DapUIWatchesError',
    },
    ErrorMsg = {
        'DiagnosticError',
    },
    WarningMsg = {
        'DiagnosticWarn',
    },
    HintMsg = {
        'DiagnosticHint',
    },
    InfoMsg = {
        'DiagnosticInfo',
    },
}

for to, entries in pairs(highlight_links) do
    for _, from in ipairs(entries) do
        vim.api.nvim_set_hl(0, from, { link = to })
    end
end


local links = {
    ['@lsp.type.namespace'] = '@namespace',
    ['@lsp.type.type'] = '@type',
    ['@lsp.type.class'] = '@type',
    ['@lsp.type.enum'] = '@type',
    ['@lsp.type.interface'] = '@type',
    ['@lsp.type.struct'] = '@structure',
    ['@lsp.type.parameter'] = '@parameter',
    ['@lsp.type.variable'] = '@variable',
    ['@lsp.type.property'] = '@property',
    ['@lsp.type.enumMember'] = '@constant',
    ['@lsp.type.function'] = '@function',
    ['@lsp.type.method'] = '@method',
    ['@lsp.type.macro'] = '@macro',
    ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
    vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
