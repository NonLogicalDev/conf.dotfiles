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
