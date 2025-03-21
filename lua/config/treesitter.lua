require 'treesitter-context'.setup {
    max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'inner',
}
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "yaml", "json", "javascript", "typescript", "html", "css", "scss", "jsonc", "json5", "tsx",
        "go", "dart", "python", "rust", "java", "php", "ruby", "bash", "lua", "dockerfile", "graphql",
    },
    -- autotag = {
    --     enable = true,
    -- },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
    },
    textobjects = {
        select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ia"] = "@parameter.inner",
                ["aa"] = "@parameter.outer",
                ["ir"] = "@return.inner",
                ["ar"] = "@return.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
                ["<leader>r"] = "@return.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
                ["<leader>R"] = "@return.outer",
            },
        },
    },
})

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
