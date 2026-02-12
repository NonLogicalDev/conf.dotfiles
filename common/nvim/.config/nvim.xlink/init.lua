-- Set leader keys BEFORE loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- vim.g.user_colorway = "ayu-mirage"
-- vim.g.user_colorway = "ayu-dark"
vim.g.user_colorway = "gruvbox"
-- vim.g.user_colorway = "catpucchin"
-- vim.g.user_colorway = "ayu-dark"
vim.g.user_colorway_lualine = "gruvbox"
-- vim.g.user_colorway_lualine = "ayu_dark"
-- vim.g.user_colorway_lualine = "palenight"

-- Disable Netrw for NvimTree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable 24-bit colour
vim.opt.termguicolors = true

-- Bootstrap lazy.nvim
require("config.lazy")

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")
