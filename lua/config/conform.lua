require("conform").setup({
    formatters_by_ft = {
        sql = { "pg_format" },
        css = { "prettier" },
        graphql = { "prettier" },
        yaml = { "prettier" },
        solidity = { "solidity" },
        -- ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
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
    },
})
