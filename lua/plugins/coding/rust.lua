return {
    {
        "Saecki/crates.nvim",
        cond = not vim.g.vscode,
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        opts = {
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
                end,
            })

            require("crates").setup(opts)
        end
    }
}
