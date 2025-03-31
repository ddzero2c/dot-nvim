local function set_ft_indent(ft_patterns, ts, expandtab_enabled)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft_patterns,
        callback = function()
            vim.bo.tabstop = ts
            vim.bo.softtabstop = ts
            vim.bo.shiftwidth = ts
            vim.bo.expandtab = expandtab_enabled
        end
    })
end

set_ft_indent({ "sh" }, 4, false)
set_ft_indent({ "java", "go" }, 4, false)
set_ft_indent({ "vim", "lua" }, 4, true)
set_ft_indent({ "python" }, 4, true)
set_ft_indent({ "javascript", "javascriptreact", "typescript", "typescriptreact", "graphql" }, 2, true)
set_ft_indent({ "yaml", "json", "sql" }, 2, true)
set_ft_indent({ "helm", "dockerfile", "terraform", "hcl" }, 2, true)
set_ft_indent({ "css", "sass", "scss", "html" }, 2, true)
set_ft_indent({ "dart" }, 2, true)

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 1 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

vim.api.nvim_create_user_command('RG', function(opts)
    local search_term = opts.args
    local results = vim.fn.system('rg --vimgrep ' .. vim.fn.shellescape(search_term))
    vim.fn.setqflist({}, ' ', {
        title = 'Search Results',
        lines = vim.split(results, '\n', { trimempty = true })
    })
    vim.cmd('copen')
end, {
    nargs = '+',
    desc = 'Search using ripgrep and populate quickfix list'
})
