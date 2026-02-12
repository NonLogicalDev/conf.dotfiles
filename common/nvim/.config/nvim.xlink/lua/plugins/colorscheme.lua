return {
  -- Colorscheme
  { "ellisonleao/gruvbox.nvim", lazy = false, priority = 1000, config = function ()
      require("gruvbox").setup({})
      if vim.g.user_colorway == "gruvbox" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
    end,
  },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      require("tokyonight").setup({})
      if vim.g.user_colorway == "tokyonight" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000, config = function()
      require("catppuccin").setup({})
      if vim.g.user_colorway == "catppuccin" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
      if vim.g.user_colorway == "catppuccin-latte" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
      if vim.g.user_colorway == "catppuccin-mocha" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
    end,
  },
  { "Shatur/neovim-ayu", lazy = false, priority = 1000, config = function()
      require("ayu").setup({})
      if vim.g.user_colorway == "ayu" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
      if vim.g.user_colorway == "ayu-dark" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
      if vim.g.user_colorway == "ayu-mirage" then
        vim.cmd.colorscheme(vim.g.user_colorway)
      end
    end,
  },
}
