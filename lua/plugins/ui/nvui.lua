return {
    {
        "nvchad/ui",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            -- Buffer management
            {
                "<S-h>",
                function() require("nvchad.tabufline").prev() end,
                desc = "Previous Buffer",
            },
            {
                "<S-l>",
                function() require("nvchad.tabufline").next() end,
                desc = "Previous Buffer",
            },
            {
                "<C-S-h>",
                function() require("nvchad.tabufline").move_buf(-1) end,
                desc = "Move Buffer Left",
            },
            {
                "<C-S-l>",
                function() require("nvchad.tabufline").move_buf(1) end,
                desc = "Move Buffer Right",
            },
            {
                "<leader>bq",
                function() require("nvchad.tabufline").close_buffer() end,
                desc = "[B]uffer [Q]uit",
            },
            {
                "<leader>bqh",
                function() require("nvchad.tabufline").closeBufs_at_direction("left") end,
                desc = "[B]uffer [Q]uit Left",
            },
            {
                "<leader>bql",
                function() require("nvchad.tabufline").closeBufs_at_direction("right") end,
                desc = "[B]uffer [Q]uit Right",
            },
            {
                "<leader>bqo",
                function() require("nvchad.tabufline").closeAllBufs(false) end,
                desc = "[B]uffer [Q]uit [O]thers",
            },
            {
                "<leader>bqa",
                function() require("nvchad.tabufline").closeAllBufs(true) end,
                desc = "[B]uffer [Q]uit [A]ll",
            },
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
