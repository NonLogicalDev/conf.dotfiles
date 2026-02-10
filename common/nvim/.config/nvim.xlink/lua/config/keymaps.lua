local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General mappings
keymap("n", "tn", ":tabnext<CR>", opts)
keymap("n", "tp", ":tabprev<CR>", opts)
keymap("n", "te", ":tabedit<CR>", opts)
keymap("n", "to", ":tabonly<CR>", opts)

keymap("n", "<C-w><Tab>", ":tabnext<CR>", opts)
keymap("n", "<C-w><S-Tab>", ":tabprev<CR>", opts)

-- Direct tab access
keymap("n", "<C-w>1", "1gt", opts)
keymap("n", "<C-w>2", "2gt", opts)
keymap("n", "<C-w>3", "3gt", opts)
keymap("n", "<C-w>4", "4gt", opts)
keymap("n", "<C-w>5", "5gt", opts)
keymap("n", "<C-w>6", "6gt", opts)
keymap("n", "<C-w>7", "7gt", opts)
keymap("n", "<C-w>8", "8gt", opts)
keymap("n", "<C-w>9", "9gt", opts)

-- Select recently changed text
keymap("n", "<leader>v", "`[v`]", opts)
keymap("n", "<leader>V", "`[V`]", opts)

-- Improve selecting everything
keymap("n", "vgA", "ggVG", opts)

-- Change directory to current file
keymap("n", "<leader><leader>m", ":cd %:p:h<CR>:pwd<CR>", opts)

-- Toggle hlsearch
keymap("n", "<leader>'", function()
  vim.opt.hlsearch = not vim.opt.hlsearch:get()
end, opts)

keymap("n", "<leader><leader>`", ":set nohlsearch<CR>", opts)

-- Search enhancements (auto-enable hlsearch when searching)
keymap("n", "n", ":set hlsearch<CR>n", opts)
keymap("n", "N", ":set hlsearch<CR>N", opts)

-- Clear hlsearch with Enter in normal mode
keymap("n", "<CR>", function()
  if vim.opt.hlsearch:get() then
    vim.opt.hlsearch = false
    return ""
  else
    return "<CR>"
  end
end, { expr = true })

-- Buffer navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Terminal mode escape
keymap("t", "<C-\\><C-[>", "<C-\\><C-n>", opts)
keymap("t", "<C-\\><C-]>", "<C-\\><C-n>pi", opts)

-- Disable Q (ex mode)
keymap("n", "Q", "<nop>", opts)

-- Improve indenting experience (reselect indented text)
keymap("v", "<", "<gv", opts)

-- Make saving easier
vim.api.nvim_create_user_command("W", "w", {})

-- Newlines in insert mode
keymap("i", "<C-j>", "<CR><C-o>O", opts)

-- Quickfix list toggle
local function toggle_list(bufname, prefix)
  local buflist = vim.fn.execute("ls")
  for _, bufnum in ipairs(vim.fn.map(vim.fn.filter(vim.fn.split(buflist, '\n'), 'v:val =~ "' .. bufname .. '"'), 'str2nr(matchstr(v:val, "\\d\\+"))')) do
    if vim.fn.bufwinnr(bufnum) ~= -1 then
      vim.cmd(prefix .. 'close')
      return
    end
  end
  if prefix == 'l' and #vim.fn.getloclist(0) == 0 then
    vim.api.nvim_echo({{"Location List is Empty.", "ErrorMsg"}}, true, {})
    return
  end
  local winnr = vim.fn.winnr()
  vim.cmd('botright ' .. prefix .. 'window')
  if vim.fn.winnr() ~= winnr then
    vim.cmd('wincmd p')
  end
end

keymap("n", "<leader><leader>q", function() toggle_list("Quickfix List", 'c') end, opts)
keymap("n", "<leader><leader>Q", function() toggle_list("Quickfix List", 'c') end, opts)
