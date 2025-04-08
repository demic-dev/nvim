-- Minimal and Modular Neovim Configuration

-- Load core settings
require('core.options')
require('core.keymaps')

-- Bootstrap package manager (lazy.nvim)
require('core.lazy')

-- Plugins will be loaded automatically by lazy.nvim