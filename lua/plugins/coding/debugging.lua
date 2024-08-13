return {
    "mfussenegger/nvim-dap",
    cond = not vim.g.vscode,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "jbyuki/one-small-step-for-vimkind",
    },
    keys = {
        {
            "<leader>dt",
            function()
                require("dapui").toggle()
            end,
            desc = "[D]ebugger [T]oggle",
        },
        {
            "<leader>db",
            function()
                require("dap").toggle_breakpoint()
            end,
            desc = "[D]ebugger Toggle [B]reakpoint",
        },
        {
            "<leader>dr",
            function()
                require("dap").run_to_cursor()
            end,
            desc = "[D]ebugger [R]un to Cursor",
        },
        {
            "<leader>dc",
            function()
                require("dap").continue()
            end,
            desc = "[D]ebugger [C]ontinue",
        },
        {
            "<leader>dp",
            function()
                require("dap").pause.toggle()
            end,
            desc = "[D]ebugger Toggle [P]ause",
        },
        {
            "<leader>dR",
            function()
                require("dap").repl.toggle()
            end,
            desc = "[D]ebugger Toggle [R]EPL",
        },
        {
            "<leader>dsi",
            function()
                require("dap").step_into()
            end,
            desc = "[D]ebugger [S]tep [I]nto",
        },
        {
            "<leader>dso",
            function()
                require("dap").step_over()
            end,
            desc = "[D]ebugger [S]tep [O]ver",
        },
        {
            "<leader>dsO",
            function()
                require("dap").step_out()
            end,
            desc = "[D]ebugger [S]tep [O]ut",
        },
    },
    config = function()
        require("nvim-dap-virtual-text").setup({
            commented = true,
        })

        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()

        -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-%28via--codelldb%29
        if not dap.adapters.codelldb then
            local codelldb_install = require("mason-registry").get_package("codelldb"):get_install_path()
            dap.adapters.codelldb = {
                type = "server",
                host = "localhost",
                port = "${port}",
                executable = {
                    command = codelldb_install .. "/extension/adapter/codelldb",
                    args = { "--port", "${port}" },
                    detached = vim.fn.has("win32") ~= 1,
                },
            }
        end

        dap.configurations.cpp = {
            {
                type = "codelldb",
                request = "launch",
                name = "Launch file",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
            },
            {
                type = "codelldb",
                request = "attach",
                name = "Attach to process",
                processId = require("dap.utils").pick_process,
                cwd = "${workspaceFolder}",
            },
        }

        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        -- dap listeners
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
}
