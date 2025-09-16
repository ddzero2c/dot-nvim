return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'saghen/blink.cmp',
                version = '1.*',
                dependencies = { 'rafamadriz/friendly-snippets' },
                opts_extend = { "sources.default" }
            },
            { 'b0o/schemastore.nvim' },
        },
        config = function() require('config.lsp') end
    },
    {
        "ray-x/go.nvim",
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", 'gomod' },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    { 'kosayoda/nvim-lightbulb',       opts = { autocmd = { enabled = true } } },
    -- { 'j-hui/fidget.nvim',       opts = { notification = { override_vim_notify = true } } },
    {
        'nvim-flutter/flutter-tools.nvim',
        opts = {
            flutter_lookup_cmd = "asdf where flutter",
            lsp = {
                settings = { lineLength = 100 },
                capabilities = { textDocument = { formatting = { dynamicRegistration = false } } },
            }
        }
    },
    {
        "pmizio/typescript-tools.nvim",
        opts = {
            {
                settings = {
                    tsserver_file_preferences = {
                        includeInlayParameterNameHints = "all",
                        includeCompletionsForModuleExports = true,
                        quotePreference = "auto"
                    }
                }
            }
        }
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.trail_space,
                    null_ls.builtins.formatting.pg_format,
                    require("none-ls.diagnostics.eslint"),
                },
            })
        end
    },
    {
        "supermaven-inc/supermaven-nvim",
        opts = {
            keymaps = {
                accept_suggestion = "<C-j>",
                clear_suggestion = "<C-e>",
                accept_word = "<M-j>",
            },
        }
    },
    -- {
    --     'github/copilot.vim',
    --     event = "VeryLazy",
    --     config = function()
    --         vim.g.copilot_no_tab_map = true
    --         vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
    --             expr = true,
    --             replace_keycodes = false
    --         })
    --         -- vim.keymap.set('i', '<Tab>', '<Plug>(copilot-next)')
    --         -- vim.keymap.set('i', '<S-Tab>', '<Plug>(copilot-previous)')
    --     end
    -- },
    {
        "coder/claudecode.nvim",
        opts = {
            diff_opts = { vertical_split = false, },
            terminal = {
                provider = "external",
                provider_opts = {
                    external_terminal_cmd = "echo 'Claude running externally' # %s" -- Dummy command
                }
            }
        },
        config = true,
        keys = {
            { "<leader>a", "<cmd>ClaudeCodeStatus<cr>",     desc = "Claude Code" },
            -- { "<leader>a",  "<cmd>ClaudeCodeStatus<cr>", desc = "AI/Claude Code" },
            { "ga",        "<cmd>ClaudeCodeSend<cr>",       mode = "v",          desc = "Send to Claude" },
            { "ga",        "<cmd>ClaudeCodeAdd %<cr>",      mode = "n",          desc = "Add current buffer" },
            -- Diff management
            { "gy",        "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "gn",        "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
        },
    },
    {
        'mfussenegger/nvim-dap',
        keys = {
            { desc = "Debug",      "<F5>",      function() require('dap').continue() end },
            { desc = "Breakpoint", "<leader>b", function() require('dap').toggle_breakpoint() end },
        },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function() require("config.dap") end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    { 'ntpeters/vim-better-whitespace' },
    { 'folke/todo-comments.nvim',      opts = {},                              event = "VeryLazy" },
    { "folke/ts-comments.nvim",        opts = {},                              event = "VeryLazy" },
    { 'nvimdev/indentmini.nvim',       opts = {},                              event = { "BufReadPre", "BufNewFile" } },
    { 'tpope/vim-fugitive',            event = "CmdLineEnter" },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            current_line_blame = false,
            current_line_blame_opts = {
                delay = 250,
                virt_text_pos = "eol",
            },
        },
    },
    {
        'stevearc/oil.nvim',
        opts = {
            use_default_keymaps = false,
            keymaps = {
                ["<CR>"] = "actions.select",
            }
        }
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/nvim-treesitter-context' },
        },
        build = ':TSUpdate',
        config = function() require('config.treesitter') end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        cmd = 'Telescope',
        keys = {
            {
                "<leader>p",
                function() require("telescope.builtin").find_files({ border = false }) end,
                desc = "FindFiles",
            },
        },
        config = function() require("config.telescope") end,
    },
    {
        'uga-rosa/ccc.nvim',
        opts = { highlighter = { auto_enable = true, lsp = true } },
        event = "UIEnter",
    },
    {
        'laytan/cloak.nvim',
        opts = {
            enabled = true,
            cloak_character = "*",
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = {
                        ".env*",
                        "wrangler.toml",
                        ".dev.vars",
                    },
                    cloak_pattern = "=.+"
                },
            },
        },
        config = function(_, opts)
            require("cloak").setup(opts)
            vim.api.nvim_set_keymap("n", "<leader>i", "<cmd>CloakToggle<cr>",
                { noremap = true, silent = true })
        end,
    },
}
