local ok, alpha = pcall(require, 'alpha')

if not ok then
    return
end

local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "                _         _",
    "    __   ___.--'_`.     .'_`--.___   __",
    "   ( _`.'. -   'o` )   ( 'o`   - .`.'_ )",
    "   _\\.'_'      _.-'     `-._      `_`./_",
    "  ( \\`. )    //\\`         '/\\    ( .'/ )",
    "   \\_`-'`---'\\__,       ,__//`---'`-'_/",
    "    \\`        `-\\         /-'        '/",
    "     `                               '",
    "",
    "█▀▀ █▀█ █▀█ █▀▀ ▄▀█ █   █ █▀▀ █ █▀█ █ █ █▀ █",
    "█▀  █▀▄ █▄█ █▄█ █▀█ █▄▄ █ █▄▄ █ █▄█ █▄█ ▄█ ▄"
}
-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file", ":ene | startinsert <CR>"),
    dashboard.button("f", "  > Find file", ":cd $PWD | Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
