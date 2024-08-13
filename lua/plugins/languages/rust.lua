return {
    {
        "Saecki/crates.nvim",
        cond = not vim.g.vscode,
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        opts = {
            lsp = {
                enabled = true,
                on_attach = function(_, _)
                    -- local mapd = function(mode, binding, action, desc)
                    --     vim.keymap.set(mode, binding, action, { desc = "Cargo: " .. desc })
                    -- end
                    --
                    -- mapd("n", "K", vim.lsp.buf.hover, "Hover")
                    -- mapd({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    -- mapd("i", "<C-k>", vim.lsp.buf.signature_help, "[H]elp")
                end,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
}
