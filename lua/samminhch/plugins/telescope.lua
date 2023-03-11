return {
    'nvim-telescope/telescope.nvim',
    enabled = not vim.g.vscode,
    version = false,
    cmd = 'Telescope',
    keys = {
        {'<leader>sf', '<cmd>Telescope find_files<cr>', '[S]earch [F]iles'},
        {'<leader>sr', '<cmd>Telescope oldfiles<cr>', '[S]earch [R]ecent'},
        {'<leader>sg', '<cmd>Telescope git_files<cr>', '[S]earch [G]it files'},
        {'<leader>sw', '<cmd>Telescope grep_string<cr>', '[S]earch [W]ord in file'},
        {'<leader>sd', '<cmd>Telescope diagnostics<cr>', '[S]earch [D]iagnostics'},
        {'<leader>sb', '<cmd>Telescope buffers<cr>', '[S]earch [B]uffers'}
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
}
