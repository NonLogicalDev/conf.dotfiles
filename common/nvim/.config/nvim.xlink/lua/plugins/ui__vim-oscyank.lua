return {
  "ojroques/vim-oscyank",
  event = "VeryLazy",
  config = function()
    -- Auto-use OSC-52 for yanking when system clipboard is not available
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("OscYank", { clear = true }),
      callback = function()
        if vim.v.event.operator == 'y' and vim.fn.has('clipboard') == 0 then
          -- System clipboard not available, use OSC-52
          vim.fn.OSCYankRegister('"')
        end
      end,
    })
  end,
  keys = {
    { "<leader>c", "<Plug>OSCYankVisual", mode = "v", desc = "Yank to system clipboard (OSC-52)" },
    { "<leader>o", "<Plug>OSCYank", mode = "n", desc = "Yank to system clipboard (OSC-52)" },
  },
}
