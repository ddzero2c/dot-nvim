require('lazy').setup {
    {
        'neovim/nvim-lspconfig',
        ft = {
            'go', 'python', 'rust', 'solidity',
            'lua',
            'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css',
            'json', 'yaml', 'graphql',
        },
        dependencies = {
            { 'kosayoda/nvim-lightbulb' },
            { 'b0o/schemastore.nvim' },
        },
        main = 'ddzero2c.lsp',
        opts = {},
    },
    { 'folke/neodev.nvim',             ft = { 'lua' }, opts = {}, },
    { 'olexsmir/gopher.nvim',          ft = { 'go' },  opts = {} },
    { 'ddzero2c/go-embedded-sql.nvim', ft = { 'go' } },
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-vsnip' },
            { 'uga-rosa/cmp-dictionary' },
            { 'onsails/lspkind-nvim' },
        },
        config = function()
            require('ddzero2c.cmp')
        end
    },
    {
        'github/copilot.vim',
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
                function() require('dap').continue() end,
                desc = "Debug",
            },
        },
        dependencies = {
            'rcarriga/nvim-dap-ui'
        },
        config = function()
            require("ddzero2c.dap")
        end
    },
    {
        'stevearc/conform.nvim',
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        config = function()
            require('ddzero2c.conform')
        end
    },
    { 'ntpeters/vim-better-whitespace' },
    { 'iamcco/markdown-preview.nvim',        cmd = 'MarkdownPreview' },
    { 'tpope/vim-fugitive',                  event = "CmdLineEnter" },
    { 'tpope/vim-surround',                  event = "InsertEnter" },
    { 'tpope/vim-repeat',                    event = "InsertEnter" },
    { 'folke/todo-comments.nvim',            opts = {} },
    { "lukas-reineke/indent-blankline.nvim", opts = {},              main = "ibl" },
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
        dependencies = {
            { 'JoosepAlviste/nvim-ts-context-commentstring' },
        },
        config = function()
            require("ddzero2c.kommentary")
        end
    },
    { 'stevearc/oil.nvim', opts = { use_default_keymaps = false } },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = {
            { 'kevinhwang91/promise-async' },
        },
        config = function()
            require("ddzero2c.ufo")
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter-textobjects' },
            { 'nvim-treesitter/playground' },
        },
        config = function()
            require("ddzero2c.treesitter")
        end,
        build = ':TSUpdate'
    },
    -- fuzzy searcher
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
            require("ddzero2c.telescope")
        end,
    },
    -- color
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
