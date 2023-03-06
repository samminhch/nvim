local ok, telescope = pcall(require, 'telescope')

if not ok then
    return
end

pcall(telescope.load_extension, 'fzf')

telescope.setup {
    defaults = {
        mappings = {
            i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
            },
        },
    },
}


local b = require('telescope.builtin')

local function nmapd(binding, value, description)
    vim.keymap.set('n', binding, value, { desc = description })
end
------------------------
-- Telescope bindings --
------------------------
-- rearch
nmapd('<leader>sr', b.oldfiles, '[S]earch [R]ecent files')
nmapd('<leader>sf', b.find_files, '[S]earch [F]iles')
nmapd('<leader>sg', b.git_files, '[S]earch [G]it files')
nmapd('<leader>sw', b.grep_string, '[S]earch [W]ord in file')
nmapd('<leader>sd', b.diagnostics, '[S]earch [D]iagnostics')

-- keymaps and help
nmapd('<leader>km', b.keymaps, '[K]ey[M]aps')
nmapd('<leader>h', b.help_tags, '[H]elp [T]ags')

-- lsp keybindings are found in ../../after/plugin/lsp.lua
