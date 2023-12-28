return {
    'folke/which-key.nvim',
    enabled = not vim.g.vscode,
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require('which-key').setup()
    end
}
