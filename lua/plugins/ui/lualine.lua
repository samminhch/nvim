local function keymap()
    if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
        return "⌨ " .. vim.b.keymap_name
    end
    return ""
end

return {
    "nvim-lualine/lualine.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                "neo-tree",
                "undotree",
                statusli = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            },
        },
        sections = {
            lualine_a = { { "mode", separator = { left = "", right = "" } } },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { keymap, "progress" },
            lualine_z = {
                { "location", separator = { left = "", right = "" } },
            },
        },
    },
}
