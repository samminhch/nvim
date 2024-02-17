return {
    "runih/colorscheme-picker.nvim",
    cond = not vim.g.vscode,
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
        },
        { "catppuccin/nvim",  name = "catppuccin", priority = 1000, cond = not vim.g.vscode },
        { "dracula/vim",      name = "dracula",    priority = 1000, cond = not vim.g.vscode },
        { "rktjmp/lush.nvim", name = "lush",       priority = 1000, cond = not vim.g.vscode }
    },
    config = function()
        local ok, colorscheme = pcall(require, "colorscheme-picker")
        if not ok then
            print("Color Picker is not loaded")
            return
        end
        colorscheme.setup({
            default_colorscheme = "everforest",
            keymapping = "<leader>sc",
        })
        colorscheme.set_default_colorscheme()
    end,
}
