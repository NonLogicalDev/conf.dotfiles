return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Modern snippet collection
    "honza/vim-snippets", -- vim-snippets support
  },
  build = "make install_jsregexp", -- Optional: for regex transformations
  config = function()
    local luasnip = require("luasnip")

    -- Load snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load snippets from vim-snippets (UltiSnips format)
    require("luasnip.loaders.from_snipmate").lazy_load()

    -- LuaSnip configuration
    luasnip.config.set_config({
      history = true, -- Keep around last snippet local to jump back
      updateevents = "TextChanged,TextChangedI", -- Update changes as you type
      enable_autosnippets = true,
      ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
          active = {
            virt_text = { { "●", "GruvboxOrange" } },
          },
        },
      },
    })

    -- Keybindings for snippet navigation
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = "Expand or jump forward in snippet" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true, desc = "Jump backward in snippet" })

    vim.keymap.set("i", "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { silent = true, desc = "Cycle through snippet choices" })
  end,
}
