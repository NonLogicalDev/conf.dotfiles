return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  lazy = false,
  opts = {
    ensure_installed = { "lua_ls", "gopls" },
  },
}
