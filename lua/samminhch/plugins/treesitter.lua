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
    },
    opts = {
        highlight = { enabled = true },
        auto_install = true,
        indent = { enable = true, disable = { "python" } },
        context_commentstring = { enable = true, enable_autocmd = false },
        ensure_installed = {
            'c',
            'lua',
            'vim',
            'java',
            'rust',
            'regex',
            'python',
            'markdown',
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
        }
    },
    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end
}
