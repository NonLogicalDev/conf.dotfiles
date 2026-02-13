return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({})
    if vim.g.user_colorway == "tokyonight" then
      vim.cmd.colorscheme(vim.g.user_colorway)
    end
  end,
}
