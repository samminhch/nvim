return {
    "mfussenegger/nvim-dap-python",
    build = ":TSInstall python",
    ft = "python",
    config = function() require("dap-python").setup("/usr/bin/python3") end,
}
