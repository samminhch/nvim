return {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            init = function()
                -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
                local opts = require("lazy.core.plugin").values(plugin, "opts", false)
                local enabled = false
                if opts.textobjects then
                    for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                        if opts.textobjects[mod] and opts.textobjects[mod].enable then
                            enabled = true
                            break
                        end
                    end
                end
                if not enabled then
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                end
            end,
        },
        {
            'nvim-treesitter/playground'
        }
    },
    opts = {
        highlight = { enable = true },
        auto_install = true,
        indent = { enable = true, disable = { "python" } },
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = {
            'c',
            'css',
            'lua',
            'vim',
            'html',
            'java',
            'rust',
            'regex',
            'latex',
            'python',
            'markdown',
            'javascript',
            'typescript',
            'markdown_inline',
        },
        textobjects = {
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']f'] = '@function.outer',
                    [']c'] = '@class.outer'
                },
                goto_prev_start = {
                    ['[f'] = '@function.outer',
                    ['[c'] = '@class.outer'
                }
            }
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end
}
