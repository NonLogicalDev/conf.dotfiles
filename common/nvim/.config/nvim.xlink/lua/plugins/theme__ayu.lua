return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
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
}
