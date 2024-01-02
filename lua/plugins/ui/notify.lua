return {
    {
        "rcarriga/nvim-notify",
        cond = not vim.g.vscode,
        opts = { stages = "slide" }
    },
    {
        "mrded/nvim-lsp-notify",
        cond = not vim.g.vscode,
        dependencies = {
            "rcarriga/nvim-notify",
        },
        config = function()
            require("lsp-notify").setup({
                notify = require("notify"),
                icons = {
                    spinner = { "󰝦", "󰪞", "󰪟", "󰪠", "󰪡", "󰪢", "󰪣", "󰪤", "󰪥" },
                    done = "",
                }
            })
        end
    }
}
