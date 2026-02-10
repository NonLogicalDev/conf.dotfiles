return {
  -- Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
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
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
      {
        "<leader>m",
        function()
          require("nvim-tree.api").tree.open()
          require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
        end,
        desc = "Open File Explorer at CWD"
      },
    },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = {
          icons = {
            show = {
              file = false,
              folder = false,
              folder_arrow = true,
              git = false,
            },
            glyphs = {
              default = "",
              symlink = "",
              folder = {
                arrow_closed = "+",
                arrow_open = "-",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
            },
          },
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
