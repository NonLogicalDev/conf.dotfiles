return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          theme = vim.g.user_colorway_lualine,
          icons_enabled = false,
          component_separators = "",
          section_separators = "",
        },
      })
    end,
  },

  {
    'akinsho/bufferline.nvim',
    version = "*", 
    event = "VeryLazy",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    config = function ()
      require("bufferline").setup({})
    end,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
      { "<leader>m", "<cmd>NvimTreeFindFile<cr>", desc = "Find Current File in Explorer" },
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = false,
        hijack_netrw = true,
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = false,
            },
          },
        },
        git = {
          enable = false,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
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
