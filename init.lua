vim.cmd("source ~/.config/nvim/vimrc")
vim.cmd("luafile ~/.config/nvim/statusline.lua")
vim.cmd("luafile ~/.config/nvim/lsp.lua")
vim.cmd("luafile ~/.config/nvim/autocomplete.lua")
vim.cmd("luafile ~/.config/nvim/debugger.lua")
vim.cmd("luafile ~/.config/nvim/formatter.lua")

require("nvim-tree").setup({ disable_netrw = false })
require("nvim-ts-autotag").setup()
require("kommentary.config").use_extended_mappings()
vim.g.symbols_outline = {
	auto_preview = false,
}

require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "haskell" },
	highlight = { enable = true },
})

require("nvim-treesitter.configs").setup({
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
	},
})
require("nvim-treesitter.configs").setup({
	textsubjects = {
		enable = true,
		keymaps = {
			[";"] = "textsubjects-smart",
		},
	},
})

require("indent_blankline").setup({
	show_end_of_line = true,
})
require("todo-comments").setup({
	prefer_single_line_comments = true,
})

require("colorizer").setup({ "*" }, {
	RGB = true, -- #RGB hex codes
	RRGGBB = true, -- #RRGGBB hex codes
	RRGGBBAA = true, -- #RRGGBBAA hex codes
	rgb_fn = true, -- CSS rgb() and rgba() functions
	hsl_fn = true, -- CSS hsl() and hsla() functions
	css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 250,
		virt_text_pos = "eol",
	},
})
