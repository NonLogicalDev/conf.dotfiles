return {
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
  opts = {}, -- check the "./lua/bookmarks/default-config.lua" file for all the options
}
