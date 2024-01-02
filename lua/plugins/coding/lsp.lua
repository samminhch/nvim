return {
    {
        "williamboman/mason.nvim",
        cond = not vim.g.vscode,
        opts = {
            ui = { border = "rounded" },
            ensure_installed = {
                -- linters, debuggers, etc...
                "black",
                "codelldb",
                "eslint_d",
                "glow",
                "isort",
                "prettier",
                "stylua",
                "java-debug-adapter",
                "java-test",
            },
        },
        -- see https://www.lazyvim.org/plugins/lsp#masonnvim-1
        config = function(_, opts)
            require("mason").setup(opts)
            local registry = require("mason-registry")

            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local package = registry.get_package(tool)
                    if not package:is_installed() then
                        package:install()
                    end
                end
            end

            -- install packages if they haven't already been installed
            if registry.refresh then
                registry.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    {
        "neovim/nvim-lspconfig",
        cond = not vim.g.vscode,
        lazy = false,
        cmd = "LspInfo",
        keys = {
            { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
            { "[d", vim.diagnostic.goto_prev, desc = "Previous Diagnostic" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            {
                "folke/neodev.nvim",
                opts = {
                    library = {
                        plugins = { "nvim-dap-ui" },
                        types = true,
                    },
                },
            },
        },
        config = function()
            -- define border style
            local border_opts = { border = "rounded" }
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border_opts)
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, border_opts)
            vim.diagnostic.config({ float = border_opts })

            -- define lsp icons
            local icons = { Error = "", Warn = "", Hint = "󰌵", Info = "" }

            for type, icon in pairs(icons) do
                local highlight = "DiagnosticSign" .. type
                vim.fn.sign_define(highlight, { text = icon, texthl = highlight, numhl = highlight })
            end

            -- map only after lsp has attached
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    local mapd = function(mode, binding, action, desc)
                        vim.keymap.set(mode, binding, action, { buffer = event.buf, desc = desc })
                    end

                    -- Enable completion triggered by <C-x><C-o>
                    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    mapd("n", "gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
                    mapd("n", "gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
                    mapd("n", "gi", vim.lsp.buf.implementation, "[G]o to [I]mplementation")
                    mapd("n", "gr", vim.lsp.buf.references, "[G]o to [R]eferences")
                    mapd("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
                    mapd("n", "K", vim.lsp.buf.hover, "Hover")
                    mapd({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    mapd("i", "<C-k>", vim.lsp.buf.signature_help, "[H]elp")

                    vim.keymap.set("n", "<leader>ss", function()
                        vim.cmd.Telescope("lsp_document_symbols")
                    end, { desc = "[S]earch LSP [S]ymbols" })
                end,
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim", -- Optional
        cond = not vim.g.vscode,
        event = { "BufReadPre", "BufNewFile", "InsertEnter" },
        keys = {
            { "<leader>m", vim.cmd.Mason, desc = "[M]ason" },
        },
        opts = {
            ensure_installed = {
                "angularls",
                "arduino_language_server",
                "bashls",
                "clangd",
                "cssls",
                "html",
                "jdtls",
                "jedi_language_server",
                "lua_ls",
                "marksman",
                "rust_analyzer",
                "texlab",
                "tsserver",
            },
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "barreiroleo/ltex_extra.nvim",
            "p00f/clangd_extensions.nvim",
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")

            local default_setup = function(server)
                lspconfig[server].setup({ capabilities = require("cmp_nvim_lsp").default_capabilities() })
            end

            local mason_lspconfig = require("mason-lspconfig")

            mason_lspconfig.setup(vim.tbl_extend("keep", opts, {
                handlers = {
                    -- auto-setup lsps
                    default_setup,

                    -- more specific lsp configs
                    arduino_language_server = function()
                        lspconfig.arduino_language_server.setup({
                            filetypes = { "c", "cpp", "arduino" },
                            root_dir = lspconfig.util.root_pattern("sketch.yaml"),
                            on_attach = function()
                                -- disable clangd language server
                                for _, client in pairs(vim.lsp.get_active_clients()) do
                                    if client.name == "clangd" then
                                        vim.lsp.stop_client(client.id)
                                    end
                                end
                            end,
                        })
                    end,

                    clangd = function()
                        lspconfig.clangd.setup({
                            on_attach = function(_, _)
                                require("clangd_extensions.inlay_hints").setup_autocmd()
                                require("clangd_extensions.inlay_hints").set_inlay_hints()
                            end,
                        })
                    end,

                    html = function()
                        lspconfig.html.setup({
                            init_options = {
                                configurationSection = { "html", "css", "javascript" },
                                provideFormatter = false,
                                embeddedLanguages = {
                                    css = true,
                                    javascript = true,
                                },
                            },
                        })
                    end,

                    texlab = function()
                        lspconfig.texlab.setup({
                            settings = {
                                texlab = {
                                    auxDirectory = "build",
                                    build = {
                                        onSave = true,
                                        forwardSearchAfter = true,
                                        args = {
                                            "-lualatex",
                                            "-f",
                                            "-output-directory=build",
                                            "-interaction=nonstopmode",
                                            "--synctex=1",
                                            "-bibtex",
                                            "%f",
                                        },
                                    },
                                    chktex = {
                                        onEdit = true,
                                        onOpenAndSave = true,
                                    },
                                    forwardSearch = {
                                        executable = "zathura",
                                        args = {
                                            "--synctex-forward",
                                            vim.fn.line(".") .. ":" .. vim.fn.col(".") .. ":" .. vim.fn.shellescape(
                                                vim.fn.expand("%:p")
                                            ),
                                        },
                                    },
                                },
                            },
                            on_attach = function(_, _)
                                -- rest of your on_attach process.
                                require("ltex_extra").setup()
                            end,
                        })
                    end,
                },
            }))
        end,
    },
}
