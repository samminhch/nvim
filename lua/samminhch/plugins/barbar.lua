return {
    'romgrk/barbar.nvim',
    enabled = vim.g.vscode,
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { '<s-l>',      vim.cmd.BufferNext,         desc = 'Next Buffer' },
        { '<s-h>',      vim.cmd.BufferPrevious,     desc = 'Previous Buffer' },
        { '<c-s-l>',    vim.cmd.BufferMoveNext,     desc = 'Move Buffer Right' },
        { '<c-s-h>',    vim.cmd.BufferMovePrevious, desc = 'Move Buffer Left' },
        { '<leader>bq', vim.cmd.BufferClose,        desc = '[B]arbar [Q]uit Buffer' }
    },
    opts = {
        insert_at_start = true,
        animation = true,
        icons = {
            button = ''
        },
        sidebar_filetypes = {
            NvimTree = {text = '📂'}
        }
    },
}
