local M = {}

M.base46 = {
    theme = "everforest",
    theme_toggle = { "everforest", "everforest_light" },
    integrations = { "dap" },
}

M.lsp = {
    signature = true,
}

M.ui = {
    statusline = {
        theme = "minimal",
        separator_style = "round",
    },
}

return M
