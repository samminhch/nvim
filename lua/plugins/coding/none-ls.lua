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
                            vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth")
                        }
                    end
                }),
                formatter.prettier.with({
                    extra_args = function(params)
                        return {
                            "--tab-width " ..
                            vim.api.nvim_buf_get_option(params.bufnr, "shiftwidth"),
                        }
                    end,
                }),
                formatter.black.with({ extra_args = { "--fast" } }),
                formatter.isort,
                formatter.rustfmt.with({
                    extra_args = function(params)
                        local Path = require("plenary.path")
                        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

                        if cargo_toml:exists() and cargo_toml:is_file() then
                            for _, line in ipairs(cargo_toml:readlines()) do
                                local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                                if edition then
                                    return { "--edition=" .. edition }
                                end
                            end
                        end
                        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
                        return { "--edition=2023" }
                    end,
                }),
                linter.eslint_d,
            },
            on_attach = function(client, buffer_num)
                if not client.supports_method("textDocument/formatting") then
                    return
                end

                local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

                -- clear autocommands, and setup formatting on save
                vim.api.nvim_clear_autocmds({
                    group = augroup,
                    buffer = buffer_num
                })

                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = buffer_num,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = buffer_num, async = true })
                    end
                })
            end
        }
    end,
}
