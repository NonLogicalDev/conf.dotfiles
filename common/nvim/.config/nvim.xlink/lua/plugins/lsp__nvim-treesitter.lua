return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local enabled_langs = {
      'c', 'lua', 'vim', 'vimdoc', 'query', 'javascript', 'typescript', 'html', 'yaml', 'go', 'rust'
    }
    treesitter.setup()
    treesitter.install(enabled_langs)

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        -- syntax highlighting, provided by Neovim
        local ts_available = pcall(vim.treesitter.start)
        -- folds, provided by Neovim (I don't like folds)
        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter (only if parser available)
        if ts_available then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end
}
