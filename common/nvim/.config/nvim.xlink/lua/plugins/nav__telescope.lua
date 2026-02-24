return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    { "nvim-telescope/telescope-frecency.nvim", version = "*" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jumplist" },
    { "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
    { "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP Definitions" },
    { "<leader>fT", "<cmd>Telescope builtin<cr>", desc = "Telescope Builtin" },
  },
  config = function()
    local telescope = require("telescope")
    local themes = require("telescope.themes")

    telescope.setup({
      defaults = themes.get_ivy(),
      pickers = {
        live_grep = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          additional_args = function(_)
            return { "--hidden" }
          end
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("frecency")
  end,
}
