local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Emit KeymapReady event after VimEnter
augroup("KeymapReady", { clear = true })
autocmd("VimEnter", {
  group = "KeymapReady",
  pattern = "*",
  callback = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "KeymapReady" })

    -- Disable K mapping for man lookup after VimEnter
    vim.keymap.set("n", "K", "<nop>", { noremap = true, silent = true })
  end,
})

-- Python-specific highlighting
augroup("PythonHighlight", { clear = true })
autocmd("FileType", {
  group = "PythonHighlight",
  pattern = "python",
  command = [[syn match pythonBoolean "\(\W\|^\)\@<=self\(\.\)\@="]],
})

-- Filetype-specific settings
augroup("FileTypeSettings", { clear = true })
autocmd("FileType", {
  group = "FileTypeSettings",
  pattern = "markdown",
  callback = function()
    vim.opt_local.foldenable = true
  end,
})

-- StackedGit filetypes
autocmd("BufRead", {
  pattern = "*.stgit-edit.txt",
  command = "setlocal filetype=gitcommit",
})

autocmd("BufRead", {
  pattern = "*.stgit-edit.patch",
  command = "setlocal filetype=gitcommit",
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function ()
    vim.api.nvim_set_hl(0, '@lsp.type.class', { fg='Aqua' })
    vim.api.nvim_set_hl(0, '@lsp.type.function', { fg='Yellow' })
    vim.api.nvim_set_hl(0, '@lsp.type.method', { fg='Green' })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg='Purple' })
    vim.api.nvim_set_hl(0, '@lsp.type.variable', { fg='Blue' })
    vim.api.nvim_set_hl(0, '@lsp.type.property', { fg='Green' })
  end
})

-- Terminal colors for NeoVim (backup)
-- if vim.fn.has('nvim') == 1 then
--   vim.g.terminal_color_0  = '#2e3436'
--   vim.g.terminal_color_1  = '#cc0000'
--   vim.g.terminal_color_2  = '#4e9a06'
--   vim.g.terminal_color_3  = '#c4a000'
--   vim.g.terminal_color_4  = '#3465a4'
--   vim.g.terminal_color_5  = '#75507b'
--   vim.g.terminal_color_6  = '#0b939b'
--   vim.g.terminal_color_7  = '#d3d7cf'
--   vim.g.terminal_color_8  = '#555753'
--   vim.g.terminal_color_9  = '#ef2929'
--   vim.g.terminal_color_10 = '#8ae234'
--   vim.g.terminal_color_11 = '#fce94f'
--   vim.g.terminal_color_12 = '#729fcf'
--   vim.g.terminal_color_13 = '#ad7fa8'
--   vim.g.terminal_color_14 = '#00f5e9'
--   vim.g.terminal_color_15 = '#eeeeec'
-- end

-- Custom RG command - run ripgrep and populate quickfix
vim.api.nvim_create_user_command("RG", function(opts)
  local args = opts.args
  if args == "" then
    vim.notify("RG: No search pattern provided", vim.log.levels.ERROR)
    return
  end

  local cmd = string.format("rg --vimgrep --no-heading --smart-case %s", args)
  local output = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 and #output == 0 then
    vim.notify("RG: No matches found", vim.log.levels.WARN)
    return
  end

  vim.fn.setqflist({}, "r", {
    title = "RG: " .. args,
    lines = output,
  })
  vim.cmd("copen")
end, {
  nargs = "+",
  complete = "file",
  desc = "Search with ripgrep and populate quickfix",
})

-- Custom FD command - run fd and populate quickfix
vim.api.nvim_create_user_command("FD", function(opts)
  local args = opts.args
  if args == "" then
    vim.notify("FD: No pattern provided", vim.log.levels.ERROR)
    return
  end

  local cmd = string.format("fd %s", args)
  local output = vim.fn.systemlist(cmd)

  if vim.v.shell_error ~= 0 and #output == 0 then
    vim.notify("FD: No matches found", vim.log.levels.WARN)
    return
  end

  -- Convert fd output to quickfix format
  local qf_list = {}
  for _, file in ipairs(output) do
    table.insert(qf_list, {
      filename = file,
      lnum = 1,
      text = file,
    })
  end

  vim.fn.setqflist({}, "r", {
    title = "FD: " .. args,
    items = qf_list,
  })
  vim.cmd("copen")
end, {
  nargs = "+",
  complete = "file",
  desc = "Find files with fd and populate quickfix",
})
