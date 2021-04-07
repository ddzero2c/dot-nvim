O = {
    auto_close_tree = 0,
    auto_complete = true,
    hidden_files = true,
    python = {
        linter = '',
        -- @usage can be 'yapf', 'black'
        formatter = '',
        isort = false,
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    dart = {
        sdk_path = '/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot'
    },
    lua = {
        -- @usage can be 'lua-format'
        formatter = 'lua-format',
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    sh = {
        -- @usage can be 'shellcheck'
        linter = 'shellcheck',
        -- @usage can be 'shfmt'
        formatter = 'shfmt',
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    tsserver = {
        -- @usage can be 'eslint'
        linter = 'eslint',
        -- @usage can be 'prettier'
        formatter = 'prettier',
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    json = {
        -- @usage can be 'prettier'
        formatter = 'eslint',
        diagnostics = {virtual_text = true, signs = true, underline = true}
    },
    tailwindls = {
        filetypes = {
            'html', 'css', 'scss', 'javascript', 'javascriptreact',
            'typescript', 'typescriptreact'
        }
    },
    clang = {
        diagnostics = {virtual_text = true, signs = true, underline = true}
    }
    -- css = {formatter = '', virtual_text = true},
    -- json = {formatter = '', virtual_text = true}
}

DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

