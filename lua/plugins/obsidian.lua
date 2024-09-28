local workspaces = require("plugins.secrets.obsidian-workspaces")

return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = function()
        local events = {}

        for idx, _ in ipairs(workspaces) do
            table.insert(events, "BufReadPre " .. workspaces[idx].path .. "/*.md")
            table.insert(events, "BufNewFile " .. workspaces[idx].path .. "/*.md")
        end
        return events
    end,
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = workspaces,
    },
}
