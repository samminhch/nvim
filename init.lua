-- ██╗███╗  ██╗██╗████████╗   ██╗     ██╗   ██╗ █████╗
-- ██║████╗ ██║██║╚══██╔══╝   ██║     ██║   ██║██╔══██╗
-- ██║██╔██╗██║██║   ██║      ██║     ██║   ██║███████║
-- ██║██║╚████║██║   ██║      ██║     ██║   ██║██╔══██║
-- ██║██║ ╚███║██║   ██║   ██╗███████╗╚██████╔╝██║  ██║
-- ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝   ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-------------------------------------------------------
-- @author Minh Nguyen
-- @github https://github.com/samminhch
-------------------------------------------------------
-------------------------------------------------------

require("config.settings")
require("config.bindings")

-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- set up all my plugins
require("lazy").setup({
    spec = {
        { import = "plugins" },
        { import = "plugins.ui" },
        { import = "plugins.coding" },
        { import = "plugins.languages" },
        { import = "plugins.conform" },
    },
    install = {
        colorscheme = { "nvchad" },
    },
})

-- To load all integrations at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
    dofile(vim.g.base46_cache .. v)
end
