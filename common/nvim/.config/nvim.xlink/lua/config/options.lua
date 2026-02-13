-- Editor options
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.shiftround = true
vim.opt.smarttab = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.gdefault = true

-- UI
vim.opt.wrap = false
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.title = true

-- Files
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.autowrite = true

-- Clipboard: disable auto-sync with system clipboard
-- Use explicit "+ register or keybindings to copy to system clipboard
vim.opt.clipboard = ""

-- If system clipboard is not available, override + register with OSC-52
if vim.fn.has('clipboard') == 0 then
  local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
  end

  local function paste()
    return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy},
    paste = {['+'] = paste, ['*'] = paste},
  }
end

-- Misc
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.iskeyword:append("-")
vim.opt.history = 10000
vim.opt.undolevels = 10000
vim.opt.backspace = "indent,eol,start"
vim.opt.visualbell = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.completeopt = "menu,menuone,longest"
vim.opt.switchbuf = "useopen,usetab"

-- NeoVim specific
vim.opt.inccommand = "nosplit"
vim.cmd("syntax sync minlines=256")

-- Disable polyglot for specific filetypes (must be before plugin load)
vim.g.polyglot_disabled = {'python-indent', 'indent/python.vim', 'autoindent'}
vim.g.pymode_indent = 0

-- Python highlighting
vim.g.python_highlight_all = 1

-- Grep program
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
elseif vim.fn.executable("ack") == 1 then
  vim.opt.grepprg = "ack"
end

-- Markdown folding
vim.g.markdown_folding = 1
vim.g.javaScript_fold = 2

-- Netrw
vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0

-- Auto restore last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Configure LSP Diagnostics Inline
vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })
