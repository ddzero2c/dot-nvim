-- Initialization
vim.cmd("hi clear")

if vim.fn.exists("syntax on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = 'ghostly'

local colors = {
    black = "#000000",
    white = "#F1F1F1",
    actual_white = "#FFFFFF",
    red = "#C30771",
    red_error = "#ec2100",
    blue = "#008EC4",
    green = "#10A778",
    diff_delete = "#FCD5D2",
    diff_add = "#CAFFD8",
    light_green = "#5FD7A7",
    light_purple = "#a790d5",
    yellow = "#A89C14",
    gray1 = "#1c1c1c",
    gray2 = "#3a3a3a",
    gray3 = "#585858",
    gray4 = "#767676",
    gray5 = "#949494",
    gray6 = "#b2b2b2",
    gray7 = "#c6c6c6",
    gray8 = "#dadada",
    gray9 = "#eaeaea",
    bg = "#eaeaea",
    bg_subtle = "#b2b2b2",
    bg_very_subtle = "#c6c6c6",
    bg_ui = "#949494",
    fg = "#1c1c1c",
    fg_subtle = "#585858",
    main = "#a94dbb",
    string = "#dadada",
    type = "#000000"
}

if vim.o.background == 'dark' then
    colors.bg = "#232323"
    colors.bg_subtle = "#777777"
    colors.bg_very_subtle = "#666666"
    colors.bg_ui = "#888888"
    colors.fg = "#eaeaea"
    colors.fg_subtle = "#999999"
    colors.main = "#a96dbb"
    colors.string = "#333333"
    colors.type = "#eaeaea"
    colors.diff_delete = "#FC3333"
    colors.diff_add = "#22CC55"
end

local function highlight(group, style)
    local guifg = style.fg or "NONE"
    local guibg = style.bg or "NONE"
    local guisp = style.sp or "NONE"
    local gui = style.gui or "NONE"
    vim.cmd(string.format('highlight %s guifg=%s guibg=%s guisp=%s gui=%s', group, guifg, guibg, guisp, gui))
end

-- Highlight groups
highlight("Normal", { fg = colors.fg, bg = colors.bg })
highlight("String", { fg = colors.fg, bg = colors.string })
highlight("Cursor", { fg = colors.fg, bg = colors.bg_ui })
highlight("Comment", { fg = colors.bg_subtle, gui = "italic" })
highlight("Constant", { fg = colors.fg_subtle, gui = "bold,italic" })
highlight("Identifier", { fg = colors.fg })
highlight("Statement", { fg = colors.fg_subtle, gui = "bold" })
highlight("Type", { fg = colors.type, gui = "bold" })
highlight("Special", { fg = colors.main, gui = "bold" })
highlight("TreesitterContext", { gui = "italic" })
highlight("TreesitterContextBottom", { gui = "italic,underline" })

highlight("LspCodeLens", { fg = colors.bg_subtle, gui = "underline" })
highlight("Underlined", { fg = colors.fg, gui = "underline" })
highlight("Ignore", { fg = colors.bg })
highlight("Error", { fg = colors.actual_white, bg = colors.red_error, gui = "undercurl" })
highlight("Todo", { fg = colors.main, gui = "underline" })
highlight("SpecialKey", { fg = colors.light_green })
highlight("NonText", { fg = colors.bg_very_subtle })
highlight("Directory", { fg = colors.blue })
highlight("ErrorMsg", { fg = colors.red_error, gui = "bold" })
highlight("WarningMsg", { fg = colors.yellow, gui = "bold" })
highlight("HintMsg", { fg = colors.fg })
highlight("InfoMsg", { fg = colors.fg })
highlight("IncSearch", { bg = colors.main, fg = colors.white })
highlight("Search", { bg = colors.main, fg = colors.white })
highlight("MoreMsg", { fg = colors.gray4, gui = "bold" })
highlight("LineNr", { fg = colors.bg_subtle })
highlight("CursorLineNr", { fg = colors.main, bg = colors.bg_very_subtle })
highlight("Question", { fg = colors.red })
highlight("StatusLine", { fg = colors.white, bg = colors.bg_ui })
highlight("StatusLineNC", { fg = colors.white, bg = colors.bg_subtle })
highlight("VertSplit", { fg = colors.bg_ui, })
highlight("Title", { fg = colors.blue })
highlight("Visual", { fg = colors.white, bg = colors.bg_ui })
highlight("VisualNOS", { bg = colors.bg_subtle })
highlight("WildMenu", { fg = colors.bg, bg = colors.fg })
highlight("Folded", { fg = colors.gray4 })
highlight("FoldColumn", { fg = colors.bg_subtle })
highlight("DiffAdd", { fg = colors.black, bg = colors.diff_add })
highlight("DiffDelete", { fg = colors.black, bg = colors.diff_delete })
highlight("DiffChange", { fg = colors.black, bg = colors.diff_add })
highlight("DiffText", { fg = colors.black, bg = colors.light_green })
highlight("SignColumn", { fg = colors.light_green })

highlight("SpellBad", { gui = "undercurl", sp = colors.red })
highlight("SpellCap", { gui = "undercurl", sp = colors.light_green })
highlight("SpellRare", { gui = "undercurl", sp = colors.light_purple })
highlight("SpellLocal", { gui = "undercurl", sp = colors.green })

highlight("Pmenu", { fg = colors.fg, bg = colors.bg })
highlight("PmenuSel", { fg = colors.fg, bg = colors.bg_subtle, gui = "bold" })
highlight("PmenuSbar", { fg = colors.fg, bg = colors.bg_very_subtle })
highlight("PmenuThumb", { fg = colors.bg, bg = colors.fg })

highlight("TabLine", { fg = colors.fg, bg = colors.bg_very_subtle })
highlight("TabLineSel", { fg = colors.white, bg = colors.bg_ui, gui = "bold" })
highlight("TabLineFill", { fg = colors.fg, bg = colors.bg })
highlight("CursorColumn", { bg = colors.bg_very_subtle })
highlight("CursorLine", { gui = "underline" })
highlight("ColorColumn", { bg = colors.bg_subtle })

highlight("MatchParen", { bg = colors.bg_subtle, fg = colors.fg })
highlight("qfLineNr", { fg = colors.gray4 })

local function link_highlight(from, to)
    vim.cmd(string.format('hi! link %s %s', from, to))
end

local highlight_links = {
    Normal = {
        'DapUIVariable',
        'DapUIFrameName',
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
        'GitSignsCurrentLineBlame'
    },
    Error = {
        'DapUIWatchesEmpty',
        'DapUIWatchesError',
    },
}

for to, entries in pairs(highlight_links) do
    for _, from in ipairs(entries) do
        link_highlight(from, to)
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
