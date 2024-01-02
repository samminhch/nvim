return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/vaults/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim"
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/vaults/personal",
            },
            {
                name = "work",
                path = "~/Documents/vaults/work",
            },
        },
    },
}
