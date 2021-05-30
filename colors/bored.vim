hi clear

if exists("syntax_on")
  syntax reset
endif

set fillchars+=vert:│
let colors_name = "bored"

hi Normal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi NonText ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
hi String ctermbg=NONE ctermfg=8 cterm=NONE guibg=lightgray guifg=NONE gui=NONE
hi Comment ctermbg=NONE ctermfg=NONE cterm=italic guibg=NONE guifg=#808080 gui=italic
hi Constant ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
hi Error ctermbg=15 ctermfg=9 cterm=reverse guibg=#ffffff guifg=#ec2100 gui=reverse
hi Identifier ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Special ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=#0432ff gui=bold
hi Statement ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=#505050 gui=bold
hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
hi Type ctermbg=NONE ctermfg=NONE cterm=bold,italic guibg=NONE guifg=NONE gui=bold,italic
hi Underlined ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
hi StatusLine ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
hi StatusLineNC ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
hi StatusLineTerm ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
hi StatusLineTermNC ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
hi VertSplit ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi TabLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi TabLineFill ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=NONE
hi TabLineSel ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=reverse
hi Title ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi CursorLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi LineNr ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi CursorLineNr ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Visual ctermbg=NONE ctermfg=darkcyan cterm=reverse,bold guibg=NONE guifg=darkcyan gui=reverse,bold
hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Pmenu ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=reverse
hi PmenuSbar ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=reverse
hi PmenuSel ctermbg=NONE ctermfg=darkcyan cterm=NONE guibg=NONE guifg=darkcyan gui=reverse,bold
hi PmenuThumb ctermbg=NONE ctermfg=darkcyan cterm=NONE guibg=NONE guifg=darkcyan gui=reverse
hi FoldColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Folded ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi WildMenu ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi SpecialKey ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi DiffAdd ctermbg=NONE ctermfg=NONE cterm=NONE guibg=#00db00 guifg=#ffffff gui=NONE
hi DiffChange ctermbg=NONE ctermfg=NONE cterm=NONE guibg=#0432ff guifg=#ffffff gui=NONE
hi DiffDelete ctermbg=NONE ctermfg=NONE cterm=NONE guibg=#ec2100 guifg=#ffffff gui=NONE
hi DiffText ctermbg=NONE ctermfg=NONE cterm=NONE guibg=#000000 guifg=#ffffff gui=NONE
hi IncSearch ctermbg=10 ctermfg=0 cterm=NONE guibg=#00db00 guifg=#000000 gui=NONE
hi Search ctermbg=11 ctermfg=0 cterm=NONE guibg=#eae600 guifg=#000000 gui=NONE
hi Directory ctermbg=NONE ctermfg=NONE cterm=bold guibg=NONE guifg=NONE gui=bold
hi MatchParen ctermbg=NONE ctermfg=green cterm=reverse guibg=NONE guifg=green gui=reverse
hi SpellBad ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#ec2100
hi SpellCap ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#0432ff
hi SpellLocal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#ff00ff
hi SpellRare ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE guisp=#00ffff
hi ColorColumn ctermbg=darkred ctermfg=NONE cterm=NONE guibg=darkred guifg=NONE gui=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi ModeMsg ctermbg=NONE ctermfg=10 cterm=NONE guibg=NONE guifg=NONE gui=reverse
hi MoreMsg ctermbg=NONE ctermfg=13 cterm=NONE guibg=NONE guifg=#ff00ff gui=NONE
hi Question ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi WarningMsg ctermbg=NONE ctermfg=9 cterm=NONE guibg=NONE guifg=#ec2100 gui=NONE
hi Cursor ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi CursorColumn ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi QuickFixLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi Conceal ctermbg=NONE ctermfg=8 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
hi ToolbarLine ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi ToolbarButton ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi debugPC ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
hi debugBreakpoint ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE

hi! link EndOfBuffer NonText
hi! link Number Constant
hi! link Operator Special
hi! link Function Type
hi! link Delimiter Statement
hi! link PreProc Statement
hi! link ErrorMsg Error
hi! link CursorIM Cursor
hi! link Terminal Normal

hi! link CocErrorSign ErrorMsg
hi! link CocWarningSign WarningMsg
hi! link CocInfoSign InfoMsg
hi! link CocHintSign HintMsg
hi! link CocHighlightText Search

hi! link LspReferenceText CocHighlightText
hi! link LspDiagnosticsDefaultError           ErrorMsg
hi! link LspDiagnosticsDefaultWarning         WarningMsg
hi! link LspDiagnosticsDefaultInformation     InfoMsg
hi! link LspDiagnosticsDefaultHint            HintMsg
hi! link LspDiagnosticsVirtualTextError       ErrorMsg
hi! link LspDiagnosticsVirtualTextWarning     WarningMsg
hi! link LspDiagnosticsVirtualTextInformation InfoMsg
hi! link LspDiagnosticsVirtualTextHint        HintMsg
hi! link LspDiagnosticsUnderlineError         ErrorMsg
hi! link LspDiagnosticsUnderlineWarning       WarningMsg
hi! link LspDiagnosticsUnderlineInformation   InfoMsg
hi! link LspDiagnosticsUnderlineHint          HintMsg
hi! link LspDiagnosticsFloatingError          ErrorMsg
hi! link LspDiagnosticsFloatingWarning        WarningMsg
hi! link LspDiagnosticsFloatingInformation    InfoMsg
hi! link LspDiagnosticsFloatingHint           HintMsg
hi! link LspDiagnosticsSignError              ErrorMsg
hi! link LspDiagnosticsSignWarning            WarningMsg
hi! link LspDiagnosticsSignInformation        InfoMsg
hi! link LspDiagnosticsSignHint               HintMsg

" reesitter: {{{
hi! link TSAnnotation          PreProc " For C++/Dart attributes, annotations that can be attached to the code to denote some kind of meta information.
hi! link TSAttribute           PreProc " (unstable) TODO: docs
hi! link TSBoolean             Boolean " For booleans
hi! link TSCharacter           Character " For characters
hi! link TSComment             Comment " For comments
hi! link TSConditional         Conditional " For keywords related to conditionnals
hi! link TSConstant            Constant " For constants
hi! link TSConstBuiltin        Special " For constant that are built in the language: `nil` in Lua
hi! link TSConstMacro          Define " For constants that are defined by macros: `NULL` in C
hi! link TSConstructor         Special " For constructor calls and definitions: `{}` in Lua, and Java constructors
hi! link TSEmphasis            Italic " For text to be represented with emphasis.
hi! link TSError               Error " For syntax/parser errors
hi! link TSException           Exception " For exception related keywords.
hi! link TSField               Identifier " For fields
hi! link TSFloat               Float " For floats
hi! link TSFunction            Function " For function (calls and definitions
hi! link TSFuncBuiltin         Special " For builtin functions: `table.insert` in Lua
hi! link TSFuncMacro           Macro " For macro defined fuctions (calls and definitions): each `macro_rules` in Rust.
hi! link TSInclude             Include " For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
hi! link TSKeyword             Keyword " For keywords that don't fall in other categories.
hi! link TSKeywordFunction     Keyword " For keywords used to define a fuction.
hi! link TSLabel               Label " For labels: `label:` in C and `:label:` in Lua
hi! link TSLiteral             String " Literal text.
hi! link TSMethod              Function " For method calls and definitions.
hi! link TSNamespace           Include " For identifiers referring to modules and namespaces.
hi! link TSNumber              Number " For integers
hi! link TSOperator            Operator " For any operator: `+`, but also `->` and `*` in C
hi! link TSParameter           Identifier " For parameters of a function.
hi! link TSParameterReference  Identifier " For references to parameters of a function.
hi! link TSProperty            Identifier " Same as `TSField`.
hi! link TSPunctBracket        Delimiter " For brackets and parens.
hi! link TSPunctDelimiter      Delimiter " For delimiters ie: `.`
hi! link TSPunctSpecial        Delimiter " For special punctutation that does not fall in the catagories before.
hi! link TSRepeat              Repeat " For keywords related to loops
hi! link TSString              String " For strings.
hi! link TSStringEscape        SpecialChar " For escape characters within a string.
hi! link TSStringRegex         String " For regexes.
hi! link TSStrong              bold " For text to be represented with strong.
hi! link TSTag                 Label " Tags like html tag names.
hi! link TSTagDelimiter        Label " Tag delimiter like `<` `>` `/`
" -- TSText               = { fg = yellow },  -- For strings considered text in a markup language.
hi! link TSTitle               Title " Text that is part of a title.
hi! link TSType                Type " For types.
hi! link TSTypeBuiltin         Type " For builtin types (you guessed it, right ?).
hi! link TSUnderline           Underlined " For underlined text?
hi! link TSURI                 Underlined " Any URI like a link or email.
hi! link TSVariable            Identifier " Any variable name that does not have another highlight.
hi! link TSVariableBuiltin     Special " Variable names that are defined by the languages, like `this` or `self`.
" }}
"
hi! link GitSignsAdd DiffAdd
hi! link GitSignsAddNr DiffAdd
hi! link GitSignsAddLn DiffAdd
hi! link GitSignsChange DiffChange
hi! link GitSignsChangeNr DiffChange
hi! link GitSignsChangeLn DiffChange
hi! link GitSignsDelete DiffDelete
hi! link GitSignsDeleteNr DiffDelete
hi! link GitSignsDeleteLn DiffDelete
