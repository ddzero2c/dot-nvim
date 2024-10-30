vim.g.mapleader = " "
-- vim.keymap.set('n', '<C-c>', '<Esc>')
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-d>", "gt")
vim.keymap.set("n", "<C-u>", "gT")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "gh", ":diffget //2<Cr>")
vim.keymap.set("n", "gl", ":diffget //3<Cr>")


vim.cmd.ca('rg', 'RG')
vim.cmd.ca('g', 'Git')
vim.cmd.ca('gv', 'Gvdiffsplit')
vim.cmd.ca('gd', 'Git difftool')
