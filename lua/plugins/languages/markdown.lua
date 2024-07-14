-- install without yarn or npm
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
        vim.g.mkdp_preview_options = {
            sync_scroll_type = "relative",
        }

        vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/plugins/languages/markdown.css")

        vim.g.mkdp_page_title = "${name}"

        vim.g.mkdp_theme = "light"
    end,
}
