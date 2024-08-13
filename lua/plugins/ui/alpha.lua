return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    cond = not vim.g.vscode,
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
                     _     _       _             _       
 ___ ___ _____ _____|_|___| |_ ___| |_   ___ _ _|_|_____ 
|_ -| .'|     |     | |   |   |  _|   |_|   | | | |     |
|___|__,|_|_|_|_|_|_|_|_|_|_|_|___|_|_|_|_|_|\_/|_|_|_|_|
]]

        -- Set header
        dashboard.section.header.val = vim.split(logo, "\n")

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "📝   New file", ":ene | startinsert <CR>"),
            dashboard.button("f", "🔍   Find file", ":cd $PWD | Telescope find_files<CR>"),
            dashboard.button("r", "🕥   Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "🔧   Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
            dashboard.button("l", "💤   Lazy", ":Lazy<CR>"),
            dashboard.button("q", "🚫   Quit NVIM", ":qa<CR>"),
        }

        return dashboard.opts
    end,
    config = function(_, opts)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function() require("lazy").show() end,
            })
        end

        require("alpha").setup(opts)
    end,
}
