" vim:foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: Oleg Utkin
" Github: nonlogicaldev
" Close/open all folds zm/zr
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              General Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Env Setup: {{{

" This line is important, some backwards compatible features break my setup.
set nocompatible
set guicursor=

" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

func! g:Dir(dir)
  if empty(glob(a:dir))
    call system("mkdir -p " . a:dir)
  endif
  return a:dir
endfunc

func! g:File(path)
  if !filereadable(a:path)
    call system("touch " . a:path)
  endif
  return a:path
endfunc

func! g:VimConfig(path)
  if has("nvim")
    return expand("~/.config/nvim/" . a:path)
  else
    return expand("~/.vim/" . a:path)
  endif
endfunc
call g:Dir(g:VimConfig(""))

func! g:VimData(path)
  if has("nvim")
    return expand("~/.local/share/nvim/". a:path)
  else
    return expand("~/.local/share/nvim/". a:path)
  endif
endfunc
call g:Dir(g:VimData(""))

" Set up Python on macOS:
if filereadable("/usr/local/opt/asdf/shims/python2")
  let g:python_host_prog = '/usr/local/opt/asdf/shims/python2'
elseif filereadable(expand("~/.pyenv/shims/python2"))
  let g:python_host_prog = expand('~/.pyenv/shims/python2')
elseif filereadable("/usr/local/bin/python2")
  let g:python_host_prog = '/usr/local/bin/python2'
endif
if filereadable("/usr/local/opt/asdf/shims/python3")
  let g:python3_host_prog = '/usr/local/opt/asdf/shims/python3'
elseif filereadable(expand("~/.pyenv/shims/python3"))
  let g:python3_host_prog = expand('~/.pyenv/shims/python3')
elseif filereadable("/usr/bin/python3")
  let g:python3_host_prog = '/usr/bin/python3'
endif

command! ReloadConfig :call s:ReloadConfig()
if ! exists("*s:ReloadConfig")
  func! s:ReloadConfig()
    if has("nvim")
      exec "source " . g:VimConfig("init.vim")
    else
      exec "source " . g:VimConfig("../.vimrc")
    endif
  endfunc
endif

" Open the vimrc file
command! Config call s:OpenConfig()
if ! exists("*s:OpenConfig")
  func! s:OpenConfig()
    if has("nvim")
      exec "tabedit " . g:VimConfig("init.vim")
    else
      exec "tabedit " . g:VimConfig("../.vimrc")
    endif
  endfunc
endif

" Open the vimrc dir
command! ConfigDir call s:OpenConfigDir()
if ! exists("*s:OpenConfigDir")
  func! s:OpenConfigDir()
    exec "tabedit " . g:VimConfig(".")
  endfunc
endif

" }}}
" Encoding Settings: {{{

" Choosing the best encoding ever
set encoding=utf-8
" set fileencoding=utf-8

" Changing grep engine to ack, cause it is 1000 times faster and better
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ack")
  set grepprg=ack
endif

" }}}
" Global Mappings: {{{

"set clipboard=unnamedplus
let mapleader = " " " Spaaaaaace.
let maplocalleader = "\\"

" Select most recently changed text.
nnoremap <leader>v `[v`]
nnoremap <leader>V `[V`]

nnoremap <leader><leader>m :cd %:p:h<cr>

" ExMode is not my thing.
nnoremap Q <nop>

" Make twitch saving easier.
command! W w

" Make switching panes easier.
autocmd VimEnter * nmap <tab> <c-w><c-w>

" Fix increment collision with TMUX prefix.
noremap <C-c> <C-a>

" Make selecting easier.
noremap gA ggVG

" Simplified Tab navigation.
nmap <C-w>1 1gt
nmap <C-w>2 2gt
nmap <C-w>3 3gt
nmap <C-w>4 4gt
nmap <C-w>5 5gt
nmap <C-w>6 6gt
nmap <C-w>7 7gt
nmap <C-w>8 8gt
nmap <C-w>9 9gt

nmap <C-w><Tab> :tabnext<CR>
nmap <C-w><S-Tab> :tabprev<CR>

" Simplified interaction with system clipboard.
noremap <localleader>] "*p
noremap <localleader>} "*P
noremap <localleader>[ "*y
noremap <localleader>{ "*Y

" Become a god?
nnoremap <up> <c-w>+
nnoremap <down> <c-w>-
nnoremap <right> <c-w><
nnoremap <left> <c-w>>

imap <C-j> <CR><C-o>O

" By default this calls up man command on whaterver is under the cursor it is
" kinda slow, and I don't use it.
autocmd VimEnter * nmap K <nop>

xnoremap p pgvy

" }}}
" Load Extra Config: {{{

execute 'runtime!' 'init.d/*.vim'

" }}}
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Vim Basic Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor Behaviour: {{{

set backspace=indent,eol,start  " intuitive backspacing.

set autowrite       " Automatically save before :next, :make etc.

set visualbell      " no beeping.

set autoindent      " autoindent if possible
set smartindent     " and try to be smart about
set copyindent      " copy the previous indentation on autoindenting

set tabstop=2       " number of spaces a tab counts for
set shiftwidth=2    " spaces for autoindents
set softtabstop=2   " just in case
set shiftround      " makes indenting a multiple of shiftwidth
set expandtab       " turn a tab into spaces
set smarttab        " smart tab handling for indenting

set hidden          " allows making buffers hidden even with unsaved changes

set history=1000    " remember more commands and search history
set undolevels=1000 " use many levels of undo

" }}}
" Backup File Settings: {{{

" Save Backups to a well known location.
let &backupdir=g:Dir(g:VimConfig("backup"))
set backupcopy=yes

set noswapfile " Don't use swapfile
set nobackup   " Don't create annoying backup files

" }}}
" Cmd Settings: {{{

set wildmenu              " enhanced command line completion.
set wildmode=list:longest " complete files like a shell.

set showcmd               " display incomplete commands.
set showmode              " display the mode you're in.

set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

" }}}
" Regex Settings: {{{

set gdefault        " default regexes to global
set ignorecase      " case-insensitive searching.
set smartcase       " but case-sensitive if expression contains a capital letter.

" }}}
" Interface settings: {{{

set mouse=a

syntax on           " enable syntax
set number          " display numbers
set ruler           " display position in the file
set title           " show title of the document
set showmatch       " show matching brackets
set hlsearch        " highlight search results
set incsearch       " highlight incremental search results
set cursorline      " highlight the line with the cursor

set nowrap          " turn off line wrapping.

set splitright      " Split vertical windows right to the current windows
set splitbelow      " Split horizontal windows below to the current windows

set laststatus=2    " always show statusline

" }}}
"                              Custom Extensions:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle File Browser: {{{

let g:netrw_keepdir = 0
let g:netrw_banner = 0


nmap <silent> <leader>n :NavToggle<cr>
command! NavToggle call s:NavToggle()
func! s:NavToggle()
  if exists(":NERDTabsTreeToggle")
    exec ":NERDTreeTabsToggle"
  elseif exists(":NERDTreeToggle")
    exec ":NERDTreeToggle"
  elseif exists(":VimFilerExplorer")
    exec ":VimFilerExplorer"
  elseif exists(":Explore")
    exec ":Ex"
  endif
endfu

" }}}
" Cutom Fold Text Line: {{{

set foldtext=CustomFoldText()
func! CustomFoldText()
  "get first non-blank line
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldSizeStr = " " . foldSize . " lines "
  let foldLevelStr = repeat("+--", v:foldlevel)
  let lineCount = line("$")
  let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
  return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf

" }}}
" Emacs Style Search: {{{

let &highlight = 0

nnoremap <expr> <CR> &hlsearch? ':let &hlsearch = 0<CR>' : '<CR>'
nnoremap <expr> <leader>' &hlsearch? ':let &hlsearch = 0<CR>' : ''

nnoremap <silent> N :let &hlsearch = 1<CR>N
nnoremap <silent> n :let &hlsearch = 1<CR>n

nnoremap <silent> <leader><leader>` :set nohlsearch<CR>

" }}}
" Enable Nice Folds: {{{

command! FoldUP call FoldUP()
func! FoldUP()
  set foldenable
  set foldmethod=syntax
  set foldnestmax=1
endf

" }}}
" Enable Essay Mode: {{{
" This mode sets lines to wrap and makes j an k go by actual visible lines as
" opposed to the lines int the files, which makes editing text rather
" unintuitive.

command! WP call WordProcessorMode()
func! WordProcessorMode()
  setlocal spell spelllang=en_gb
  " setlocal formatoptions=1
  " setlocal formatprg=par

  map j gj
  map k gk

  setlocal complete+=s
  setlocal wrap
  setlocal linebreak
  setlocal nocursorline
endfunc
" }}}
" Diff With Saved State: {{{

command! DiffSaved call s:DiffWithSaved()
func! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe " setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunc

" }}}
" Quick List Toggle: {{{

func! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunc

func! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec('botright '.a:pfx.'window')
  if winnr() != winnr
    wincmd p
  endif
endfunc

nmap <silent> <leader><leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader><leader>Q :call ToggleList("Quickfix List", 'c')<CR>

" }}}
" Open Scratch Buffer: {{{

command! Scratch call s:OpenScratch()
func! s:OpenScratch()
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
endfunc

" }}}
" TMUX Exec: {{{
"
command! -nargs=* Tme call s:TMUXExec(<f-args>)
command! -nargs=* TMUXExec call s:TMUXExec(<f-args>)
func! s:TMUXExec(...)
  let pane_num = a:1
  let command = a:000[1:-1]

python << EOF
import vim
import subprocess

pane_num = vim.eval('pane_num')
command = vim.eval('command')

subprocess.call(["tmux", "send-keys", "-t", pane_num, "-l", " ".join(command)])
subprocess.call(["tmux", "send-keys", "-t", pane_num, "Enter"])
EOF

endfunc

command! -range -nargs=1 Tms <line1>,<line2>call s:TMUXSend(<f-args>)
command! -range -nargs=1 TMUXSend <line1>,<line2>call s:TMUXSend(<f-args>)
func! s:TMUXSend(pane_num) range
  let lines=getline(a:firstline, a:lastline)

python << EOF
import vim
import subprocess

lines = vim.eval('lines')
pane_num = vim.eval('a:pane_num')
for line in lines:
  subprocess.call(["tmux", "send-keys", "-t", pane_num, "-l", line])
  subprocess.call(["tmux", "send-keys", "-t", pane_num, "Enter"])

EOF
endfunc
" }}}
" Diff Fold: {{{
function! DiffFold(lnum)
  let line = getline(a:lnum)
  if line =~ '^\(diff\|---\|+++\|@@\) '
    return 1
  elseif line[0] =~ '[-+ ]'
    return 2
  else
    return 0
  endif
endfunction

func! s:EnableDiffFold()
  setlocal foldmethod=expr foldexpr=DiffFold(v:lnum)
  set foldlevel=0
endfunc

command! EnableDiffFold call s:EnableDiffFold()
" }}}
"                              Language Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GoLang: {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_list_type = "quickfix"
"let g:go_fmt_command = "goimports"

augroup lang_go
  autocmd!
  " autocmd BufRead *.go setlocal foldmethod=syntax
  " autocmd BufRead *.go setlocal foldnestmax=1
  autocmd BufWritePost *.go call s:GoOnBufWrite()
augroup END

func! s:GoOnBufWrite()
  try
    Neomake
  catch /.*/
  endtry
endfunc

" }}}
" ZSH: {{{

" Substitute the ZSH file format to SH because highlighting is better
" autocmd BufRead * call s:ftZSHtoSH()
" func! s:ftZSHtoSH()
"   if &filetype == "zsh"
"     setlocal filetype=sh
"   endif
" endfunc

" }}}
"                                Misc Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Settings: {{{

" set nocursorline " improve performance
" set nolazyredraw


" Setting Up Colorsheme and fonts

try
  let g:lightline={'colorscheme': 'seoul256'}
  colorscheme bubblegum
  " set background=light
catch /.*/
endtry

if has("gui_running")
  set guifont=menlo:h14
  set macmeta
  set transparency=6
  set blurradius=10
  "set macthinstrokes
endif

if (has("gui_running") || has("gui_vimr"))
  let g:gruvbox_seethru=0
else
  let g:gruvbox_seethru=1
endif

" }}}
" NeoVim Settings: {{{

if has('nvim')
  " set termguicolors

  " set ttyfast
  " set noshowcmd
  " set nolazyredraw

  syntax sync minlines=256

  tnoremap <C-\><C-[> <C-\><C-n>
  tnoremap <C-\><C-]> <C-\><C-n>pi

  let g:terminal_color_0  = '#2e3436'
  let g:terminal_color_1  = '#cc0000'
  let g:terminal_color_2  = '#4e9a06'
  let g:terminal_color_3  = '#c4a000'
  let g:terminal_color_4  = '#3465a4'
  let g:terminal_color_5  = '#75507b'
  let g:terminal_color_6  = '#0b939b'
  let g:terminal_color_7  = '#d3d7cf'
  let g:terminal_color_8  = '#555753'
  let g:terminal_color_9  = '#ef2929'
  let g:terminal_color_10 = '#8ae234'
  let g:terminal_color_11 = '#fce94f'
  let g:terminal_color_12 = '#729fcf'
  let g:terminal_color_13 = '#ad7fa8'
  let g:terminal_color_14 = '#00f5e9'
  let g:terminal_color_15 = '#eeeeec'
endif

" }}}
" Vim Debug Mappings: {{{

" Print out the highlight groups under cursor [themeing purposes]
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufRead *.stgit-edit.txt setlocal filetype=gitcommit
autocmd BufRead *.stgit-edit.patch setlocal filetype=gitcommit
