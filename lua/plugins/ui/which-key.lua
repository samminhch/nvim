return {
    "folke/which-key.nvim",
    enabled = not vim.g.vscode,
    config = function()
        -- labeling keybind chains
        require("which-key").add({
            { "<leader>b", group = "[B]uffer" },
            { "<leader>b_", hidden = true },
            { "<leader>c", group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d", group = "[D]ebugger" },
            { "<leader>d_", hidden = true },
            { "<leader>f", group = "[F]ile" },
            { "<leader>f_", hidden = true },
            { "<leader>r", group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },
        })
    end,
}
