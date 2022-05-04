if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
    finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
    let s = '%#TabLineFill# > '
    for i in range(tabpagenr('$'))
        let tab = i + 1
        let winnr = tabpagewinnr(tab)
        let buflist = tabpagebuflist(tab)
        let bufnr = buflist[winnr - 1]
        let bufname = bufname(bufnr)
        let bufmodified = getbufvar(bufnr, "&mod")

        let s .= '%' . tab . 'T'

        let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let s .= ' ' . tab .' '
        if bufmodified
            let s .= '[+]'
        endif
        let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
    endfor

    let s .= '%#TabLineFill#'
    return s
endfunction
set tabline=%!Tabline()
