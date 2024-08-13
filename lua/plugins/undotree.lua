return {
    'mbbill/undotree',
    lazy = true,
    enabled = not vim.g.vscode,
    keys = {
        {'<leader>u', vim.cmd.UndotreeToggle, desc='[U]ndotree Toggle'}
    }
}
