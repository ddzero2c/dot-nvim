local lsp_fallback = setmetatable({
    javascript = false,
    javascriptreact = false,
    typescript = false,
    typescriptreact = false,
}, {
    __index = function() return true end,
})

require("conform").setup({
    formatters_by_ft = {
        sql = { "pg_format" },
        css = { "prettier" },
        graphql = { "prettier", },
        -- yaml = { "prettier", args = "--single-quote" },
        solidity = { "solidity" },
        -- ["*"] = { "codespell" },
        python = { "isort", "black" },
        ["_"] = { "trim_whitespace" },
        -- ["*"] = { "injected" }
    },
    format_on_save = function(buf)
        return {
            timeout_ms = 1000,
            lsp_fallback = lsp_fallback[vim.bo[buf].filetype],
        }
    end,
    formatters = {
        solidity = {
            inherit = false,
            command = require("conform.util").find_executable({
                "node_modules/.bin/prettier",
            }, "prettier"),
            args = {
                "--stdin-filepath",
                "$FILENAME",
                "--plugin",
                "prettier-plugin-solidity",
            },
        },
        injected = {
            options = {
                ignore_errors = true,
                lang_to_formatters = {
                    json = { "jq" },
                },
            },
        }
    },
})
