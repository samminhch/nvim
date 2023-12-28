return {
    "themercorp/themer.lua",
    lazy = false,
    cond = not vim.g.vscode,
    keys = {
        { "<leader>st", "<cmd>Telescope themes<cr>", desc = "[S]earch [T]hemes" },
    },
    dependencies = {
        "nvim-telescope/telescope.nvim",
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

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

                -- load the colorscheme
                vim.cmd.colorscheme("everforest")
            end
        }
    },
    opts = {
        -- colorscheme = "everforest",
        -- transparent = true,
        styles = {
            ["function"]    = { style = "italic" },
            functionbuiltin = { style = "italic" },
            variable        = { style = "italic" },
            variableBuiltIn = { style = "italic" },
            parameter       = { style = "italic" },
        },
        enable_installer = true
    },
    config = function(_, opts)
        require("telescope").load_extension("themes")
        require("themer").setup(opts)
    end
}
