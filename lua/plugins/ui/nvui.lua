return {
    {
        "nvchad/ui",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function() require("nvchad") end,
    },
    {
        "nvchad/base46",
        lazy = true,
        keys = {
            { "<leader>sc", function() require("nvchad.themes").open() end, desc = "[S]earch [C]olorschemes" },
        },
        build = function() require("base46").load_all_highlights() end,
    },
    {
        "nvchad/volt",
        config = function() end,
    },
}
