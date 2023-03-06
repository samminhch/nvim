-- ██████╗ ██╗     ██╗   ██╗ ██████╗ ██╗███╗  ██╗ ██████╗   ██╗     ██╗   ██╗ █████╗
-- ██╔══██╗██║     ██║   ██║██╔════╝ ██║████╗ ██║██╔════╝   ██║     ██║   ██║██╔══██╗
-- ██████╔╝██║     ██║   ██║██║  ██╗ ██║██╔██╗██║╚█████╗    ██║     ██║   ██║███████║
-- ██╔═══╝ ██║     ██║   ██║██║  ╚██╗██║██║╚████║ ╚═══██╗   ██║     ██║   ██║██╔══██║
-- ██║     ███████╗╚██████╔╝╚██████╔╝██║██║ ╚███║██████╔╝██╗███████╗╚██████╔╝██║  ██║
-- ╚═╝     ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚══╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-------------------------------------------------------------------------------------
-- @author Minh Nguyen
-- @github https://github.com/samminhch
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local nocode = function()
    return vim.fn.exists('g:vscode') == 0
end

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -------------
    -- Plugins --
    -------------
    use { 'mbbill/undotree', cond = { nocode } }
    use { 'paretje/nvim-man' }
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-surround' }
    use { 'wellle/targets.vim' }
    use { 'rcarriga/nvim-notify', cond = { nocode } }
    use { 'Raimondi/delimitMate' }
    use { 'mfussenegger/nvim-jdtls', cond = { nocode } }
    use { 'lewis6991/gitsigns.nvim', cond = { nocode } }
    use { 'norcalli/nvim-colorizer.lua', cond = { nocode } }
    use { 'lukas-reineke/indent-blankline.nvim', cond = { nocode } }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        cond = { nocode }
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } },
        cond = { nocode }
    }

    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1 and nocode
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        cond = { nocode }
    }

    use { 'neoclide/coc.nvim', branch = 'release', cond = { nocode } }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
        cond = { nocode }
    })

    use {
        'goolord/alpha-nvim',
        config = function()
            require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        end,
        cond = { nocode }
    }

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
        cond = { nocode }
    }
    ------------
    -- Themes --
    ------------
    use {
        'sainnhe/everforest',
        as = 'everforest',
        config = function()
            vim.g.everforest_background = 'hard'
            vim.g.everforest_disable_italic_comment = true
            vim.g.everforest_transparent_background = true
            vim.g.everforest_better_performance = true

            vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
            vim.cmd.colorscheme('everforest')
        end,
        cond = { nocode }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
