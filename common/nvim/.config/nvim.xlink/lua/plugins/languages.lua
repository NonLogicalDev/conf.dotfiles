return {
  -- Polyglot language pack
  {
    "sheerun/vim-polyglot",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      -- Must be set before plugin loads
      vim.g.polyglot_disabled = {
        "python-indent",
        "indent/python.vim",
        "autoindent",
      }
    end,
  },

  -- Jinja templates
  {
    "lepture/vim-jinja",
    ft = "jinja",
  },

  -- Dash documentation lookup
  {
    "rizzatti/dash.vim",
    cmd = { "Dash", "DashKeywords" },
  },
}
