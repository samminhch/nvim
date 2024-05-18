return {
    'folke/which-key.nvim',
    enabled = not vim.g.vscode,
    config = function()
        require('which-key').setup()
        -- labeling keybind chains
        require('which-key').register {
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>b'] = { name = '[B]arbar', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
            ['<leader>f'] = { name = '[F]ile', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ebugger', _ = 'which_key_ignore' },
        }
    end
}
