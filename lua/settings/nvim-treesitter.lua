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
