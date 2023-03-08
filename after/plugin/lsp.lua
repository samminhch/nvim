-- Define what COC extensions are going to be installed
vim.g.coc_global_extensions = {
    'coc-sh',
    'coc-html',
    'coc-java',
    'coc-jedi',
    'coc-json',
    'coc-clangd',
    'coc-docker',
    'coc-eslint',
    'coc-vimlsp',
    'coc-snippets',
    'coc-sumneko-lua',
    'coc-markdownlint',
    'coc-rust-analyzer',
    'coc-spell-checker',
    'coc-html-css-support',
    'https://github.com/rafamadriz/friendly-snippets@main'
}

local map = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }

-- Move between suggestions
map("i", "<c-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<c-n>" : coc#refresh()', opts)
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
map("n", "K", "<cmd>call CocAction('doHover')<CR>", { silent = true })

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

opts = { silent = true, nowait = true }
map("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
map("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

map("n", "<leader>ca", "<Plug>(coc-codeaction)", opts)

-- Remap keys for apply refactor code actions.
map("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
map("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
map("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
map("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
map("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
map("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
map("i", "<C-f>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
map("i", "<C-b>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
map("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
map("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
