require("cmp_nvim_lsp").setup({})
local cmp = require("cmp")
local lspkind = require("lspkind")

require("cmp_tabnine.config"):setup({
	max_lines = 1000,
	max_num_results = 20,
	sort = true,
	run_on_every_keystroke = true,
	snippet_placeholder = "..",
})

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
		{ name = "cmp_tabnine" },
	},
	formatting = {
		format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
	},
	--documentation = {
	--	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	--},
})
