vim.o.completeopt = "menu,menuone"

require("compe").setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "disable",
	throttle_time = 80,
	source_timeout = 200,
	resolve_timeout = 800,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = {
		--border = Border,
		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
		max_width = 120,
		min_width = 60,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1,
	},

	source = {
		path = true,
		buffer = true,
		calc = false,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = true,
		ultisnips = false,
		luasnip = false,
	},
})

vim.cmd([[
inoremap <expr> <C-k>             compe#complete()
inoremap <silent><expr> <C-j>     compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
]])