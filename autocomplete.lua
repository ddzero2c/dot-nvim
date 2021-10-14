require("cmp_nvim_lsp").setup({})
local cmp = require("cmp")

cmp.setup({
	--preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		--["<C-k>"] = cmp.mapping.complete(),
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
		{ name = "buffer" },
		{ name = "emoji" },
	},
	formatting = {
		format = require("lspkind").cmp_format({
			with_text = true,
		}),
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
})
