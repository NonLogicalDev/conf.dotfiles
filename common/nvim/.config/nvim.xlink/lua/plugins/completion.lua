return {
  -- Snippet engine
  {
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
  },

  -- Snippet collection
  { "honza/vim-snippets", lazy = true },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "quangnguyen30192/cmp-nvim-ultisnips",
      "SirVer/ultisnips",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
              end
            end,
            { "i", "s" }
          ),
          ["<S-Tab>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                cmp_ultisnips_mappings.jump_backwards(fallback)
              end
            end,
            { "i", "s" }
          ),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Command-line completion
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Git commit completion
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
    end,
  },

  -- Completion sources
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-cmdline", lazy = true },
  { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true },
}
