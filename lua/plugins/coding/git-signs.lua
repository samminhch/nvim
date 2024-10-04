return {
    "lewis6991/gitsigns.nvim",
    enabled = not vim.g.vscode,
    opts = {
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "┇" },
            topdelete = { text = "┇" },
            changedelete = { text = "┇" },
            untracked = { text = "┃" },
        },
        attach_to_untracked = true,
        current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            delay = 0,
        },
        yadm = {
            enable = vim.fn.executable("yadm") == 1
        },
        on_attach = function()
            local nmapd = require("utils").nmapd
            nmapd("<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", "[G]itsigns [P]review Hunk")
            nmapd("<leader>gd", "<cmd>Gitsigns diffthis<cr>", "[G]itsigns [D]iff File")
            nmapd("<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", "[G]itsigns [B]lame Toggle")
        end
    }
}
