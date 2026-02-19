return {
  'akinsho/bufferline.nvim',
  version = "*",
  event = "VeryLazy",
  dependencies = {'nvim-tree/nvim-web-devicons'},
  opts = {
    options = {
      -- Use Unicode characters for status indicators
      indicator = {
        icon = '▎',
        style = 'icon',
      },
      buffer_close_icon = '×',
      modified_icon = '●',
      close_icon = '×',
      left_trunc_marker = '◀',
      right_trunc_marker = '▶',

      -- Separator style using Unicode
      separator_style = "thin", -- Uses │ character

      -- Keep devicons for file type icons
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_close_icon = true,

      -- Other useful settings
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and "✖ " or "⚠ "
        return " " .. icon .. count
      end,
    },
  },
}
