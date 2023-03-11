return {
    'lewis6991/gitsigns.nvim',
    enabled = not vim.g.vscode,
    opts = {
        signs = {
            add          = { text = '█' },
            change       = { text = '█' },
            delete       = { text = '░' },
            topdelete    = { text = '░' },
            changedelete = { text = '░' },
            untracked    = { text = '█' },
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            delay = 0,
        },
        yadm = {
            enable = vim.fn.executable('yadm')
        },  
    }
}
