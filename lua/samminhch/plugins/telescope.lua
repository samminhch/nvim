return {
    'nvim-telescope/telescope.nvim',
    enabled = not vim.g.vscode,
    version = false,
    cmd = 'Telescope',
    keys = {
        { '<leader>sf', '<cmd>Telescope find_files<cr>',  desc = '[S]earch [F]iles' },
        { '<leader>sr', '<cmd>Telescope oldfiles<cr>',    desc = '[S]earch [R]ecent' },
        { '<leader>sg', '<cmd>Telescope git_files<cr>',   desc = '[S]earch [G]it files' },
        { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = '[S]earch [W]ord in file' },
        { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = '[S]earch [D]iagnostics' },
        { '<leader>sb', '<cmd>Telescope buffers<cr>',     desc = '[S]earch [B]uffers' }
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'debugloop/telescope-undo.nvim',
    },
    opts = {
        defaults = {
            vimgrep_arguments = {
                "rg",
                "-L",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
            },
            prompt_prefix = "   ",
            selection_caret = "  ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_ignore_patterns = { "node_modules" },
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        }
    },
}
