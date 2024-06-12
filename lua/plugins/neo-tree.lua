return {
    "nvim-neo-tree/neo-tree.nvim",
    cond = not vim.g.vscode,
    branch = "v3.x",
    keys = {
        {
            '<leader>ft',
            function()
                require("neo-tree")
                vim.cmd([[Neotree reveal filesystem toggle left]])
            end,
            desc = "[F]ile [T]ree Toggle"
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        -- NvimTree highlights for NeoTree
        vim.cmd([[
            highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
            highlight! link NeoTreeDirectoryName NvimTreeFolderName
            highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
            highlight! link NeoTreeRootName NvimTreeRootFolder
            highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
            highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
        ]])
    end
}
