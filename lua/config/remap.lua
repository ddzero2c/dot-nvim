vim.g.mapleader = " "
-- vim.keymap.set('n', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set({ 'i', 's' }, '<Tab>', function()
    if vim.snippet.active({ direction = 1 }) then
        return '<Cmd>lua vim.snippet.jump(1)<CR>'
    else
        return '<Tab>'
    end
end, { expr = true })

vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
    if vim.snippet.active({ direction = -1 }) then
        return '<Cmd>lua vim.snippet.jump(-1)<CR>'
    else
        return '<S-Tab>'
    end
end, { expr = true })
