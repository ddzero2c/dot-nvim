vim.cmd 'source ~/.config/nvim/vimrc'
require 'dot-nvim.lsp'
require 'dot-nvim.autocomplete'
require 'dot-nvim.debugger'
-- require 'dot-nvim.statusline'
require('nvim-tree').setup { disable_netrw = false }
-- require('fidget').setup {}

require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
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
                ['ia'] = '@parameter.inner',
                ['aa'] = '@parameter.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
    },
}

local telescope_action = require 'telescope.actions'
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-j>'] = telescope_action.move_selection_next,
                ['<C-k>'] = telescope_action.move_selection_previous,
            },
        },
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
}
require('telescope').load_extension 'fzf'
vim.cmd [[
nnoremap <leader>p <cmd>Telescope find_files find_command=rg,--ignore,--files<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
]]

require('indent_blankline').setup { show_end_of_line = true }
require('todo-comments').setup {}
require('marks').setup {}
require('colorizer').setup({ '*' }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})
require('gitsigns').setup {
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 250,
        virt_text_pos = 'eol',
    },
}
require('which-key').setup {}

require('kommentary.config').use_extended_mappings()
require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true,
})
require('kommentary.config').configure_language({ 'javascriptreact', 'typescriptreact' }, {
    single_line_comment_string = 'auto',
    multi_line_comment_strings = 'auto',
    hook_function = function()
        require('ts_context_commentstring.internal').update_commentstring()
    end,
})

require('nvim-ts-autotag').setup()
require('nvim-autopairs').setup {}

-- require('lint').linters.solhint = {
--     cmd = 'yarn',
--     stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
--     args = { 'solhint' }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
--     stream = 'stdout', -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
--     ignore_exitcode = true, -- set this to true if the linter exits with a code != 0 and that's considered normal.
--     env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
--     parser = require('lint.parser').from_pattern(
--         [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]],
--         { 'lnum', 'col', 'severity', 'message', 'code' },
--         {
--             ['error'] = vim.diagnostic.severity.ERROR,
--             ['warn'] = vim.diagnostic.severity.WARN,
--             ['warning'] = vim.diagnostic.severity.WARN,
--         },
--         {
--             source = 'solhint',
--         }
--     ),
-- }
-- require('lint').linters_by_ft = {
--     solidity = { 'solhint' },
-- }
-- vim.cmd [[au BufWritePost *.sol lua require('lint').try_lint()]]

-- local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]]
-- local groups = { 'lnum', 'col', 'severity', 'message', 'code' }
-- local severity_map = {
--   ['error'] = vim.diagnostic.severity.ERROR,
--   ['warn'] = vim.diagnostic.severity.WARN,
--   ['warning'] = vim.diagnostic.severity.WARN,
-- }

-- return {
--   cmd = 'eslint',
--   args = {},
--   stdin = false,
--   stream = 'stdout',
--   ignore_exitcode = true,
--   parser = require('lint.parser').from_pattern(pattern, groups, severity_map, { ['source'] = 'eslint' }),
-- }
require('formatter').setup({
    filetype = {
        solidity = {
            -- prettier
            function()
                return {
                    exe = "node_modules/.bin/prettier",
                    args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
                    stdin = true
                }
            end
        },
    }
})
vim.cmd 'autocmd BufWritePost *.sol FormatWrite'
