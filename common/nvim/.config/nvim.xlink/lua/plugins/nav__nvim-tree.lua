return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
    { "<leader>m", function()
        require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
      end, desc = "Update nvim-tree CWD to global CWD" },
  },
  config = function()
    require("nvim-tree").setup({
      disable_netrw = false,
      hijack_netrw = true,
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = false,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
