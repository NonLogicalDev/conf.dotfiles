return {
  "ojroques/nvim-bufdel",
  cmd = { "BufDel", "BufDelAll", "BufDelOthers", "BD", "BUN", "BW" },
  config = function()
    require("bufdel").setup({})

    -- Create aliases for compatibility with old bufkill commands
    vim.api.nvim_create_user_command("BD", function(opts)
      vim.cmd((opts.bang and "BufDel!" or "BufDel") .. " " .. opts.args)
    end, { bang = true, nargs = "*" })

    vim.api.nvim_create_user_command("BUN", function(opts)
      vim.cmd((opts.bang and "BufDel!" or "BufDel") .. " " .. opts.args)
    end, { bang = true, nargs = "*" })

    vim.api.nvim_create_user_command("BW", function(opts)
      vim.cmd("BufDel! " .. opts.args)
    end, { nargs = "*" })
  end,
}
