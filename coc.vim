"            \'coc-imselect', 'coc-highlight',
let g:coc_global_extensions = [
            \'coc-highlight',
            \'coc-stylelint', 'coc-html', 'coc-css',
            \'coc-word', 'coc-emoji', 'coc-snippets',
            \'coc-json', 'coc-yaml',
            \'coc-prettier', 'coc-eslint', 'coc-tsserver', 'coc-styled-components', 'coc-react-refactor',
            \'coc-solargraph', 'coc-go', 'coc-clangd', 'coc-lua',
            \'coc-java', 'coc-java-debug', 'coc-xml']

let g:coc_node_path = "/opt/homebrew/bin/node"

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
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
command! -nargs=0 CocFix         :call CocActionAsync('doQuickfix')

nmap <silent> <C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)
nmap <silent> gG  :CocDiagnostics<CR>

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json,sh,java,go,yaml setl formatexpr=CocAction('formatSelected')
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
    nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

"nmap <F1> :CocCommand java.debug.vimspector.start<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
