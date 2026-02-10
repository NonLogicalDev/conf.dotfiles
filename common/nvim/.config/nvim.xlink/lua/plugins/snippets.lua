return {
  -- Snippet engine
  {
    "SirVer/ultisnips",
    event = "InsertEnter",
    dependencies = { "honza/vim-snippets" },
    config = function()
      -- UltiSnips triggers are handled by nvim-cmp
      vim.g.UltiSnipsExpandTrigger = "<nop>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
      vim.g.UltiSnipsEditSplit = "vertical"

      -- Custom snippet directories
      vim.g.UltiSnipsSnippetDirectories = {
        vim.fn.stdpath("config") .. "/UltiSnips",
        "UltiSnips",
      }
    end,
  },

  -- Snippet collection
  { "honza/vim-snippets", lazy = true },
}
