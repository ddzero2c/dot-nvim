vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = 'enable',
	throttle_time = 80,
	source_timeout = 200,
	resolve_timeout = 800,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,
    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        ultisnips = true;
    }
}

vim.cmd([[
    inoremap <silent><expr> <C-j>     compe#confirm('<CR>')
    inoremap <silent><expr> <C-e>     compe#close('<C-e>')
    inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
    inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
    imap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    smap <expr> <C-j> vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
    imap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
    smap <expr> <C-k> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
]])
