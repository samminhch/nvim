return {
    'nvim-tree/nvim-tree.lua',
    enabled = not vim.g.vscode,
    keys = {
        {
            '<leader>fe',
            vim.cmd.NvimTreeToggle,
            desc = '[F]ile [E]xplorer'
        },
    },
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    opts = {
        sort_by = 'case_sensitive',
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
        git = {
        }
    },
    config = function(_, opts)
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup(opts)
    end,
}
