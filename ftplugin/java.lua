local bundles = {
    vim.fn.glob(
        require("mason-registry").get_package("java-debug-adapter"):get_install_path()
        .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true
    ),
}

vim.list_extend(bundles,
    vim.split(
        vim.fn.glob(
            require("mason-registry").get_package("java-test"):get_install_path()
            .. "/extension/server/*.jar", true
        ),
        "\n"
    )
)

require("jdtls").start_or_attach({
    cmd = { "jdtls" },
    root_dir = vim.fs.dirname(
        vim.fs.find(
            { "gradlew", ".git", "mvnw" },
            { upward = true })[1]
    ),
    init_options = {
        bundles = bundles
    }
})
