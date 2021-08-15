local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		layout_config = {
			preview_width = 0.5,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default + actions.center,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
			},
		},
	},
})
vim.cmd("nnoremap <leader>p :Telescope find_files<CR>")
vim.cmd("nnoremap <leader>g :Telescope live_grep<CR>")
