" Expand or jump
imap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <C-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-h>'
smap <expr> <C-h> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-h>'
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
