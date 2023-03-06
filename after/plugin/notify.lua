local ok, notify = pcall(require, 'notify')

if not ok then
    return
end

notify.setup {
    stages = 'fade_in_slide_out',
    background_colour = 'FloatShadow',
    timeout = 3000,
}
vim.notify = require("notify")
