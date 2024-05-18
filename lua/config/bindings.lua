local nmapd = require("utils").nmapd
local mapd = require("utils").mapd

-- Move to window using the <ctrl> hjkl keys
nmapd("<C-h>", "<C-w>h", "Go to left window")
nmapd("<C-j>", "<C-w>j", "Go to lower window")
nmapd("<C-k>", "<C-w>k", "Go to upper window")
nmapd("<C-l>", "<C-w>l", "Go to right window")

-- Resize window using <ctrl> arrow keys
nmapd("<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
nmapd("<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
nmapd("<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
nmapd("<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Move Lines
nmapd("<A-j>", "<cmd>m .+1<cr>==", "Move down")
nmapd("<A-k>", "<cmd>m .-2<cr>==", "Move up")
mapd("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
mapd("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
mapd("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move down")
mapd("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move up")

-- Keymap to activate lazy
vim.keymap.set("n", "<leader>l", vim.cmd.Lazy, { desc = "[L]azy Menu" })

-- Autocommands
-- vim.api.nvim_create_autocmd("HighlightYankPost", {
--     desc = "Highlight copied text",
--     group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
--     callback = function()
--         vim.highlight.on_yank()
--     end,
-- })
