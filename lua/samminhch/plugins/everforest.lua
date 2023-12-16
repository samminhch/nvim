return {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    cond = not vim.g.vscode,
    config = function()
        -- colorscheme options
        vim.g.everforest_background = "hard"
        vim.g.everforest_disable_italic_comment = true
        vim.g.everforest_better_performance = true
        vim.g.everforest_transparent_background = 1
        vim.g.everforest_sign_column_background = "grey"

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        -- load the colorscheme
        vim.cmd.colorscheme("everforest")
    end
}
