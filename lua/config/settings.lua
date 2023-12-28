-- This file is automatically loaded by plugins.config
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.o

-- Editor UI
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.cursorline = true

if vim.fn.has("termguicolors") == 1 then
    o.termguicolors = true
end

-- Editing Experience
o.colorcolumn = "80"
o.expandtab = true
o.smarttab = true
o.cindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.wrap = true
o.breakindent = true
o.clipboard = "unnamedplus"
o.hlsearch = false
o.autowrite = true               -- Enable auto write
o.conceallevel = 3               -- Hide * markup for bold and italic
o.confirm = true                 -- Confirm to save changes before exiting modified buffer
o.formatoptions = "jcroqlnt"     -- tcqj
o.pumblend = 10                  -- Popup blend
o.pumheight = 10                 -- Maximum number of entries in a popup
o.scrolloff = 4                  -- Lines of context
o.cursorline = true              -- Enable highlighting of the current line
o.wildmode = "longest:full,full" -- Command-line completion mode

-- Set completeopt to have a better completion experience
o.completeopt = "menuone,noselect"

-- vim searching
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

o.updatetime = 100
o.fileencoding = "utf-8"

o.history = 50

-- Undo / Backup Options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = true

if vim.fn.has("nvim-0.9.0") == 1 then
    o.splitkeep = "screen"
end

-- Folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldnestmax = 10
o.nofoldenable = true
o.foldlevel = 2

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- python integration
vim.g.python3_host_prog = "/usr/bin/python3"

-- neovide settings
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here
    vim.o.guifont = "ComicShannsMono Nerd Font:h14" -- text below applies for VimScript
    vim.g.neovide_cursor_vfx_mode = "railgun"
end
