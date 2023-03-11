return {
    'sainnhe/everforest',
    lazy=false,
    priority=1000,
    enabled = not vim.g.vscode,
    config = function()
        -- colorscheme options
        vim.g.everforest_background='hard'
        vim.g.everforest_disable_italic_comment = true
        vim.g.everforest_better_performance = true

        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

        -- load the colorscheme
        vim.cmd.colorscheme('everforest')
    end
}
