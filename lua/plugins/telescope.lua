return {
    {
        "nvim-telescope/telescope.nvim",
        cond = not vim.g.vscode,
        version = false,
        cmd = "Telescope",
        keys = function()
            local builtin = require("telescope.builtin")
            return {
                { "<leader>sf", builtin.find_files,  desc = "[S]earch [F]iles" },
                { "<leader>sr", builtin.oldfiles,    desc = "[S]earch [R]ecent" },
                { "<leader>sg", builtin.git_files,   desc = "[S]earch [G]it files" },
                { "<leader>sw", builtin.grep_string, desc = "[S]earch [W]ord in file" },
                { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
                { "<leader>sb", builtin.buffers,     desc = "[S]earch [B]uffers" },
                { "<leader>sn", builtin.notify,      desc = "[S]earch [N]otifications" },
                { "<leader>sk", builtin.keymaps,     desc = "[Search] [K]eymaps" },
                { "<leader>sh", builtin.help_tags,   desc = "[Search] [H]elp Files" },
                { "<leader>sm", builtin.man_pages,   desc = "[Search] [M]an Pages" },
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
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
            },
            extensions = {
                ["ui-select"] = {
                    require('telescope.themes').get_dropdown(),
                }
            }
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").load_extension("ui-select")
        end
    }
}
