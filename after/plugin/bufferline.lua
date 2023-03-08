require("bufferline").setup {
    options = {
        offsets = {
            { filetype = "NvimTree", text = "", padding = 1 },
        },
        show_buffer_close_icons = true,
        separator_style = "thin",
        tab_size = 20,
        show_tab_indicators = true,
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        show_close_icon = true,
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "coc"
    }
}

local nmapd = function(binding, value, description)
    vim.keymap.set('n', binding, value, { desc = description })
end

nmapd('<s-l>', vim.cmd.BufferLineCycleNext, 'Next Buffer')
nmapd('<s-h>', vim.cmd.BufferLineCyclePrev, 'Previous Buffer')
