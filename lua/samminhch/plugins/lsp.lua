return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        config = function()
            require('lsp-zero.settings').preset({})
        end
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
    -- autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' }, -- Required
        },
        config = function()
            require('lsp-zero.cmp').extend()

            local lsp = require('lsp-zero').preset({})
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<c-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<c-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<cr>'] = cmp.mapping.confirm({ select = true }),
                ['<c-space>'] = cmp.mapping.complete(),
            })

            lsp.setup_nvim_cmp({ mapping = cmp_mappings })
        end
    },
    -- lsp
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            { 'mfussenegger/nvim-jdtls' },
        },
        config = function()
            require('mason').setup({
                ui = {
                    border = 'rounded'
                }
            })

            local lsp = require('lsp-zero').preset({})

            lsp.ensure_installed({
                'jdtls',
                'lua_ls',
                'clangd',
                'jedi_language_server',
                'bashls',
            })

            lsp.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['jdtls'] = { 'java' },
                    ['clangd'] = { 'c', 'cpp' }
                }
            })

            lsp.on_attach(function(client, buffer)
                local mapd = function(mode, binding, value, description)
                    local opts = { buffer = buffer, remap = false, desc = description }
                    vim.keymap.set(mode, binding, value, opts)
                end

                mapd('n', '<leader>gd', function() vim.lsp.buf.definition() end, '[G]o to [D]efinition')
                mapd('n', '<leader>gD', function() vim.lsp.buf.declaration() end, '[G]o to [D]eclaration')
                mapd('n', '<leader>gi', function() vim.lsp.buf.implementation() end, '[G]o to [I]mplementation')
                mapd('n', '<leader>gr', function() vim.lsp.buf.references() end, '[G]o to [R]eferences')
                mapd('n', '<leader>rn', function() vim.lsp.buf.rename() end, '[R]e[N]ame')
                mapd('n', 'K', function() vim.lsp.buf.hover() end, 'Hover')
                mapd('n', '<leader>ca', function() vim.lsp.buf.code_action() end, '[C]ode [A]ction')
                mapd('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, '[C]ode [F]ormat')
                mapd('i', '<c-h>', function() vim.lsp.buf.signature_help() end, '[H]elp')
                mapd('n', '[d', function() vim.diagnostic.goto_prev() end, 'Go to Next Diagnostic')
                mapd('n', ']d', function() vim.diagnostic.goto_next() end, 'Go to Previous Diagnostic')
                mapd('n', '<cr>', function() vim.lsp.buf.confirm({ select = true }) end, '')
            end)

            -- ignore the lua lsp warning text
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            require('mason').setup()
            require('mason-lspconfig').setup()

            -- ignore jdtls, let nvim-jdtls take over
            lsp.skip_server_setup({ 'jdtls' })

            lsp.setup()
        end
    },
    -- debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "jbyuki/one-small-step-for-vimkind" },
        },
        keys = {
            { '<leader>dt',  function() require('dapui').toggle() end,          desc = '[D]ebugger [T]oggle' },
            { '<leader>db',  function() require('dap').toggle_breakpoint() end, desc = '[D]ebugger Toggle [B]reakpoint' },
            { '<leader>dr',  function() require('dap').run_to_cursor() end,     desc = '[D]ebugger [R]un to Cursor' },
            { '<leader>dc',  function() require('dap').continue() end,          desc = '[D]ebugger [C]ontinue' },
            { '<leader>dp',  function() require('dap').pause.toggle() end,      desc = '[D]ebugger Toggle [P]ause' },
            { '<leader>dR',  function() require('dap').repl.toggle() end,       desc = '[D]ebugger Toggle [R]EPL' },
            { '<leader>dsi', function() require('dap').step_into() end,         desc = '[D]ebugger [S]tep [I]nto' },
            { '<leader>dso', function() require('dap').step_over() end,         desc = '[D]ebugger [S]tep [O]ver' },
            { '<leader>dsO', function() require('dap').step_out() end,          desc = '[D]ebugger [S]tep [O]ut' },
            { '<leader>dsO', function() require('dap').step_out() end,          desc = '[D]ebugger [S]tep [O]ut' },
        },
        config = function(plugin, opts)
            require("nvim-dap-virtual-text").setup {
                commented = true,
            }

            local dap, dapui = require('dap'), require('dapui')
            dapui.setup()
            local codelldb_install = require('mason-registry').get_package('codelldb'):get_install_path()

            dap.adapters.codelldb = {
                type = 'server',
                port = '${port}',
                executable = {
                    command = codelldb_install .. '/extension/adapter/codelldb',
                    args = { '--port', '${port}' },
                    detached = vim.fn.has('win32') ~= 1
                }
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
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
