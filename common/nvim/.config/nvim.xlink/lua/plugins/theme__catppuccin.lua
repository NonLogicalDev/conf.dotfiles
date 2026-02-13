return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
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
}
