return {
    'neoclide/coc.nvim',
    branch = 'release',
    enabled = not vim.g.vscode,
    lazy = false,
    config = function()
        vim.g.coc_global_extensions = {
            'coc-sh',
            'coc-java',
            'coc-jedi',
            'coc-clangd',
            'coc-vimlsp',
            'coc-pyright',
            'coc-webview',
            'coc-pydocstring',
            'coc-sumneko-lua',
            'coc-rust-analyzer',
            '@yaegassy/coc-pylsp',
            'coc-markdown-preview-enhanced',
            'https://github.com/rafamadriz/friendly-snippets@main'
        }

        vim.api.nvim_create_augroup('CocGroup', {})
        -- Autocommands
        vim.api.nvim_create_autocmd('CursorHold', {
            group = 'CocGroup',
            command = "silent call CocActionAsync('highlight')",
            desc = 'Highlight symbol under cursor on CursorHold'
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = 'CocGroup',
            pattern = 'typescript,json',
            command = "setl formatexpr=CocAction('formatSelected')",
            desc = 'Setup formatexpr sepcified filetype(s)'
        })

        -- User Commands
        vim.api.nvim_create_user_command('Format', "call CocAction('format')", {})

        vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

        vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})


        -- Keymaps (It won't let me do it in the keymaps spec for some reason... bummer!)
        local map = require('samminhch.utils').map

        local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
        -- Move between suggestions
        map("i", "<c-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<c-n>" : coc#refresh()',
            opts)
        map("i", "<c-p>", [[coc#pum#visible() ? coc#pum#prev(1) : "<c-p>"]], opts)
        -- Confirm selection
        map("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "<cr>"]], opts)
        -- Expand snippets
        map("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

        -- Navigate diagnostics
        -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
        map("n", "<leader>dn", "<Plug>(coc-diagnostic-next)", { silent = true })
        map("n", "<leader>dp", "<Plug>(coc-diagnostic-prev)", { silent = true })

        -- GoTo code navigation
        map("n", "<leader>gd", "<Plug>(coc-definition)", { silent = true })
        map("n", "<leader>gt", "<Plug>(coc-type-definition)", { silent = true })
        map("n", "<leader>gi", "<Plug>(coc-implementation)", { silent = true })
        map("n", "<leader>gr", "<Plug>(coc-references)", { silent = true })

        map("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true })

        map("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true })
        map("n", "K", "<cmd>call CocAction('doHover')<CR>", { silent = true })

        opts = { silent = true, nowait = true }
        map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
        map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

        map("n", "<leader>ca", "<Plug>(coc-codeaction-cursor)", opts)
        -- Remap keys for apply refactor code actions.
        map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
        map("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
        map("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

        -- Run the Code Lens actions on the current lin
        map("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

        opts = { silent = true, nowait = true, expr = true }
        map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
        map("i", "<C-f>",
            'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
        map("i", "<C-b>",
            'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
        map("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
        map("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
    end
}
