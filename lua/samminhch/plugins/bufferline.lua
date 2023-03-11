return {
    'akinsho/bufferline.nvim',
    enabled = not vim.g.vscode,
    event = 'VeryLazy',
    dependencies = {
        'nvim-tree/nvim-web-devicons'
    },
    keys = {
        {'<s-l>', vim.cmd.BufferLineCycleNext, desc='Next Buffer'},
        {'<s-h>', vim.cmd.BufferLineCyclePrev, desc='Previous Buffer'},
        {'<leader>bp', vim.cmd.BufferLineTogglePin, desc='[B]ufferline [P]in'},
        {'<leader>bd', '<cmd>BufferLineGroupClose ungrouped<cr>', desc='[B]ufferline [D]elete unpinned'},
    },
    opts = {
        options = {
            diagnostics = 'coc',
            always_show_bufferline = false,
            offsets = {
                filetype = 'NvimTree',
                text = 'NvimTree',
                highlight = 'Directory',
                text_align = 'left'
            },
            show_buffer_close_icons = true,
            separator_style = "thin",
            tab_size = 20,
            show_tab_indicators = true,
            buffer_close_icon = "",
            modified_icon = "",
            close_icon = "",
            show_close_icon = true,
            left_trunc_marker = "",
            right_trunc_marker = "",
        }
    }
}
