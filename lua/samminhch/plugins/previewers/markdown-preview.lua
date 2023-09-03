return {
    "iamcco/markdown-preview.nvim",
    config = function()
        vim.fn["mkdp#util#install"]()

        vim.g.mkdp_preview_options = {
            content_editable = true,
            disable_filename = 1
        }

        -- disabled for now because i suck at css
        -- vim.g.mkdp_markdown_css = vim.fn.stdpath('config') ..
        --     '/lua/samminhch/plugins/previewers/markdown.css'
        vim.g.mkdp_page_title = '${name}'
        vim.g.mkdp_theme = 'light'
    end,
}
