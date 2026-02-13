return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = vim.g.user_colorway_lualine,
        icons_enabled = false,
        component_separators = "",
        section_separators = "",
      },
    })
  end,
}
