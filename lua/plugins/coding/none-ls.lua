return {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>cf",
            function()
                vim.lsp.buf.format({ async = true })
            end,
            desc = "[C]ode [F]ormat",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = function()
        local null_ls = require("null-ls")
        local formatter = null_ls.builtins.formatting
        local linter = null_ls.builtins.diagnostics

        return {
            sources = {
                formatter.stylua.with({
                    extra_args = function(params)
                        return {
                            "--collapse-simple-statement Always",
                            "--indent-type Spaces",
                            "--sort-requires",
                            "--indent-width " ..
                            vim.api.nvim_get_option_value("shiftwidth", {})
                        }
                    end
                }),
                formatter.black.with({ extra_args = { "--fast" } }),
                formatter.isort
            },
            on_attach = function(client, buffer_num)
                if not client.supports_method("textDocument/formatting") then
                    return
                end

                local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = buffer_num
                })

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = buffer_num,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = buffer_num, async = false })
                    end
                })
            end
        }
    end,
}
