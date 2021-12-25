require('cmp_nvim_lsp').setup()
local cmp = require 'cmp'
local lspkind = require 'lspkind'

vim.cmd [[
set completeopt=menu,menuone,noselect
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
]]

cmp.setup {
	-- completion = {
	-- 	autocomplete = true,
	-- },
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable,
		['<C-e>'] = cmp.mapping {
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		},
		['<C-j>'] = cmp.mapping.confirm { select = true },
		['<C-x><C-s>'] = cmp.mapping.complete {
			config = {
				sources = {
					{ name = 'vsnip' },
				},
			},
		},
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer', option = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end,
		} },
		{ name = 'emoji' },
	},
	formatting = {
		format = lspkind.cmp_format {
			-- with_text = false,
			-- menu = {
			-- 	vsnip = "[vsnip]",
			-- 	nvim_lsp = "[lsp]",
			-- 	nvim_lua = "[lua]",
			-- 	path = "[path]",
			-- 	buffer = "[buf]",
			-- 	emoji = "[emoji]",
			-- },
		},
	},
	--documentation = {
	--	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--},
}

-- _G.vimrc = _G.vimrc or {}
-- _G.vimrc.cmp = _G.vimrc.cmp or {}
-- _G.vimrc.cmp.lsp = function()
-- 	cmp.complete {
-- 		config = {
-- 			sources = {
-- 				{ name = 'nvim_lsp' },
-- 				{ name = 'nvim_lsp_signature_help' },
-- 				{ name = 'nvim_lua' },
-- 			},
-- 		},
-- 	}
-- end
-- _G.vimrc.cmp.snippet = function()
-- 	cmp.complete {
-- 		config = {
-- 			sources = {
-- 				{ name = 'vsnip' },
-- 				{
-- 					name = 'buffer',
-- 					option = {
-- 						get_bufnrs = function()
-- 							return vim.api.nvim_list_bufs()
-- 						end,
-- 					},
-- 				},
-- 				{ name = 'emoji' },
-- 			},
-- 		},
-- 	}
-- end
-- _G.vimrc.cmp.path = function()
-- 	cmp.complete {
-- 		config = {
-- 			sources = {
-- 				{ name = 'path' },
-- 			},
-- 		},
-- 	}
-- end

-- vim.cmd [[
--   inoremap <C-x><C-o> <Cmd>lua vimrc.cmp.lsp()<CR>
--   inoremap <C-x><C-s> <Cmd>lua vimrc.cmp.snippet()<CR>
--   inoremap <C-x><C-f> <Cmd>lua vimrc.cmp.path()<CR>
-- ]]

vim.cmd [[
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

]]
