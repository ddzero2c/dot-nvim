require('config.colorscheme')
require('config.lazy')
require('config.settings')

require('lazy').setup {
    {
        'akinsho/flutter-tools.nvim',
        ft = 'dart',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = true,
        otps = {},
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
            "folke/neodev.nvim",
        },
        opts = {},
    },
    {
        'ddzero2c/go-embedded-sql.nvim',
        ft = 'go',
        config = function()
            vim.keymap.set("n", "<leader>sf", require('go-embedded-sql').format_sql)
            vim.keymap.set("v", "<leader>sf", require('go-embedded-sql').format_sql_visual)
        end,
    },
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        opts = {},
    },
    {
        'neovim/nvim-lspconfig',
        event = "VeryLazy",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'kosayoda/nvim-lightbulb' },
            { 'b0o/schemastore.nvim' },
        },
        main = 'config.lsp',
        opts = {},
    },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-vsnip' },
            { 'uga-rosa/cmp-dictionary' },
            { 'onsails/lspkind-nvim' },
            { 'petertriho/cmp-git' },
        },
        config = function()
            require('config.cmp')
        end
    },
    {
        'github/copilot.vim',
        event = "VeryLazy",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap('i', '<C-Y>', 'copilot#Accept("<CR>")', { expr = true, silent = true })
        end
    },
    {
        'mfussenegger/nvim-dap',
        keys = {
            {
                "<F5>",
                function()
                    require('dap').continue()
                end,
                desc = "Debug",
            },
            {
                "<leader>b",
                function()
                    require('dap').toggle_breakpoint()
                end,
                desc = "Breakpoint",
            },
        },
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            require("config.dap")
        end
    },
    -- {
    --     'stevearc/overseer.nvim',
    --     opts = {
    --         dap = false,
    --     },
    -- },
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require('config.conform')
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    { 'ntpeters/vim-better-whitespace' },
    { 'iamcco/markdown-preview.nvim',  cmd = 'MarkdownPreview' },
    { 'tpope/vim-fugitive',            event = "CmdLineEnter" },
    { 'jinh0/eyeliner.nvim',           opts = {} },
    { 'folke/todo-comments.nvim',      opts = {} },
    { "shellRaining/hlchunk.nvim",     event = "UIEnter",      opts = {} },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 250,
                virt_text_pos = "eol",
            },
        },
    },
    {
        'windwp/nvim-ts-autotag',
        ft = {
            'astro', 'glimmer', 'handlebars', 'html', 'javascript', 'jsx', 'markdown',
            'php', 'rescript', 'svelte', 'tsx', 'typescript', 'vue', 'xml'
        },
    },
    {
        'b3nj5m1n/kommentary',
        event = "VeryLazy",
        dependencies = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        },
        config = function()
            require("config.kommentary")
        end
    },
    { 'stevearc/oil.nvim', opts = { use_default_keymaps = false } },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/playground' },
            { 'nvim-treesitter/nvim-treesitter-context' },
        },
        main = 'config.treesitter',
        opts = {},
        build = ':TSUpdate'
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        cmd = 'Telescope',
        keys = {
            {
                "<leader>p",
                function() require("telescope.builtin").find_files() end,
                desc = "FindFiles",
            },
        },
        config = function()
            require("config.telescope")
        end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        init = function()
            vim.o.termguicolors = true
        end,
        config = function()
            require("colorizer").setup({ "*" }, {
                RGB = true,      -- #RGB hex codes
                RRGGBB = true,   -- #RRGGBB hex codes
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                rgb_fn = true,   -- CSS rgb() and rgba() functions
                hsl_fn = true,   -- CSS hsl() and hsla() functions
                css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
            })
        end,
    },
    {
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
}
