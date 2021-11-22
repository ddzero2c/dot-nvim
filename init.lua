vim.cmd("source ~/.config/nvim/vimrc")
require("dot-nvim.lsp")
require("dot-nvim.debugger")
require("dot-nvim.formatter")

vim.g.symbols_outline = {
	auto_preview = false,
}

require("mini.comment").setup({})
require("mini.completion").setup({})
require("mini.trailspace").setup({})
require("mini.cursorword").setup({})

require("nvim-tree").setup({ disable_netrw = false })

require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained",
	ignore_install = { "haskell" },
	highlight = { enable = true },
	textobjects = {
		enable = true,
		keymaps = {
			[";"] = "textsubjects-smart",
		},
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

require("indent_blankline").setup({ show_end_of_line = true })
require("todo-comments").setup({})
require("marks").setup({})
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
require("which-key").setup({})
