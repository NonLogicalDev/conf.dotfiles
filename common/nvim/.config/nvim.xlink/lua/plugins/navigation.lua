return {
  -- Easy motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word" },
      { "fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
      { "fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
      { "fd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
      { "fT", "<cmd>Telescope builtin<cr>", desc = "Telescope Builtin" },
    },
    config = function()
      local telescope = require("telescope")
      local themes = require("telescope.themes")

      telescope.setup({
        defaults = themes.get_ivy(),
      })
    end,
  },

  -- Enhanced jump list
  { "vim-scripts/EnhancedJumps", event = "VeryLazy" },
}
