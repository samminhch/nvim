return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        config = function()
            require('lsp-zero.settings').preset({})
        end
    },
    {
        'folke/neodev.nvim',
        opts = {
            library = {
                plugins = { 'nvim-dap-ui' },
                types = true
            }
        }
    },
    -- lsp
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile', 'InsertEnter' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            { 'mfussenegger/nvim-jdtls' },

            -- snippets
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            require('mason').setup({
                ui = {
                    border = 'rounded'
                }
            })

            local lsp = require('lsp-zero').preset({})
            local lspconfig = require('lspconfig')

            lsp.ensure_installed({
                'jdtls',
                'lua_ls',
                'clangd',
                'jedi_language_server',
                'bashls',
                'eslint',
                'tsserver',
                'cssls'
            })

            lsp.set_sign_icons({
                error = '',
                warn = '',
                hint = '',
                info = '',
            })

            lsp.format_on_save({
                format_opts = {
                    async = true,
                    timeout_ms = 10000,
                },
                servers = {
                    ['lua_ls'] = { 'lua' },
                    ['jdtls'] = { 'java' },
                    ['clangd'] = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' }
                }
            })

            lsp.on_attach(function(_, buffer)
                local mapd = function(mode, binding, value, description)
                    local opts = { buffer = buffer, remap = false, desc = description }
                    vim.keymap.set(mode, binding, value, opts)
                end

                mapd('n', '<leader>gd',
                    function() vim.lsp.buf.definition() end,
                    '[G]o to [D]efinition')

                mapd('n', '<leader>gD',
                    function() vim.lsp.buf.declaration() end,
                    '[G]o to [D]eclaration')

                mapd('n', '<leader>gi',
                    function() vim.lsp.buf.implementation() end,
                    '[G]o to [I]mplementation')

                mapd('n', '<leader>gr',
                    function() vim.lsp.buf.references() end,
                    '[G]o to [R]eferences')

                mapd('n', '<leader>rn',
                    function() vim.lsp.buf.rename() end,
                    '[R]e[N]ame')

                mapd('n', 'K',
                    function() vim.lsp.buf.hover() end,
                    'Hover')

                mapd('n', '<leader>ca',
                    function() vim.lsp.buf.code_action() end,
                    '[C]ode [A]ction')

                mapd('n', '<leader>cf',
                    function() vim.lsp.buf.format({ async = true }) end,
                    '[C]ode [F]ormat')

                mapd('i', '<c-h>',
                    function() vim.lsp.buf.signature_help() end,
                    '[H]elp')

                mapd('n', '[d',
                    function() vim.diagnostic.goto_prev() end,
                    'Go to Next Diagnostic')

                mapd('n', ']d',
                    function() vim.diagnostic.goto_next() end,
                    'Go to Previous Diagnostic')

                mapd('n', '<cr>',
                    function() vim.lsp.buf.confirm({ select = true }) end,
                    '')
            end)


            -- When the arduino server starts in these directories, use the provided FQBN.
            -- Note that the server needs to start exactly in these directories.
            -- This example would require some extra modification to support applying the FQBN on subdirectories!
            local my_arduino_fqbn = {
                [vim.loop.os_homedir() .. '/dev/repos/TuppyMkIV/Boat/Arduino'] = { fbqn = 'arduino:avr:mega', cli_config =
                    vim.loop.os_homedir() .. '/.arduino15/arduino-cli.yaml' },
            }

            local DEFAULT_FQBN = 'arduino:avr:uno'

            lspconfig.arduino_language_server.setup {
                on_new_config = function(config, root_dir)
                    local fqbn = my_arduino_fqbn.root_dir
                    if not fqbn then
                        vim.notify(('Could not find which FQBN to use in %q. Defaulting to %q.'):format(root_dir,
                            DEFAULT_FQBN))
                        fqbn = DEFAULT_FQBN
                    end
                    config.cmd = {
                        'arduino-language-server',
                        '-cli-config', '/path/to/arduino-cli.yaml',
                        '-fqbn',
                        fqbn
                    }
                end
            }

            -- ignore the lua lsp warning text
            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

            -- setup svelte language server
            lspconfig.svelte.setup {}

            require('mason').setup()
            require('mason-lspconfig').setup()

            -- ignore jdtls, let nvim-jdtls take over
            lsp.skip_server_setup({ 'jdtls' })

            lsp.setup()

            -- completion MUST be set up after lsp-zero

            local cmp = require('cmp')
            local cmp_action = require('lsp-zero').cmp_action()

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                preselect = 'item',
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'buffer' },
                    { name = 'luasnip' },
                    { name = 'path' },
                },
                mapping = {
                    ['<cr>'] = cmp.mapping.confirm({ select = false }),
                    ['<s-space>'] = cmp.mapping.complete(),
                    ['<c-l>'] = cmp_action.luasnip_jump_forward(),
                    ['<c-j>'] = cmp_action.luasnip_jump_forward(),
                    ['<tab>'] = cmp_action.luasnip_supertab(),
                    ['<s-tab>'] = cmp_action.luasnip_shift_supertab(),
                }
            })
        end
    },
    -- debugging
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            { 'rcarriga/nvim-dap-ui' },
            { 'theHamsta/nvim-dap-virtual-text' },
            { 'nvim-telescope/telescope-dap.nvim' },
            { 'jbyuki/one-small-step-for-vimkind' },
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
        config = function()
            require('nvim-dap-virtual-text').setup {
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
                    name = 'Launch file',
                    type = 'codelldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end
    }
}
