return {
    'nvim-tree/nvim-tree.lua',
    enabled = not vim.g.vscode,
    deactivate = vim.cmd.NvimTreeClose,
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
        }
    },
    config = function(_, opts)
        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup(opts)
    end,
    keys = {
        {
            '<leader>fe',
            vim.cmd.NvimTreeToggle,
            desc = '[F]ile [E]xplorer'
        },
    },
}
