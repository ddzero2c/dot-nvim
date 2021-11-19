require("cmp_nvim_lsp").setup({})
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	--preselect = cmp.PreselectMode.None,
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-j>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "path" },
		{ name = "buffer", opts = {
			get_bufnrs = function()
				return vim.api.nvim_list_bufs()
			end,
		} },
		{ name = "emoji" },
	},
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = false,
			menu = {
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				vsnip = "[VSnip]",
				path = "[Path]",
				buffer = "[Buffer]",
				emoji = "[Emoji]",
			},
		}),
	},
	--documentation = {
	--	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--},
})

vim.cmd([[
imap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
smap <expr> <C-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'
imap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
smap <expr> <C-k>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<C-k>'
]])
