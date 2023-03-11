return {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    enabled = not vim.g.vscode,
    opts = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
                 _         _
     __   ___.--'_`.     .'_`--.___   __ 
    ( _`.'. -   'o` )   ( 'o`   - .`.'_ )
    _\.'_'      _.-'     `-._      `_`./_
    ( \`. )    //\`         '/\    ( .'/ ),
    \_`-'`---'\__,       ,__//`---'`-'_/
    \`        `-\         /-'        '/
     `                               '

 █▀▀ █▀█ █▀█ █▀▀ ▄▀█ █   █ █▀▀ █ █▀█ █ █ █▀ █
 █▀  █▀▄ █▄█ █▄█ █▀█ █▄▄ █ █▄▄ █ █▄█ █▄█ ▄█ ▄
        ]]

        -- Set header
        dashboard.section.header.val = vim.split(logo, '\n')

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("e", "📝   New file", ":ene | startinsert <CR>"),
            dashboard.button("f", "🔍   Find file", ":cd $PWD | Telescope find_files<CR>"),
            dashboard.button("r", "🕥   Recent", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "🔧   Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
            dashboard.button("l", "💤   Lazy", ":Lazy<CR>"),
            dashboard.button("q", "🚫   Quit NVIM", ":qa<CR>"),
        }

        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(dashboard.opts)
    end
}
