return {
  "SirVer/ultisnips",
  event = "InsertEnter",
  dependencies = { "honza/vim-snippets" },
  config = function()
    -- Custom snippet directories
    vim.g.UltiSnipsSnippetDirectories = {
      vim.fn.stdpath("config") .. "/UltiSnips",
      "UltiSnips",
    }
  end,
}
