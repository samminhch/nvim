local slow_format_filetypes = {}

return {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode,
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    keys = {
        {
            "<leader>F",
            function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
            desc = "[F]ormat Buffer",
        },
    },
    opts = {
        format_on_save = function(bufnr)
            if slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end

            local function on_format(err)
                if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
            end

            return { timeout_ms = 1000, lsp_format = "fallback" }, on_format
        end,
        format_after_save = function(bufnr)
            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                return
            end
            return { lsp_format = "fallback" }
        end,
        formatters_by_ft = {
            lua = { "stylua" },
            rust = { "rustfmt" },
            tex = { "latexindent" },
            python = { "isort", "black" },
        },
        formatters = {
            stylua = {
                prepend_args = {
                    "--collapse-simple-statement",
                    "FunctionOnly",
                    "--sort-requires",
                    "--quote-style",
                    "AutoPreferDouble",
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    vim.api.nvim_get_option_value("shiftwidth", {}),
                },
            },
        },
    },
}
