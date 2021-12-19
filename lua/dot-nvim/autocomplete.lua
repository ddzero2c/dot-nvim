require("cmp_nvim_lsp").setup()
local cmp = require("cmp")
local lspkind = require("lspkind")

vim.cmd([[
set completeopt=menu,menuone,noselect
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']
]])

cmp.setup({
	-- preselect = cmp.PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-y>"] = cmp.config.disable,
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
		["<C-x><C-s>"] = cmp.mapping.complete({
			config = {
				sources = {
					{ name = "vsnip" },
				},
			},
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer", option = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end,
		} },
		{ name = "emoji" },
	},
	formatting = {
		format = lspkind.cmp_format({
			-- with_text = false,
			-- menu = {
			-- 	vsnip = "[vsnip]",
			-- 	nvim_lsp = "[lsp]",
			-- 	nvim_lua = "[lua]",
			-- 	path = "[path]",
			-- 	buffer = "[buf]",
			-- 	emoji = "[emoji]",
			-- },
		}),
	},
	--documentation = {
	--	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--},
})

-- require("lsp_signature").setup({
-- 	hint_enable = false,
-- 	transpancy = 5,
-- })
vim.cmd([[
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
]])
