return {
    {
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        cond = not vim.g.vscode,
        config = function()
            -- colorscheme options
            vim.g.everforest_background = "hard"
            vim.g.everforest_disable_italic_comment = true
            vim.g.everforest_better_performance = true
            vim.g.everforest_sign_column_background = "grey"

            -- vim.g.everforest_transparent_background = (vim.g.neovide and 0 or 1)
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            -- load the colorscheme
            vim.cmd.colorscheme("everforest")
        end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, cond = not vim.g.vscode },
    { "dracula/vim", name = "dracula", priority = 1000, cond = not vim.g.vscode },
    { "rktjmp/lush.nvim", name = "lush", priority = 1000, cond = not vim.g.vscode },
}
