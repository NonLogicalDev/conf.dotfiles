return {
  -- Colorscheme
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000, config = function ()
      require("gruvbox").setup({})
      if vim.g.user_colorway == "gruvbox" then
        vim.cmd.colorscheme('gruvbox')
      end
    end,
  },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      require("tokyonight").setup({})
      if vim.g.user_colorway == "tokyonight" then
        vim.cmd.colorscheme('tokyonight')
      end
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, config = function()
      require("catppuccin").setup({})
      if vim.g.user_colorway == "catppuccin" then
        vim.cmd.colorscheme('catppuccin')
      end
    end,
  },
}
