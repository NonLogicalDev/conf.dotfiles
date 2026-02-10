return {
  -- Repeat plugin commands with .
  { "tpope/vim-repeat", event = "VeryLazy" },

  -- Surround text objects
  { "tpope/vim-surround", event = "VeryLazy" },

  -- Toggle comments
  { "tpope/vim-commentary", event = "VeryLazy" },

  -- Auto-close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Text alignment
  {
    "godlygeek/tabular",
    cmd = "Tabularize",
  },

  -- Additional text objects
  { "wellle/targets.vim", event = "VeryLazy" },
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" },

  -- Buffer management
  { "vim-scripts/bufkill.vim", cmd = { "BD", "BUN" } },
}
