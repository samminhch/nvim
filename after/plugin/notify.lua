local ok, notify = pcall(require, 'notify')

if not ok then
    return
end

notify.setup {
    stages = 'slide',
    background_colour = 'FloatShadow',
    timeout = 3000,
    fps = 60
}
vim.notify = require("notify")
