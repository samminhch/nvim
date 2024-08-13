return {
    "folke/todo-comments.nvim",
    cond = not vim.g.vscode,
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false }
}
