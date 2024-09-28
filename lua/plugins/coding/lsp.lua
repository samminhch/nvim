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
                "latexindent",
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
        dependencies = {
            "nvim-telescope/telescope.nvim",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "luvit-meta/library", words = { "vim%.uv" } },
                        { path = "LazyVim", words = { "LazyVim" } },
                        { path = "wezterm-types", mods = { "wezterm" } },
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
                        vim.keymap.set(mode, binding, action, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Enable completion triggered by <C-x><C-o>
                    vim.bo[event.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local builtin = require("telescope.builtin")
                    mapd("n", "gd", builtin.lsp_definitions, "[G]o to [D]efinition")
                    mapd("n", "gi", builtin.lsp_implementations, "[G]o to [I]mplementation")
                    mapd("n", "gr", builtin.lsp_references, "[G]o to [R]eferences")
                    mapd("n", "gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
                    mapd("n", "K", vim.lsp.buf.hover, "Hover")
                    mapd({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    mapd("i", "<C-k>", vim.lsp.buf.signature_help, "[H]elp")
                    mapd("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")

                    vim.lsp.inlay_hint.enable(true) -- inlay hints by default
                    mapd(
                        "n",
                        "<leader>ci",
                        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end,
                        "[C]ode [I]nlay Hint Toggle"
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>ss",
                        function() vim.cmd.Telescope("lsp_document_symbols") end,
                        { desc = "[S]earch LSP [S]ymbols" }
                    )
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
                "jsonls",
                "lua_ls",
                "marksman",
                "rust_analyzer",
                "texlab",
                "typst_lsp",
            },
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "p00f/clangd_extensions.nvim",
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local lspconfig_util = require("lspconfig/util")
            local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", {})

            -- setting up local language servers before mason language servers
            lspconfig.arduino_language_server.setup({
                filetypes = { "c", "cpp", "arduino" },
                root_dir = lspconfig.util.root_pattern("sketch.yaml"),
                on_attach = function()
                    -- disable clangd language server
                    for _, client in pairs(vim.lsp.get_clients()) do
                        if client.name == "clangd" then
                            vim.lsp.stop_client(client.id)
                        end
                    end
                end,
            })

            lspconfig.clangd.setup({
                on_attach = function(_, _)
                    require("clangd_extensions.inlay_hints").setup_autocmd()
                    require("clangd_extensions.inlay_hints").set_inlay_hints()
                end,
            })

            lspconfig.nushell.setup({})

            lspconfig.verible.setup({
                cmd = { "verible-verilog-ls", "--indentation_spaces=4" },
                root_dir = function(fname)
                    local filename = lspconfig_util.path.is_absolute(fname) and fname
                        or lspconfig_util.path.join(vim.loop.cwd(), fname)
                    return lspconfig_util.root_pattern(".git")(filename) or lspconfig_util.path.dirname(filename)
                end,
            })
            local default_setup = function(server)
                lspconfig[server].setup({ capabilities = require("cmp_nvim_lsp").default_capabilities() })
            end

            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(vim.tbl_extend("keep", opts, {
                handlers = {
                    -- auto-setup lsps
                    default_setup,

                    cssls = function()
                        lspconfig.cssls.setup({
                            init_options = {
                                provideFormatter = false,
                            },
                        })
                    end,

                    html = function()
                        lspconfig.html.setup({
                            init_options = {
                                configurationSection = { "html" },
                                provideFormatter = false,
                                embeddedLanguages = {
                                    css = true,
                                    javascript = true,
                                },
                            },
                        })
                    end,

                    jsonls = function()
                        lspconfig.jsonls.setup({
                            init_options = {
                                provideFormatter = false,
                            },
                        })
                    end,

                    lua_ls = function()
                        lspconfig.lua_ls.setup({
                            Lua = {
                                format = {
                                    enable = false,
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
                                            "--shell-escape",
                                            "-enable-write18",
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
                                            vim.fn.line(".")
                                                .. ":"
                                                .. vim.fn.col(".")
                                                .. ":"
                                                .. vim.fn.shellescape(vim.fn.expand("%:p")),
                                        },
                                    },
                                },
                            },
                        })
                    end,
                },
            }))
        end,
    },
}
