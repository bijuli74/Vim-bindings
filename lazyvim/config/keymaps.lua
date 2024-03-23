-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

local opts = { noremap = true, silent = true }

-- Select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")

-- Surround
vim.keymap.set("n", "s", "gs")

-- Move Lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Change file permission Linux
vim.keymap.set("n", "<leader>xp", "<cmd>!chmod +x %<CR>", { silent = true })

-- Delete a word backwards in Insert mode
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("c", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-H>", "<C-w>")
vim.keymap.set("c", "<C-H>", "<C-w>")

-- Comments
vim.api.nvim_del_keymap("n", "<c-/>")
vim.api.nvim_del_keymap("t", "<C-/>")
vim.api.nvim_del_keymap("n", "<c-_>")
vim.api.nvim_del_keymap("t", "<C-_>")

-- Toggle Comment current line
vim.api.nvim_set_keymap(
  "n",
  "<C-/>",
  ':lua require("mini.comment").toggle_lines(vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1])<CR>',
  opts
)
vim.api.nvim_set_keymap(
  "n",
  "<C-_>",
  ':lua require("mini.comment").toggle_lines(vim.api.nvim_win_get_cursor(0)[1], vim.api.nvim_win_get_cursor(0)[1])<CR>',
  opts
)

-- Toggle Comment selected text
vim.api.nvim_set_keymap(
  "v",
  "<M-/>",
  ':lua require("mini.comment").toggle_lines(vim.fn.line("\'<"), vim.fn.line("\'>"))<CR>',
  opts
)

-- Floating Terminal
vim.keymap.set("n", "<m-;>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("t", "<M-;>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Diagnostics
vim.keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- Quickfix List
vim.keymap.set("n", "<leader>m", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>M", function()
  require("trouble").toggle("quickfix")
end)

-- Alternate File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore, { desc = "NetRW File Explorer" })
