return {
    "frabjous/knap",
    keys = {
        {
            '<f5>',
            function() require('knap').process_once() end,
            { silent = true, desc = 'Process Once' }
        },
        {
            '<f6>',
            function() require('knap').close_viewer() end,
            { silent = true, desc = 'Process Once' }
        },
        {
            '<f7>',
            function() require('knap').toggle_autopreviewing() end,
            { silent = true, desc = 'Process Once' }
        },
        {
            '<f8>',
            function() require('knap').forward_jump() end,
            { silent = true, desc = 'Process Once' }
        },
    },
    config = function()
        -- set your preferred browser here
        local browser = 'com.brave.Browser'

        -- if vim.fn.has('mac') == 1 then
        --     browser = vim.fn.system('defaults read com.apple.browser DefaultBrowser')
        -- elseif vim.fn.has('unix') == 1 then
        --     browser = vim.fn.system('xdg-settings get default-web-browser')
        -- elseif vim.fn.get('win32') then
        --     browser = vim.fn.system('Get-DefaultBrowser')
        -- end

        -- Change this variable if you want to change settings
        local gknapsettings = {
            textopdf = "lualatex -synctex=1 -interaction=batchmode %docroot%",
            mdtohtmlviewerlaunch = browser ..
                'file://' .. vim.fn.getcwd() .. '%outputfile'
        }
        vim.g.knap_settings = gknapsettings
    end
}
