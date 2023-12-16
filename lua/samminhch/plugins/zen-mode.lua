return {
    "folke/zen-mode.nvim",
    cond = not vim.g.vscode,
    opts = {
        wezterm = {
            enabled = true,
            -- can be either an absolute font size or the number of incremental steps
            font = "+4", -- (10% increase per step)
        },
    }
}
