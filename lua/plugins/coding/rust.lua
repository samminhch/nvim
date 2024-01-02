return {
    {
        "Saecki/crates.nvim",
        cond = not vim.g.vscode,
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        opts = {
            null_ls = {
                enabled = true,
                name = "crates.nvim",
            },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function()
                    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
                end,
            })

            require("crates").setup(opts)
        end
    },
    {
        "simrat39/rust-tools.nvim",
        cond = not vim.g.vscode,
        ft = "rust",
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set(
                        "n",
                        "K",
                        require("rust-tools").hover_actions.hover_actions,
                        { buffer = bufnr, desc = "Hover Actions (Rust)" }
                    )
                    -- Code action groups
                    vim.keymap.set(
                        "n",
                        "<Leader>ca",
                        require("rust-tools").code_action_group.code_action_group,
                        { buffer = bufnr, desc = "[C]ode [A]ction (Rust)" }
                    )
                end,
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            },
            tools = {
                hover_actions = {
                    auto_focus = true,
                },
            },
        },
        config = function(_, opts)
            local extension_path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extension"
            local codelldb_path = extension_path .. "/adapter/codelldb"

            -- get the right liblldb according to OS
            local liblldb_path = ""
            if vim.loop.os_uname().sysname:find("Windows") then
                liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
            elseif vim.fn.has("mac") == 1 then
                liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
            else
                liblldb_path = extension_path .. "lldb/lib/liblldb.so"
            end

            require("rust-tools").setup(vim.tbl_extend("keep", opts, {
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                tools = {
                    on_initialized = function()
                        vim.cmd([[
                                  augroup RustLSP
                                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                                  augroup END
                        ]])
                    end,
                },
            }))
        end,
    },
}
