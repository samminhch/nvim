return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    enabled = false,
    opts = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local bundles = {
            vim.fn.glob(
                require("mason-registry").get_package("java-debug-adapter"):get_install_path()
                    .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
                true
            ),
            vim.fn.glob(
                require("mason-registry").get_package("java-test"):get_install_path() .. "/extension/server/*.jar",
                true
            ),
        }

        return {
            cmd = { "jdtls" },
            root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
            init_options = {
                bundles = bundles,
            },
            capabilities = capabilities,
        }
    end,
    config = function(opts)
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls").start_or_attach(opts)
    end,
}
