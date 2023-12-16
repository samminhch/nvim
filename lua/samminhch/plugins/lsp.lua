return {
    {
        "VonHeikemen/lsp-zero.nvim",
        cond = not vim.g.vscode,
        branch = "v2.x",
        config = function()
            local lsp = require("lsp-zero").preset({})
            require("lsp-zero.settings").preset({})

            lsp.ensure_installed({
                "html",
                "cssls",
                "jdtls",
                "bashls",
                "eslint",
                "lua_ls",
                "dockerls",
                "tsserver",
                "angularls",
                "grammarly",
                "rust-analyzer",
                "jedi_language_server",
                "arduino_language_server",
                "docker_compose_language_service",
            })

            lsp.set_sign_icons({
                error = "",
                warn = "",
                hint = "",
                info = "",
            })

            lsp.format_on_save({
                format_opts = {
                    async = true,
                    timeout_ms = 10000,
                },
                servers = {
                    ["lua_ls"] = { "lua" },
                    ["jdtls"] = { "java" },
                    ["arduino_language_server"] = { "cpp", "arduino" },
                    ["clangd"] = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                }
            })

            lsp.on_attach(function(_, _)
                local nmapd = require("samminhch.utils").nmapd
                local mapd = require("samminhch.utils").mapd

                nmapd("gd",
                    function() vim.lsp.buf.definition() end,
                    "[G]o to [D]efinition")

                nmapd("gD",
                    function() vim.lsp.buf.declaration() end,
                    "[G]o to [D]eclaration")

                nmapd("gi",
                    function() vim.lsp.buf.implementation() end,
                    "[G]o to [I]mplementation")

                nmapd("gr",
                    function() vim.lsp.buf.references() end,
                    "[G]o to [R]eferences")

                nmapd("rn",
                    function() vim.lsp.buf.rename() end,
                    "[R]e[N]ame")

                nmapd("K",
                    function() vim.lsp.buf.hover() end,
                    "Hover")

                nmapd("<leader>ca",
                    function() vim.lsp.buf.code_action() end,
                    "[C]ode [A]ction")

                nmapd("<leader>cf",
                    function() vim.lsp.buf.format({ async = true }) end,
                    "[C]ode [F]ormat")

                mapd("i", "<c-h>",
                    function() vim.lsp.buf.signature_help() end,
                    "[H]elp")

                nmapd("[d",
                    function() vim.diagnostic.goto_prev() end,
                    "Go to Next Diagnostic")

                nmapd("]d",
                    function() vim.diagnostic.goto_next() end,
                    "Go to Previous Diagnostic")

                nmapd("<cr>",
                    function() vim.lsp.buf.confirm({ select = true }) end,
                    "")
            end)
        end
    },
    -- lsp
    {
        "neovim/nvim-lspconfig",
        cond = not vim.g.vscode,
        cmd = "LspInfo",
        event = { "BufReadPre", "BufNewFile", "InsertEnter" },
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {
                    ui = { border = "rounded" }
                }
            },
            {
                "folke/neodev.nvim",
                opts = {
                    library = {
                        plugins = { "nvim-dap-ui" },
                        types = true
                    }
                }
            },
            "mfussenegger/nvim-jdtls",
            {
                "simrat39/rust-tools.nvim",
                opts = {
                    server = {
                        on_attach = function(_, bufnr)
                            -- Hover actions
                            vim.keymap.set("n", "K", require("rust-tools").hover_actions.hover_actions,
                                { buffer = bufnr, desc = "Rust Hover Actions" })
                            -- Code action groups
                            vim.keymap.set("n", "<Leader>ca", require("rust-tools").code_action_group.code_action_group,
                                { buffer = bufnr, desc = "Rust Code Action" })
                        end,
                        settings = {
                            ["rust-analyzer"] = {
                                check = {
                                    command = "clippy"
                                }
                            }
                        }
                    },
                    tools = {
                        hover_actions = {
                            auto_focus = true
                        }
                    }
                }
            },
            "barreiroleo/ltex_extra.nvim",
            "p00f/clangd_extensions.nvim",
            "williamboman/mason-lspconfig.nvim", -- Optional
            "hrsh7th/nvim-cmp"
        },
        config = function()
            local lsp = require("lsp-zero").preset({})
            local lspconfig = require("lspconfig")

            lspconfig.clangd.setup({
                on_attach = function(_, _)
                    require("clangd_extensions.inlay_hints").setup_autocmd()
                    require("clangd_extensions.inlay_hints").set_inlay_hints()
                end
            })

            lspconfig.arduino_language_server.setup {
                filetypes = { "cpp", "arduino" },
                root_dir = lspconfig.util.root_pattern("sketch.yaml"),
                on_attach = function()
                    -- disable clangd language server
                    for _, client in pairs(vim.lsp.get_active_clients()) do
                        if client.name == "clangd" then
                            vim.lsp.stop_client(client.id)
                        end
                    end
                end
            }

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

            lspconfig.html.setup({
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    provideFormatter = false,
                    embeddedLanguages = {
                        css = true,
                        javascript = true
                    }
                },
            })

            lspconfig.texlab.setup({
                settings = {
                    texlab = {
                        auxDirectory = "build",
                        build = {
                            onSave = true,
                            forwardSearchAfter = true,
                            args = {
                                "-lualatex", "-f", "-output-directory=build",
                                "-interaction=nonstopmode", "--synctex=1",
                                "-bibtex", "%f"
                            },
                        },
                        chktex = {
                            onEdit = true,
                            onOpenAndSave = true
                        },
                        forwardSearch = {
                            executable = "zathura",
                            args = {
                                "--synctex-forward",
                                vim.fn.line(".") ..
                                ":" .. vim.fn.col(".") .. ":" .. vim.fn.shellescape(vim.fn.expand("%:p")),
                            }
                        }
                    }
                },
                on_attach = function(_, _)
                    -- rest of your on_attach process.
                    require("ltex_extra").setup()
                end,
            })

            -- setup svelte language server
            lspconfig.svelte.setup({})

            -- setup angular language server
            lspconfig.angularls.setup({})

            lsp.skip_server_setup({ "jdtls" })

            lsp.setup()
        end
    },
    {
        "hrsh7th/nvim-cmp",
        cond = not vim.g.vscode,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                -- install jsregexp (optional!).
                build = "make install_jsregexp"
            },
        },
        config = function()
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()
            local cmp_format = require('lsp-zero').cmp_format()
            local luasnip = require("luasnip")

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            require("cmp").setup({
                preselect = "item",
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer" },
                    { name = "luasnip" },
                    { name = "path" },
                },
                mapping = {
                    ["<cr>"] = cmp.mapping.confirm({ select = false }),
                    ["<c-space>"] = require("cmp").mapping.complete(),
                    ["<c-l>"] = cmp_action.luasnip_jump_forward(),
                    ["<c-j>"] = cmp_action.luasnip_jump_backward(),
                    ["<tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- that way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<s-tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<c-b>"] = require("cmp").mapping(require("cmp").mapping.scroll_docs(-4), { "i", "c" }),
                    ["<c-f>"] = require("cmp").mapping(require("cmp").mapping.scroll_docs(4), { "i", "c" }),
                },
                formatting = cmp_format,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                }
            })
        end
    },
    -- debugging
    {
        "mfussenegger/nvim-dap",
        cond = not vim.g.vscode,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
            "jbyuki/one-small-step-for-vimkind",
        },
        keys = {
            { "<leader>dt",  function() require("dapui").toggle() end,          desc = "[D]ebugger [T]oggle" },
            { "<leader>db",  function() require("dap").toggle_breakpoint() end, desc = "[D]ebugger Toggle [B]reakpoint" },
            { "<leader>dr",  function() require("dap").run_to_cursor() end,     desc = "[D]ebugger [R]un to Cursor" },
            { "<leader>dc",  function() require("dap").continue() end,          desc = "[D]ebugger [C]ontinue" },
            { "<leader>dp",  function() require("dap").pause.toggle() end,      desc = "[D]ebugger Toggle [P]ause" },
            { "<leader>dR",  function() require("dap").repl.toggle() end,       desc = "[D]ebugger Toggle [R]EPL" },
            { "<leader>dsi", function() require("dap").step_into() end,         desc = "[D]ebugger [S]tep [I]nto" },
            { "<leader>dso", function() require("dap").step_over() end,         desc = "[D]ebugger [S]tep [O]ver" },
            { "<leader>dsO", function() require("dap").step_out() end,          desc = "[D]ebugger [S]tep [O]ut" },
            { "<leader>dsO", function() require("dap").step_out() end,          desc = "[D]ebugger [S]tep [O]ut" },
        },
        config = function()
            require("nvim-dap-virtual-text").setup {
                commented = true,
            }

            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()
            local codelldb_install = require("mason-registry").get_package("codelldb"):get_install_path()

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = codelldb_install .. "/extension/adapter/codelldb",
                    args = { "--port", "${port}" },
                    detached = vim.fn.has("win32") ~= 1
                }
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            -- dap listeners
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }
}
