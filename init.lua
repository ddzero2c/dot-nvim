vim.cmd("source ~/.config/nvim/vimrc")
vim.cmd("luafile ~/.config/nvim/statusline.lua")
vim.cmd("luafile ~/.config/nvim/lsp.lua")
vim.cmd("luafile ~/.config/nvim/autocomplete.lua")
vim.cmd("luafile ~/.config/nvim/debugger.lua")

require("nvim-tree").setup({ disable_netrw = false })
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

local vgit = require("vgit")
local utils = require("vgit.utils")
vgit.setup({
	debug = false, -- Only enable this to trace issues related to the app,
	keymaps = {
		["n <C-k>"] = "hunk_up",
		["n <C-j>"] = "hunk_down",
		["n <leader>g"] = "actions",
		["n <leader>gs"] = "buffer_hunk_stage",
		["n <leader>gr"] = "buffer_hunk_reset",
		["n <leader>gp"] = "buffer_hunk_preview",
		["n <leader>gb"] = "buffer_blame_preview",
		["n <leader>gf"] = "buffer_diff_preview",
		["n <leader>gh"] = "buffer_history_preview",
		["n <leader>gu"] = "buffer_reset",
		["n <leader>gg"] = "buffer_gutter_blame_preview",
		["n <leader>gd"] = "project_diff_preview",
		["n <leader>gq"] = "project",
		["n <leader>gx"] = "toggle_diff_preference",
	},
	controller = {
		hunks_enabled = true,
		blames_enabled = true,
		diff_strategy = "index",
		diff_preference = "vertical",
		predict_hunk_signs = true,
		predict_hunk_throttle_ms = 300,
		predict_hunk_max_lines = 50000,
		blame_line_throttle_ms = 150,
		action_delay_ms = 300,
	},
	render = {
		layout = vgit.layouts.default,
		sign = {
			priority = 10,
			hls = {
				add = "VGitSignAdd",
				remove = "VGitSignRemove",
				change = "VGitSignChange",
			},
		},
		line_blame = {
			hl = "Comment",
			format = function(blame, git_config)
				local config_author = git_config["user.name"]
				local author = blame.author
				if config_author == author then
					author = "You"
				end
				local time = os.difftime(os.time(), blame.author_time) / (24 * 60 * 60)
				local time_format = string.format("%s days ago", utils.round(time))
				local time_divisions = { { 24, "hours" }, { 60, "minutes" }, { 60, "seconds" } }
				local division_counter = 1
				while time < 1 and division_counter ~= #time_divisions do
					local division = time_divisions[division_counter]
					time = time * division[1]
					time_format = string.format("%s %s ago", utils.round(time), division[2])
					division_counter = division_counter + 1
				end
				local commit_message = blame.commit_message
				if not blame.committed then
					author = "You"
					commit_message = "Uncommitted changes"
					local info = string.format("%s • %s", author, commit_message)
					return string.format(" %s", info)
				end
				local max_commit_message_length = 255
				if #commit_message > max_commit_message_length then
					commit_message = commit_message:sub(1, max_commit_message_length) .. "..."
				end
				local info = string.format("%s, %s • %s", author, time_format, commit_message)
				return string.format(" %s", info)
			end,
		},
	},
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
