return {
    'norcalli/nvim-colorizer.lua',
    cond = not vim.g.vscode,
    opts = {
        '*',
        css = { css = true },
        html = { css = true }
    }
}
