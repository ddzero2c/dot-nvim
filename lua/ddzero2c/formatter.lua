local prettier_local_formatter = function()
    return {
        exe = "node_modules/.bin/prettier",
        args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
        stdin = true
    }
end

local prettier_formatter = function()
    return {
        exe = "prettier",
        args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
        stdin = true
    }
end

local sqlfluff_formatter = function()
    return {
        exe = "sqlfluff",
        args = { "fix", "-f", "-" },
        stdin = true
    }
end

require('formatter').setup({
    filetype = {
        solidity = { prettier_local_formatter },
        markdown = { prettier_formatter },
        sql = { sqlfluff_formatter },
        graphql = { prettier_formatter },
    }
})
vim.cmd 'autocmd BufWritePost *.sol,*.md,*.sql,*.graphql FormatWrite'
