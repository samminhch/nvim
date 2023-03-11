local utils = {}

---@param plugin string
function utils.has(plugin)
    return require('lazy.core.config').plugins[plugin]~=nil
end

---@param fn fun()
function utils.on_very_lazy(fn)
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
      fn()
    end,
  })
end

function utils.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

function utils.map(mode, binding, value, options)
    vim.keymap.set(mode, binding, value, options)
end

function utils.nmapd(binding, value, description)
    utils.map('n', binding, value, {desc = description})
end

return utils
