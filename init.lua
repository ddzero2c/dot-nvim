vim.cmd("source ~/.config/nvim/vimrc")
require("dot-nvim.lsp")
require("dot-nvim.autocomplete")
require("dot-nvim.debugger")
require("dot-nvim.cursorword").setup()
--require("dot-nvim.formatter")

vim.g.symbols_outline = {
	auto_preview = false,
}

require("kommentary.config").use_extended_mappings()
require("kommentary.config").configure_language("default", {
	prefer_single_line_comments = true,
})

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

local telescope_action = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = telescope_action.move_selection_next,
				["<C-k>"] = telescope_action.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
require("telescope").load_extension("fzf")
vim.cmd([[
nnoremap <leader>p <cmd>Telescope find_files find_command=rg,--ignore,--files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
]])

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
