return {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        improved_strings = false,
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",
          icons_enabled = false,
          component_separators = "",
          section_separators = "",
        },
      })
    end,
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    keys = {
      { "<leader>n", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
      {
        "<leader>m",
        function()
          vim.cmd("Neotree dir=" .. vim.fn.getcwd())
        end,
        desc = "Open File Explorer at CWD"
      },
    },
  },

  -- OSC Yank (clipboard via terminal)
  {
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
  },
}
