hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='single'

let s:black           = { "gui": "#000000"}
let s:medium_gray     = { "gui": "#767676"}
let s:white           = { "gui": "#F1F1F1"}
let s:actual_white    = { "gui": "#FFFFFF"}
let s:subtle_black    = { "gui": "#121212"}
let s:light_black     = { "gui": "#262626"}
let s:lighter_black   = { "gui": "#4E4E4E"}
let s:light_gray      = { "gui": "#A8A8A8"}
let s:lighter_gray    = { "gui": "#C6C6C6"}
let s:lightest_gray   = { "gui": "#DEDEDE"}
let s:red             = { "gui": "#C30771"}
let s:lightest_red    = { "gui": "#FCD5D2"}
let s:most_red        = { "gui": "#ec2100"}
let s:dark_blue       = { "gui": "#008EC4"}
let s:blue            = { "gui": "#20BBFC"}
let s:green           = { "gui": "#10A778"}
let s:lightest_green  = { "gui": "#CAFFD8"}
let s:light_green     = { "gui": "#5FD7A7"}
let s:light_purple    = { "gui": "#a790d5"}
let s:yellow          = { "gui": "#A89C14"}

let s:bg              = { "gui": "#eaeaea"}
let s:bg_subtle       = s:light_gray
let s:bg_very_subtle  = s:lightest_gray
let s:bg_ui           = s:medium_gray
let s:fg              = s:black
let s:fg_subtle       = s:lighter_black

let s:main            = { "gui": "#a94dbb"}

let s:string          = s:lightest_gray
let s:type            = s:light_black

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
endfunction

let s:background = &background
if &background != s:background
   execute "set background=" . s:background
endif

call s:h("Normal",                        {"fg": s:fg,        "bg": s:bg      })
call s:h("String",                        {"fg": s:fg,        "bg": s:string  })
call s:h("Cursor",                        {"fg": s:fg,        "bg": s:bg_ui   })
call s:h("Comment",                       {"fg": s:bg_subtle, "gui": "italic" })

call s:h("Constant",                      {"fg": s:fg_subtle, "gui": "bold,italic"})
hi! link Character                        Constant
hi! link Number                           Constant
hi! link Boolean                          Constant
hi! link Float                            Constant

call s:h("Identifier",                    {"fg": s:fg})
hi! link Delimiter                        Identifier
hi! link Function                         Identifier

call s:h("Statement",                     {"fg": s:fg_subtle, "gui": "bold"})
hi! link Conditonal                       Statement
hi! link Repeat                           Statement
hi! link Label                            Statement
hi! link Keyword                          Statement
hi! link Exception                        Statement
hi! link PreProc                          Statement
hi! link Include                          Statement
hi! link Define                           Statement
hi! link Macro                            Statement
hi! link PreCondit                        Statement

call s:h("Type",                          {"fg": s:type, "gui": "bold"})
hi! link StorageClass                     Type
hi! link Structure                        Type
hi! link Typedef                          Type

call s:h("Special",                       {"fg": s:main, "gui": "bold"})
hi! link Operator                         Special
hi! link SpecialChar                      Special
hi! link Tag                              Special
hi! link SpecialComment                   Special
hi! link Debug                            Special

call s:h("LspCodeLens",                   {"fg": s:bg_subtle, "gui": "underline"})
call s:h("Underlined",                    {"fg": s:fg, "gui": "underline"})
call s:h("Ignore",                        {"fg": s:bg})
call s:h("Error",                         {"fg": s:actual_white, "bg": s:most_red})
call s:h("Todo",                          {"fg": s:main, "gui": "underline"})
call s:h("SpecialKey",                    {"fg": s:light_green})
call s:h("NonText",                       {"fg": s:bg_very_subtle})
call s:h("Directory",                     {"fg": s:dark_blue})
call s:h("ErrorMsg",                      {"fg": s:most_red, "gui": "bold"})
call s:h("WarningMsg",                    {"fg": s:yellow, "gui": "bold"})
call s:h("HintMsg",                       {"fg": s:fg})
call s:h("InfoMsg",                       {"fg": s:fg})
call s:h("IncSearch",                     {"bg": s:main, "fg": s:white})
call s:h("Search",                        {"bg": s:main, "fg": s:white})
call s:h("MoreMsg",                       {"fg": s:medium_gray, "gui": "bold"})
hi! link ModeMsg MoreMsg
call s:h("LineNr",                        {"fg": s:bg_subtle})
call s:h("CursorLineNr",                  {"fg": s:main, "bg": s:bg_very_subtle})
call s:h("Question",                      {"fg": s:red})
call s:h("StatusLine",                    {"fg": s:white, "bg": s:bg_ui})
call s:h("StatusLineNC",                  {"fg": s:white, "bg": s:bg_subtle })
call s:h("VertSplit",                     {"fg": s:white, "bg": s:bg_ui })
call s:h("Title",                         {"fg": s:dark_blue})
call s:h("Visual",                        {"fg": s:white, "bg": s:bg_ui})
call s:h("VisualNOS",                     {"bg": s:bg_subtle})
call s:h("WildMenu",                      {"fg": s:bg, "bg": s:fg})
call s:h("Folded",                        {"fg": s:medium_gray})
call s:h("FoldColumn",                    {"fg": s:bg_subtle})
call s:h("DiffAdd",                       {"fg": s:black, "bg": s:lightest_green})
call s:h("DiffDelete",                    {"fg": s:black, "bg": s:lightest_red})
call s:h("DiffChange",                    {"fg": s:black, "bg": s:lightest_green})
call s:h("DiffText",                      {"fg": s:black, "bg": s:light_green})
call s:h("SignColumn",                    {"fg": s:light_green})

call s:h("SpellBad",                      {"gui": "underline", "sp": s:red})
call s:h("SpellCap",                      {"gui": "underline", "sp": s:light_green})
call s:h("SpellRare",                     {"gui": "underline", "sp": s:light_purple})
call s:h("SpellLocal",                    {"gui": "underline", "sp": s:green})

call s:h("Pmenu",                         {"fg": s:fg, "bg": s:bg_very_subtle})
call s:h("PmenuSel",                      {"fg": s:fg, "bg": s:bg_subtle, "gui": "bold"})
call s:h("PmenuSbar",                     {"fg": s:fg, "bg": s:bg_very_subtle})
call s:h("PmenuThumb",                    {"fg": s:fg, "bg": s:bg_ui})
hi! link FloatBorder Pmenu

call s:h("TabLine",                       {"fg": s:fg,  "bg": s:bg_very_subtle})
call s:h("TabLineSel",                    {"fg": s:white, "bg": s:bg_ui, "gui": "bold"})
call s:h("TabLineFill",                   {"fg": s:fg,  "bg": s:bg_very_subtle})
call s:h("CursorColumn",                  {"bg": s:bg_very_subtle})
call s:h("CursorLine",                    {"bg": s:bg_very_subtle})
call s:h("ColorColumn",                   {"bg": s:bg_subtle})

call s:h("MatchParen",                    {"bg": s:bg_subtle, "fg": s:fg})
call s:h("qfLineNr",                      {"fg": s:medium_gray})

" Syntastic
call s:h("SyntasticWarningSign",          {"fg": s:yellow})
call s:h("SyntasticWarning",              {"bg": s:yellow, "fg": s:black, "gui": "bold"})
call s:h("SyntasticErrorSign",            {"fg": s:red})
call s:h("SyntasticError",                {"bg": s:red, "fg": s:white, "gui": "bold"})

" Neomake
hi link NeomakeWarningSign                SyntasticWarningSign
hi link NeomakeErrorSign                  SyntasticErrorSign

" ALE
hi link ALEWarningSign                    SyntasticWarningSign
hi link ALEErrorSign                      SyntasticErrorSign

" Signify, git-gutter
hi link SignifySignAdd                    LineNr
hi link SignifySignDelete                 LineNr
hi link SignifySignChange                 LineNr
hi link GitGutterAdd                      LineNr
hi link GitGutterDelete                   LineNr
hi link GitGutterChange                   LineNr
hi link GitGutterChangeDelete             LineNr

hi! link CocErrorSign                     ErrorMsg
hi! link CocWarningSign                   WarningMsg
hi! link CocInfoSign                      InfoMsg
hi! link CocHintSign                      HintMsg
hi! link CocHighlightText                 Search

hi! link NotifyERRORBorder                Normal
hi! link NotifyWARNBorder                 Normal
hi! link NotifyINFOBorder                 Normal
hi! link NotifyDEBUGBorder                Normal
hi! link NotifyTRACEBorder                Normal
hi! link NotifyERRORIcon                  ErrorMsg
hi! link NotifyWARNIcon                   WarningMsg
hi! link NotifyINFOIcon                   InfoMsg
hi! link NotifyDEBUGIcon                  Normal
hi! link NotifyTRACEIcon                  HintMsg
hi! link NotifyERRORTitle                 ErrorMsg
hi! link NotifyWARNTitle                  WarningMsg
hi! link NotifyINFOTitle                  InfoMsg
hi! link NotifyDEBUGTitle                 Normal
hi! link NotifyTRACETitle                 HintMsg
hi! link NotifyERRORBody                  Normal
hi! link NotifyWARNBody                   Normal
hi! link NotifyINFOBody                   Normal
hi! link NotifyDEBUGBody                  Normal
hi! link NotifyTRACEBody                  Normal

hi! link GitSignsAdd                      DiffAdd
hi! link GitSignsAddNr                    DiffAdd
hi! link GitSignsAddLn                    DiffAdd
hi! link GitSignsChange                   DiffChange
hi! link GitSignsChangeNr                 DiffChange
hi! link GitSignsChangeLn                 DiffChange
hi! link GitSignsDelete                   DiffDelete
hi! link GitSignsDeleteNr                 DiffDelete
hi! link GitSignsDeleteLn                 DiffDelete
hi! link GitSignsCurrentLineBlame         Comment

hi! link VGitViewSignAdd                  DiffAdd
hi! link VGitSignAdd                      DiffAdd
hi! link VGitViewSignRemove               DiffDelete
hi! link VGitSignRemove                   DiffDelete
hi! link VGitSignChange                   DiffChange

hi! link DapUIVariable                    Normal
hi! link DapUIScope                       Statement
hi! link DapUIType                        Type
hi! link DapUIDecoration                  Statement
hi! link DapUIThread                      Constant
hi! link DapUIStoppedThread               Statement
hi! link DapUIFrameName                   Normal
hi! link DapUISource                      Type
hi! link DapUILineNumber                  Statement
hi! link DapUIFloatBorder                 Statement
hi! link DapUIWatchesHeader               Statement
hi! link DapUIWatchesEmpty                Error
hi! link DapUIWatchesValue                Constant
hi! link DapUIWatchesError                Error
hi! link DapUIBreakpointsPath             Statement
hi! link DapUIBreakpointsInfo             Constant
hi! link DapUIBreakpointsCurrentLine      Constant
hi! link DapUIBreakpointsLine             DapUILineNumber
hi! link TSConstructor                    Function

hi! link LspDiagnosticsDefaultInformation InfoMsg
hi! link LspDiagnosticsDefaultHint        InfoHint

hi! link LspReferenceText                 Visual
hi! link LspReferenceRead                 Visual
hi! link LspReferenceWrite                Visual

hi! link CmpItemAbbrDefault               Pmenu

" Highlight characters your input matches
hi! link TelescopeMatching                Visual

hi! link htmlTag                          Special
hi! link htmlEndTag                       htmlTag
hi! link htmlTagName                      KeyWord
hi! link htmlTagN                         Keyword

" HTML content
call s:h("htmlH1",                        { "fg": s:fg,          "gui": "bold,reverse" })
call s:h("htmlH2",                        { "fg": s:fg,          "gui": "reverse"      })
call s:h("htmlH3",                        { "fg": s:fg,          "gui": "bold"         })
call s:h("htmlH4",                        { "fg": s:fg,          "gui": "italic"       })
call s:h("htmlH5",                        { "fg": s:fg                                 })
call s:h("htmlH6",                        { "fg": s:fg                                 })
call s:h("htmlLink",                      { "fg": s:blue,        "gui": "underline"    })
call s:h("htmlItalic",                    { "gui": "italic"                            })
call s:h("htmlBold",                      { "gui": "bold"                              })
call s:h("htmlBoldItalic",                { "gui": "bold,italic"                       })
call s:h("markdownBlockquote",            { "fg": s:fg                                 })
call s:h("markdownBold",                  { "fg": s:fg,          "gui": "bold"         })
call s:h("markdownBoldItalic",            { "fg": s:fg,          "gui": "bold,italic"  })
call s:h("markdownEscape",                { "fg": s:fg                                 })
call s:h("markdownH1",                    { "fg": s:fg,          "gui": "bold,reverse" })
call s:h("markdownH1Delimiter",           { "fg": s:fg,          "gui": "bold,reverse" })
call s:h("markdownH2",                    { "fg": s:fg,          "gui": "reverse"      })
call s:h("markdownH2Delimiter",           { "fg": s:fg,          "gui": "reverse"      })
call s:h("markdownH3",                    { "fg": s:fg,          "gui": "bold"         })
call s:h("markdownH3Delimeter",           { "fg": s:fg,          "gui": "bold"         })
call s:h("markdownH4",                    { "fg": s:fg,          "gui": "italic"       })
call s:h("markdownH4Delimiter",           { "fg": s:fg,          "gui": "italic"       })
call s:h("markdownH5",                    { "fg": s:fg                                 })
call s:h("markdownH5Delimiter",           { "fg": s:fg                                 })
call s:h("markdownH6",                    { "fg": s:fg                                 })
call s:h("markdownH6Delimiter",           { "fg": s:fg                                 })
call s:h("markdownHeadingDelimiter",      { "fg": s:fg                                 })
call s:h("markdownHeadingRule",           { "fg": s:fg                                 })
call s:h("markdownId",                    { "fg": s:medium_gray                        })
call s:h("markdownIdDeclaration",         { "fg": s:fg_subtle                          })
call s:h("markdownItalic",                { "fg": s:fg,          "gui": "italic"       })
call s:h("markdownLinkDelimiter",         { "fg": s:medium_gray                        })
call s:h("markdownLinkText",              { "fg": s:fg                                 })
call s:h("markdownLinkTextDelimiter",     { "fg": s:medium_gray                        })
call s:h("markdownListMarker",            { "fg": s:fg                                 })
call s:h("markdownOrderedListMarker",     { "fg": s:fg                                 })
call s:h("markdownRule",                  { "fg": s:fg                                 })
call s:h("markdownUrl",                   { "fg": s:medium_gray, "gui": "underline"    })
call s:h("markdownUrlDelimiter",          { "fg": s:medium_gray                        })
call s:h("markdownUrlTitle",              { "fg": s:fg                                 })
call s:h("markdownUrlTitleDelimiter",     { "fg": s:medium_gray                        })
call s:h("markdownCode",                  { "fg": s:fg,          "bg": s:string        })
call s:h("markdownCodeDelimiter",         { "fg": s:fg,          "bg": s:string        })
