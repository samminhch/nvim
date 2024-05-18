return {
    "hrsh7th/nvim-cmp",
    cond = not vim.g.vscode,
    dependencies = {
        "onsails/lspkind.nvim", -- cute little icons!

        -- sources
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-cmdline",
        {
            "L3MON4D3/LuaSnip",
            -- follow latest release.
            version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            -- install jsregexp (optional!).
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
                "saadparwaiz1/cmp_luasnip",
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })
        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })

        return {
            preselect = "item",
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "emoji" },
                { name = "path" },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<c-y>"] = cmp.mapping.confirm({ select = true }),
                ["<c-space>"] = cmp.mapping.complete(),
                ["<c-n>"] = cmp.mapping.select_next_item(),
                ["<c-p>"] = cmp.mapping.select_prev_item(),
                ['<c-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<c-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),
                ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
            },
            -- window = {
            --     completion = cmp.config.window.bordered(),
            --     documentation = cmp.config.window.bordered(),
            -- },
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    before = function(_, vim_item)
                        return vim_item
                    end,
                }),
            },
        }
    end
}
