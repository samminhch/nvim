-- These configs were mostly taken from www.lazyvim.org. Thanks guys <3
return {
    "echasnovski/mini.indentscope",
    cond = not vim.g.vscode,
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
            callback = function()
                vim.b.miniindentscope_disable = true
            end,
        })
    end,
    opts = {
        symbol = "┊",
        options = { try_as_border = true },
    },
}
