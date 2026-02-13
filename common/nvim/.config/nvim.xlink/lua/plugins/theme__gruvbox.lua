return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({})
    if vim.g.user_colorway == "gruvbox" then
      vim.cmd.colorscheme(vim.g.user_colorway)
    end
  end,
}
