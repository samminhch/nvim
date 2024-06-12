return {
    'stevearc/oil.nvim',
    opts = {},
    keys = {
        {
            "<leader>fe",
            function()
                vim.cmd([[Oil]])
            end,
            desc = "[F]ile [E]xplorer"
        }
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
