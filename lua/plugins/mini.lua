return {
    {
        "echasnovski/mini.indentscope",
        cond = not vim.g.vscode,
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
                callback = function() vim.b.miniindentscope_disable = true end,
            })
        end,
        opts = {
            symbol = "┊",
            options = { try_as_border = true },
        },
    },
    {
        "echasnovski/mini.files",
        cond = not vim.g.vscode,
        version = false,
        keys = {
            {
                "<leader>fe",
                function()
                    if not MiniFiles.close() then
                        MiniFiles.open()
                    end
                end,
                desc = "[F]ile Explorer",
            },
        },
        config = function() require("mini.files").setup() end,
    },
    {
        "echasnovski/mini.surround",
        cond = not vim.g.vscode,
        version = false,
        opts = {},
    },
    {
        "echasnovski/mini.ai",
        cond = not vim.g.vscode,
        version = false,
        opts = {},
    },
    {
        "echasnovski/mini.align",
        cond = not vim.g.vscode,
        version = false,
        opts = {},
    },
    {
        "echasnovski/mini.icons",
        cond = not vim.g.vscode,
        version = false,
        opts = {},
    },
}
