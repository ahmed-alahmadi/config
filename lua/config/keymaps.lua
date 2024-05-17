vim.keymap.set({"i","n"},"<esc>","<cmd>noh<cr><esc>")
--- escape
vim.keymap.set("i","jj","<esc>",{silent=true})
vim.keymap.set("t","<esc>",[[<C-\><C-n>]],{silent=true})




vim.keymap.set({"i","n","x","s"},"<C-s>","<cmd>w<cr><esc>")

vim.keymap.set("n","<leader>cd",vim.diagnostic.open_float)

vim.keymap.set("n","<leader>fe","<cmd>Lexplore<cr>")
vim.keymap.set("n","<s-down>","<c-w>j ")
vim.keymap.set("n","<s-left>","<c-w>h")
vim.keymap.set("n","<s-up>","<c-w>k")
vim.keymap.set("n","<s-right>","<c-w>l")
vim.keymap.set("n","<leader>lx","<cmd>Lazy<cr>")
