" Leader Key Maps
let g:mapleader = "\<Space>"

" Timeout
let g:which_key_timeout = 100
let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆', " ": 'SPC'}

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_map =  {}
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map['e'] = [ ':NvimTreeToggle',        'explorer' ]
let g:which_key_map['?'] = [ ':NvimTreeFindFile',      'find current file' ]
let g:which_key_map['p'] = [ ':Telescope find_files',  'find files' ]
let g:which_key_map['g'] = [ ':Telescope live_grep',   'file text' ]
let g:which_key_map['M'] = [ ':MarkdownPreviewToggle', 'markdown preview']
let g:which_key_map['f'] = [ ':CocFormat',             'format file' ]
let g:which_key_map['a'] = [ ':CocAction',             'code action' ]
let g:which_key_map['r'] = [ ':CocRename',             'rename symbol' ]
let g:which_key_map['q'] = [ ':CocFix',                'quick fix' ]
let g:which_key_map['i'] = [ ':CocImport',             'organize import' ]

call which_key#register('<Space>', "g:which_key_map")
