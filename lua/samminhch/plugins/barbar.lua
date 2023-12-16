return {
    'romgrk/barbar.nvim',
    enabled = vim.g.vscode,
    event = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { '<s-l>',      vim.cmd.BufferNext,               desc = 'Next Buffer' },
        { '<s-h>',      vim.cmd.BufferPrevious,           desc = 'Previous Buffer' },
        { '<c-s-l>',    vim.cmd.BufferMoveNext,           desc = 'Move Buffer Right' },
        { '<c-s-h>',    vim.cmd.BufferMovePrevious,       desc = 'Move Buffer Left' },
        { '<leader>bq', vim.cmd.BufferClose,              desc = '[B]arbar [Q]uit Buffer' },
        { '<leader>bo', vim.cmd.BufferCloseAllButCurrent, desc = '[B]arbar Quit [O]ther Buffers' },
        { '<leader>bp', vim.cmd.BufferPin,                desc = '[B]arbar [P]in' },
        { '<leader>bP', vim.cmd.BufferCloseAllButPinned,  desc = '[B]arbar Keep [P]inned' },
    },
    opts = {
        auto_hide = 1,
        insert_at_start = true,
        animation = true,
        separator_at_end = false,
        icons = {
            button = '󰅙',
            separator = { left = '▎', right = '' },
        },
        exclude_ft = { 'undotree', 'nvimtree' }
    },
}
