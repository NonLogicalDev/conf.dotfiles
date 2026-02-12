return {
  -- File explorer
  {
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
          dotfiles = true,
        },
      })
    end,
  },

  -- Bookmark Manager
  {
    "LintaoAmons/bookmarks.nvim",
    -- pin the plugin at specific version for stability
    -- backup your bookmark sqlite db when there are breaking changes (major version change)
    tag = "3.2.0",
    lazy = false,
    dependencies = {
      {"kkharji/sqlite.lua"},
      {"nvim-telescope/telescope.nvim"},  -- currently has only telescopes supported, but PRs for other pickers are welcome
      {"stevearc/dressing.nvim"}, -- optional: better UI
      {"GeorgesAlkhouri/nvim-aider"} -- optional: for Aider integration
    },
    config = function()
      local opts = {} -- check the "./lua/bookmarks/default-config.lua" file for all the options
      require("bookmarks").setup(opts) -- you must call setup to init sqlite db
    end,
  },

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
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
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
      telescope.load_extension("fzf")
    end,
  },

  -- Enhanced jump list
  { "vim-scripts/EnhancedJumps", event = "VeryLazy" },
}
