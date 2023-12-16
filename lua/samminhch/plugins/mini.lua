-- These configs were mostly taken from www.lazyvim.org. Thanks guys <3
return {
    {
        'echasnovski/mini.animate',
        cond = not (vim.g.neovide or vim.g.vscode),
        version = false,
        event = 'VeryLazy',
        opts = function()
            local mouse_scrolled = false
            for _, scroll in ipairs({ 'Up', 'Down' }) do
                local key = '<ScrollWheel' .. scroll .. '>'
                vim.keymap.set({ '', 'i' }, key, function()
                    mouse_scrolled = true
                    return key
                end, { expr = true })
            end

            local animate = require('mini.animate')

            return {
                resize = {
                    timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
                },
                scroll = {
                    timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
                    subscroll = animate.gen_subscroll.equal({
                        predicate = function(total_scroll)
                            if mouse_scrolled then
                                mouse_scrolled = false
                                return false
                            end
                            return total_scroll > 1
                        end,
                    }),
                },
            }
        end,
    },
    {
        'echasnovski/mini.indentscope',
        cond = not vim.g.vscode,
        version = false,
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            symbol = '┊',
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason' },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
        config = function(_, opts)
            require('mini.indentscope').setup(opts)
        end,
    }
}
