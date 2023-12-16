return {
    "rcarriga/nvim-notify",
    cond = not (vim.g.vscode or vim.g.neovide),
    dependencies = {
        -- {
        --     'mrded/nvim-lsp-notify',
        --     opts = {
        --         icons = {
        --             spinner = { '', '󰪞', '󰪟', '󰪠', '󰪡', '󰪢', '󰪣', '󰪤', '󰪥' },
        --             done = '',
        --         }
        --     }
        -- },
    },
    opts = {
        stages = "slide",
    }
}
