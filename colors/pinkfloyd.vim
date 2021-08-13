" Name:       pinkfloyd.vim
" Version:    0.1.0
" Maintainer: github.com/ddzero2c
" License:    The MIT License (MIT)
"
" A minimal pink colorscheme for Vim.
"
" Forked from vim-sunbather:
" https://github.com/nikolvs/vim-sunbather
"
"""
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='pinkfloyd'

let s:black           = { "gui": "#000000", "cterm": "232" }
let s:medium_gray     = { "gui": "#767676", "cterm": "243" }
let s:white           = { "gui": "#F1F1F1", "cterm": "15"  }
let s:actual_white    = { "gui": "#FFFFFF", "cterm": "231" }
let s:subtle_black    = { "gui": "#121212", "cterm": "233" }
let s:light_black     = { "gui": "#262626", "cterm": "235" }
let s:lighter_black   = { "gui": "#4E4E4E", "cterm": "239" }
let s:light_gray      = { "gui": "#A8A8A8", "cterm": "248" }
let s:lighter_gray    = { "gui": "#C6C6C6", "cterm": "251" }
let s:lightest_gray   = { "gui": "#EEEEEE", "cterm": "255" }
let s:dark_pink       = { "gui": "#ff5f87", "cterm": "204" }
let s:light_pink      = { "gui": "#d75f87", "cterm": "168" }
let s:dark_red        = { "gui": "#C30771", "cterm": "1"   }
let s:light_red       = { "gui": "#E32791", "cterm": "1"   }
let s:lightest_red    = { "gui": "#FFDCE0", "cterm": "10"  }
let s:most_red        = { "gui": "#ec2100", "cterm": "1"   }
let s:orange          = { "gui": "#D75F5F", "cterm": "167" }
let s:most_blue       = { "gui": "#0432ff", "cterm": "18"  }
let s:darker_blue     = { "gui": "#005F87", "cterm": "18"  }
let s:dark_blue       = { "gui": "#008EC4", "cterm": "32"  }
let s:blue            = { "gui": "#20BBFC", "cterm": "12"  }
let s:light_blue      = { "gui": "#b6d6fd", "cterm": "153" }
let s:dark_cyan       = { "gui": "#20A5BA", "cterm": "6"   }
let s:light_cyan      = { "gui": "#4FB8CC", "cterm": "14"  }
let s:dark_green      = { "gui": "#10A778", "cterm": "2"   }
let s:lightest_green  = { "gui": "#CAFFD8", "cterm": "10"  }
let s:light_green     = { "gui": "#5FD7A7", "cterm": "10"  }
let s:light_purple    = { "gui": "#a790d5", "cterm": "140" }
let s:yellow          = { "gui": "#F3E430", "cterm": "11"  }
let s:light_yellow    = { "gui": "#ffff87", "cterm": "228" }
let s:dark_yellow     = { "gui": "#A89C14", "cterm": "3"   }

let s:background = &background

if &background == "dark"
  let s:bg              = s:black
  let s:bg_subtle       = s:lighter_black
  let s:bg_very_subtle  = s:subtle_black
  let s:norm            = s:lighter_gray
  let s:norm_subtle     = s:medium_gray
  let s:pink            = s:light_pink
  let s:cyan            = s:light_cyan
  let s:green           = s:light_green
  let s:red             = s:light_red
  let s:visual          = s:light_pink
  let s:yellow          = s:light_yellow
  let s:string          = s:light_black
  let s:special         = s:light_blue
  let s:type            = s:lighter_gray
else
  let s:bg              = s:actual_white
  let s:bg_subtle       = s:light_gray
  let s:bg_very_subtle  = s:lightest_gray
  let s:norm            = s:black
  let s:norm_subtle     = s:lighter_black
  let s:pink            = s:dark_pink
  let s:cyan            = s:dark_cyan
  let s:green           = s:dark_green
  let s:red             = s:dark_red
  let s:visual          = s:dark_pink
  let s:yellow          = s:dark_yellow
  let s:string          = s:lightest_gray
  let s:special         = s:most_blue
  let s:type            = s:light_black
endif

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

call s:h("Normal",        {"bg": s:bg, "fg": s:norm})

" restore &background's value in case changing Normal changed &background (:help :hi-normal-cterm)
if &background != s:background
   execute "set background=" . s:background
endif

call s:h("Cursor",        {"bg": s:pink, "fg": s:norm })
call s:h("Comment",       {"fg": s:bg_subtle, "gui": "italic"})

call s:h("Constant",      {"fg": s:norm_subtle, "gui": "bold,italic"})
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link Float            Constant
call s:h("String",        {"fg": s:norm, "bg": s:string})

"call s:h("Identifier",    {"fg": s:dark_blue})
call s:h("Identifier",       {"fg": s:norm})
hi! link Delimiter        Identifier

call s:h("Statement",     {"fg": s:norm_subtle, "gui": "bold"})
hi! link Conditonal       Statement
hi! link Repeat           Statement
hi! link Label            Statement
hi! link Keyword          Statement
hi! link Exception        Statement

"call s:h("PreProc",     {"fg": s:norm_subtle})
hi! link PreProc          Statement
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h("Type",          {"fg": s:type, "gui": "bold"})
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type
hi! link Function         Type

call s:h("Special",       {"fg": s:special, "gui": "bold"})
hi! link Operator         Special
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link SpecialComment   Special
hi! link Debug            Special

call s:h("Underlined",    {"fg": s:norm, "gui": "underline", "cterm": "underline"})
call s:h("Ignore",        {"fg": s:bg})
call s:h("Error",         {"fg": s:actual_white, "bg": s:most_red, "cterm": "bold"})
call s:h("Todo",          {"fg": s:pink, "gui": "underline", "cterm": "underline"})
call s:h("SpecialKey",    {"fg": s:light_green})
call s:h("NonText",       {"fg": s:bg_very_subtle})
call s:h("Directory",     {"fg": s:dark_blue})
call s:h("ErrorMsg",      {"fg": s:most_red, "gui": "bold"})
call s:h("WarningMsg",    {"fg": s:yellow, "gui": "bold"})
call s:h("HintMsg",       {"fg": s:lighter_black})
call s:h("InfoMsg",       {"fg": s:lighter_black})
call s:h("IncSearch",     {"bg": s:bg_subtle, "fg": s:light_black})
call s:h("Search",        {"bg": s:bg_subtle, "fg": s:light_black})
call s:h("MoreMsg",       {"fg": s:medium_gray, "cterm": "bold", "gui": "bold"})
hi! link ModeMsg MoreMsg
call s:h("LineNr",        {"fg": s:bg_subtle})
call s:h("CursorLineNr",  {"fg": s:pink, "bg": s:bg_very_subtle})
call s:h("Question",      {"fg": s:red})
call s:h("StatusLine",    {"bg": s:bg_very_subtle})
call s:h("StatusLineNC",  {"bg": s:bg_very_subtle, "fg": s:medium_gray})
call s:h("VertSplit",     {"bg": s:bg_very_subtle, "fg": s:bg_very_subtle})
call s:h("Title",         {"fg": s:dark_blue})
call s:h("Visual",        {"fg": s:norm, "bg": s:visual})
call s:h("VisualNOS",     {"bg": s:bg_subtle})
call s:h("WildMenu",      {"fg": s:bg, "bg": s:norm})
call s:h("Folded",        {"fg": s:medium_gray})
call s:h("FoldColumn",    {"fg": s:bg_subtle})
call s:h("DiffAdd",       {"fg": s:black, "bg": s:lightest_green})
call s:h("DiffDelete",    {"fg": s:black, "bg": s:lightest_red})
call s:h("DiffChange",    {"fg": s:black, "bg": s:lightest_green})
call s:h("DiffText",      {"fg": s:black, "bg": s:light_green})
call s:h("SignColumn",    {"fg": s:light_green})


if has("gui_running")
  call s:h("SpellBad",    {"gui": "underline", "sp": s:red})
  call s:h("SpellCap",    {"gui": "underline", "sp": s:light_green})
  call s:h("SpellRare",   {"gui": "underline", "sp": s:light_purple})
  call s:h("SpellLocal",  {"gui": "underline", "sp": s:dark_green})
else
  call s:h("SpellBad",    {"cterm": "underline", "fg": s:red})
  call s:h("SpellCap",    {"cterm": "underline", "fg": s:light_green})
  call s:h("SpellRare",   {"cterm": "underline", "fg": s:light_purple})
  call s:h("SpellLocal",  {"cterm": "underline", "fg": s:dark_green})
endif

call s:h("Pmenu",         {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("PmenuSel",      {"fg": s:subtle_black, "bg": s:pink})
call s:h("PmenuSbar",     {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuThumb",    {"fg": s:norm, "bg": s:bg_subtle})
call s:h("TabLine",       {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("TabLineSel",    {"fg": s:subtle_black, "bg": s:pink, "gui": "bold", "cterm": "bold"})
call s:h("TabLineFill",   {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("CursorColumn",  {"bg": s:bg_very_subtle})
call s:h("CursorLine",    {"bg": s:bg_very_subtle})
call s:h("ColorColumn",   {"bg": s:bg_subtle})

call s:h("MatchParen",    {"bg": s:bg_subtle, "fg": s:norm})
call s:h("qfLineNr",      {"fg": s:medium_gray})

call s:h("htmlH1",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH2",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH3",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH4",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH5",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH6",        {"bg": s:bg, "fg": s:norm})

" Syntastic
call s:h("SyntasticWarningSign",    {"fg": s:yellow})
call s:h("SyntasticWarning",        {"bg": s:yellow, "fg": s:black, "gui": "bold", "cterm": "bold"})
call s:h("SyntasticErrorSign",      {"fg": s:red})
call s:h("SyntasticError",          {"bg": s:red, "fg": s:white, "gui": "bold", "cterm": "bold"})

" Neomake
hi link NeomakeWarningSign	SyntasticWarningSign
hi link NeomakeErrorSign	SyntasticErrorSign

" ALE
hi link ALEWarningSign	SyntasticWarningSign
hi link ALEErrorSign	SyntasticErrorSign

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
hi link GitGutterAdd                LineNr
hi link GitGutterDelete             LineNr
hi link GitGutterChange             LineNr
hi link GitGutterChangeDelete       LineNr

hi! link CocErrorSign ErrorMsg
hi! link CocWarningSign WarningMsg
hi! link CocInfoSign InfoMsg
hi! link CocHintSign HintMsg
hi! link CocHighlightText Search

hi! link GitSignsAdd DiffAdd
hi! link GitSignsAddNr DiffAdd
hi! link GitSignsAddLn DiffAdd
hi! link GitSignsChange DiffChange
hi! link GitSignsChangeNr DiffChange
hi! link GitSignsChangeLn DiffChange
hi! link GitSignsDelete DiffDelete
hi! link GitSignsDeleteNr DiffDelete
hi! link GitSignsDeleteLn DiffDelete
hi! link GitSignsCurrentLineBlame Comment

hi! link DapUIVariable Normal
hi! link DapUIScope Statement
hi! link DapUIType Type
hi! link DapUIDecoration Statement
hi! link DapUIThread Constant
hi! link DapUIStoppedThread Statement
hi! link DapUIFrameName Normal
hi! link DapUISource Type
hi! link DapUILineNumber Statement
hi! link DapUIFloatBorder Statement
hi! link DapUIWatchesHeader Statement
hi! link DapUIWatchesEmpty Error
hi! link DapUIWatchesValue Constant
hi! link DapUIWatchesError Error
hi! link DapUIBreakpointsPath Statement
hi! link DapUIBreakpointsInfo Constant
hi! link DapUIBreakpointsCurrentLine Constant
hi! link DapUIBreakpointsLine DapUILineNumber

hi! link TSConstructor Function
