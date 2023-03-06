local ok, gitsigns = pcall(require, 'gitsigns')

if not ok then
    return
end

gitsigns.setup {
    signs = {
        add          = { text = '█' },
        change       = { text = '█' },
        delete       = { text = '░' },
        topdelete    = { text = '░' },
        changedelete = { text = '░' },
        untracked    = { text = '█' },
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        delay = 0,
    },
    yadm = {
        enable = true
    },
}
