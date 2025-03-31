return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/cmp-emoji' },
            { 'b0o/schemastore.nvim' },
        },
        config = function() require('config.lsp') end
    },
    { "kosayoda/nvim-lightbulb", opts = { autocmd = { enabled = true } } },
    { 'olexsmir/gopher.nvim',    opts = {} },
    {
        'nvim-flutter/flutter-tools.nvim',
        opts = {
            flutter_lookup_cmd = "asdf where flutter",
            lsp = { settings = { lineLength = 100 } }
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
        'ddzero2c/aider.nvim',
        dir = '~/dev/aider.nvim',
        dependencies = {
            { 'echasnovski/mini.nvim', version = '*' },
        },
        config = function() require('config.aider') end
    },
    {
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
        'mfussenegger/nvim-dap',
        keys = {
            {
                "<F5>",
                function() require('dap').continue() end,
                desc = "Debug",
            },
            {
                "<leader>b",
                function() require('dap').toggle_breakpoint() end,
                desc = "Breakpoint",
            },
        },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function() require("config.dap") end
    },
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function() require('config.conform') end
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    { 'ntpeters/vim-better-whitespace' },
    { 'iamcco/markdown-preview.nvim',  cmd = 'MarkdownPreview' },
    { 'folke/todo-comments.nvim',      opts = {},              event = "VeryLazy" },
    { "folke/ts-comments.nvim",        opts = {},              event = "VeryLazy" },
    { 'nvimdev/indentmini.nvim',       opts = {},              event = { "BufReadPre", "BufNewFile" } },
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
