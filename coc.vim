let g:coc_global_extensions = [
            \'coc-stylelint', 'coc-html', 'coc-css',
            \'coc-word', 'coc-emoji', 'coc-snippets',
            \'coc-json', 'coc-yaml',
            \'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-styled-components', 'coc-react-refactor',
            \'coc-solargraph', 'coc-go',
            \'coc-lua',
            \'coc-java', 'coc-java-debug', 'coc-xml']

set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c

imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" symbol
autocmd CursorHold * silent call CocActionAsync('highlight')

command! -nargs=0 Prettier       :CocCommand prettier.formatFile
command! -nargs=0 CocRename      :call CocActionAsync('rename')
command! -nargs=0 CocFormat      :call CocActionAsync('format')
command! -nargs=? CocFold        :call CocAction('fold', <f-args>)
command! -nargs=0 CocImport      :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> gI :CocImport<CR>
nmap <silent> g= :CocFormat<CR>
xmap <silent> g= <Plug>(coc-format-selected)
nmap <silent> g= <Plug>(coc-format-selected)

nmap <silent> gR :CocRename<CR>

nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
nmap <silent> gD  :CocDiagnostics<CR>

xmap <silent> gA  <Plug>(coc-codeaction-selected)
vmap <silent> gA  <Plug>(coc-codeaction-selected)
nmap <silent> ga  <Plug>(coc-codeaction)
nmap <silent> gF  <Plug>(coc-fix-current)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"nmap <F1> :CocCommand java.debug.vimspector.start<CR>
