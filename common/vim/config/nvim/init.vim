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

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 
" let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
" let &t_EI = "\<Esc>]1337;CursorShape=0\x7"

func! s:Dir(dir)
  if empty(glob(a:dir))
    call system("mkdir -p " . a:dir)
  endif
  return a:dir
endfunc

func! s:File(path)
  if !filereadable(a:path)
    call system("touch " . a:path)
  endif
  return a:path
endfunc

func! s:VimConfig(path) 
  if has("nvim")
    return expand("~/.config/nvim/" . a:path)
  else
    return expand("~/.vim/" . a:path)
  endif
endfunc
call s:Dir(s:VimConfig(""))

func! s:VimData(path) 
  if has("nvim")
    return expand("~/.local/share/nvim/". a:path)
  else
    return expand("~/.local/share/nvim/". a:path)
  endif
endfunc
call s:Dir(s:VimData(""))

" Set up Python on macOS:
if filereadable("/usr/local/opt/asdf/shims/python2")
  let g:python_host_prog = '/usr/local/opt/asdf/shims/python2'
elseif filereadable("/usr/local/bin/python2")
  let g:python_host_prog = '/usr/local/bin/python2'
endif

if filereadable("/usr/local/opt/asdf/shims/python3")
  let g:python3_host_prog = '/usr/local/opt/asdf/shims/python3'
elseif filereadable("/usr/local/bin/python3")
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

" }}}
" Plugin Manager Setup: {{{

let g:PlugHomePath = s:VimConfig('autoload/plug.vim')
let g:PlugDataPath = s:Dir(s:VimData('plug.vim'))
let g:PlugRepoURL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
let g:PlugInitialized = 0

command! -nargs=+ -bar Plug
command! -nargs=* -bar PlugInstall

if ! exists("*s:PlugInitBegin")
  func! s:PlugInitBegin()
    if empty(glob(g:PlugHomePath))
      " vim-plug (https://github.com/junegunn/vim-plug) settings 
      " Automatically install vim-plug and run PlugInstall if vim-plug not found
      let curl_cmd = "curl -fLo " . g:PlugHomePath . " --create-dirs " . g:PlugRepoURL
      call system(curl_cmd)
      if v:shell_error != 0
        echoerr "Cant install PLUG"
        echoerr ": " . curl_cmd "\r: exited with " . v:shell_error
      endif
    else
      let g:PlugInitialized = 1
    endif

    try
      call plug#begin(g:PlugDataPath)
    catch /.*/
      echo "Can't Load PLUG"
    endtry
  endfunc
endif

if ! exists("*s:PlugInitEnd")
  func! s:PlugInitEnd()
    try
      call plug#end()
    catch /.*/
    endtry

    if ! g:PlugInitialized 
      PlugInstall
    endif
  endfunc
endif

command! ReloadConfig :call s:ReloadConfig()
if ! exists("*s:ReloadConfig")
  func! s:ReloadConfig()
    if has("nvim")
      exec "source " . s:VimConfig("init.vim")
    else
      exec "source " . s:VimConfig("../.vimrc")
    endif
  endfunc
endif
"
" Open the vimrc file
command! Config call s:OpenConfig()
if ! exists("*s:OpenConfig")
  func! s:OpenConfig()
    if has("nvim")
      exec "tabedit " . s:VimConfig("init.vim")
    else
      exec "tabedit " . s:VimConfig("../.vimrc")
    endif
  endfunc
endif

" }}}
" Encoding Settings: {{{

" Choosing the best encoding ever
set encoding=utf-8
" set fileencoding=utf-8

" Changing grep engine to ack, cause it is 1000 times faster and better
set grepprg=ack

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
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Initialising Plugins:
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
""" Plugin Definitions: {{{
call s:PlugInitBegin()
"===============================================================================
" Libraries: {{{

Plug 'vim-scripts/ingo-library' " Utility library needed for some plugins
Plug 'tpope/vim-repeat'
Plug 'Shougo/unite.vim'
Plug 'rizzatti/funcoo.vim'

" }}}
" Language Definitions: {{{

Plug 'chr4/nginx.vim'
Plug 'keith/swift.vim',                   { 'for':'swift'          }
Plug 'hdima/python-syntax',               { 'for':'python'         }
Plug 'fatih/vim-go',                      { 'for':'go'             }
Plug 'rust-lang/rust.vim',                { 'for':'rust'           }
Plug 'tikhomirov/vim-glsl',               { 'for':'glsl'           }
Plug 'raichoo/haskell-vim',               { 'for':'haskell'        }
Plug 'pangloss/vim-javascript',           { 'for':'javascript'     }
Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for':'systemd'        }
Plug 'stephpy/vim-yaml',                  { 'for':'yaml'           }
Plug 'chase/vim-ansible-yaml',            { 'for':'yaml'           }
Plug 'lepture/vim-jinja',                 { 'for':'jinja'          }
Plug 'jceb/vim-orgmode',                  { 'for':'org'            }

Plug 'mattn/emmet-vim',        {'for':'html'} " Faster way to write HTML
Plug 'vim-scripts/ragtag.vim', {'for':'xml' } " Helps with html/xml editing

" }}}
" Colorschemes: {{{

Plug 'nonlogicaldev/gruvbox'

" }}}
" Interface Plugins: {{{

Plug 'vimwiki/vimwiki'       " Personal Wiki

Plug 'scrooloose/nerdtree'   " Ex Browser Replacement
Plug 'Shougo/vimfiler.vim'   " Adding Navigator to vim

Plug 'itchyny/lightline.vim' " Status Line Replacement
Plug 'kien/ctrlp.vim'        " Quick Finder

Plug 'kien/rainbow_parentheses.vim'  " Rainbow parenthetical expressions
Plug 'jaxbot/semantic-highlight.vim' " Color every identifier with its own color


" Making editing colors in vim a little easier
Plug 'iandoe/vim-osx-colorpicker'
Plug 'skammer/vim-css-color'
Plug 'vim-scripts/Colorizer'

" }}}
" Behavior Engancements: {{{

Plug 'vim-scripts/bufkill.vim'         " Allows killing a buffer without closing current pane

Plug 'godlygeek/tabular'               " Aligns any delimiter in selected strings
Plug 'Raimondi/delimitMate'            " Auto closes brackets quotes and just about everything else

Plug 'vim-scripts/EnhancedJumps'       " Improve jumps (CTRL-I / CTRL-O)
Plug 'michaeljsmith/vim-indent-object' " Selecting things at the current indent level
Plug 'Lokaltog/vim-easymotion'         " Visualises increments of jump commands

Plug 'tpope/vim-abolish'               " Error Correction on-the-fly
Plug 'tomtom/tcomment_vim'             " Commenting out lines with 'gc'
Plug 'tpope/vim-surround'              " Surround current element with a symbol

" }}}
" Connectivity Plugins: {{{

Plug 'rizzatti/dash.vim'  " Dash integration (Documentation Lookup)
Plug 'tpope/vim-fugitive' " Git Integration

" }}}
" Code Completers: {{{

if (!(version < 704) && (has("python") || has("python3")) )
  " Requires version above 7.4 and a python installed.
  Plug 'SirVer/ultisnips' " Snippets
endif

if has('nvim')
  Plug 'neomake/neomake' " On the fly code checker

  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'zchee/deoplete-clang'
  Plug 'wokalski/autocomplete-flow',
endif

" }}}
"===============================================================================
call s:PlugInitEnd()
""" }}}
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                             Vim Basic Settings:
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
let &backupdir=s:Dir(s:VimConfig("backup"))
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
  SemanticHighlight
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
"                           Plugin Confugurations:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GruvBox: {{{

let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = 0

"}}}
" Highlighter Settings: {{{
let python_highlight_all = 1
au FileType python syn match pythonBoolean "\(\W\|^\)\@<=self\(\.\)\@="
" }}}
" Airline Configuration: {{{

let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline_left_sep=''
let g:airline_right_sep=''

" }}}
" NerdTree Config: {{{

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:DevIconsEnableFoldersOpenClose = 1

let g:NERDTreeMinimalUI = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:nerdtree_tabs_open_on_gui_startup = 0

let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match

" NERD tree mappings
nmap <silent> <leader>m :NERDTreeCWD<cr>
nmap <silent> <leader>n :ToggleNav<cr>
command! ToggleNav call s:ToggleNav()
func! s:ToggleNav() 
  if exists(":NERDTabsTreeToggle")
    exec ":NERDTreeTabsToggle"
  elseif exists(":NERDTreeToggle")
    exec ":NERDTreeToggle"
  elseif exists(":Ex")
    exec ":Ex"
  endif
endfu
nmap <silent> <leader>q :NERDTreeFocusToggle<cr>
"nmap <silent> <leader>n :VimFilerExplorer<CR>

" }}}
" Rainbow Paranthesis: {{{

" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

" let g:rbpt_colorpairs = [
"     \ ['brown',       'RoyalBlue3'],
"     \ ['Darkblue',    'SeaGreen3'],
"     \ ['darkgray',    'DarkOrchid3'],
"     \ ['darkgreen',   'firebrick3'],
"     \ ['darkcyan',    'RoyalBlue3'],
"     \ ['darkred',     'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['brown',       'firebrick3'],
"     \ ['gray',        'RoyalBlue3'],
"     \ ['black',       'SeaGreen3'],
"     \ ['darkmagenta', 'DarkOrchid3'],
"     \ ['Darkblue',    'firebrick3'],
"     \ ['darkgreen',   'RoyalBlue3'],
"     \ ['darkcyan',    'SeaGreen3'],
"     \ ['darkred',     'DarkOrchid3'],
"     \ ['red',         'firebrick3'],
"     \ ]

" }}}
" YankRing Configuration: {{{

let g:yankring_history_dir = '~/.vim'
let g:yankring_history_file = 'yankring_history'

" }}}
" Ctrl P Config: {{{

noremap <leader><leader>[ :CtrlPBuffer<CR>
noremap <leader><leader>{ :CtrlPMRUFiles<CR>
noremap <leader><leader>] :CtrlPBufTagAll<CR>
noremap <leader><leader>} :CtrlPTag<CR>

let g:ctrlp_buftag_types = {
      \ 'go' : {
      \   'bin': 'gotags',
      \   'args': '-f -',
      \ },
      \ 'js' : {
      \   'bin': 'jsctags',
      \   'args': '-f',
      \ },
      \ }

let g:ctrlp_extensions = ['buffertag']

" }}}
" Emmet Config: {{{

imap <C-Tab> <C-y>,

" }}}
" Semantic: {{{

autocmd BufEnter,BufRead,BufWritePost *.go,*.py,*.jsx,*.js call s:Semantic()

func! s:Semantic()
  try
    SemanticHighlight
  catch /.*/
  endtry
endfunc

let g:semanticContainedlistOverride = {
      \ 'javascript': join([
        \ 'jsFuncCall',
        \ 'jsVariableDef',
        \ 'jsOperator',
        \ 'jsObjectProp',
        \ 'jsObjectKey',
        \ 'jsObjectValue',
        \ 'jsModuleKeyword',
        \ 'jsIfElseBlock',
        \ 'jsParenIfElse',
        \ 'jsRepeatBlock',
        \ 'jsParenRepeat',
        \ 'jsFuncBlock',
        \ 'jsFuncArgs',
        \ 'jsParen',
        \ 'jsBracket',
        \ 'jsGlobalObjects',
        \ 'jsFutureKeys',
      \], ","),
      \ }
      
let g:semanticBlacklistOverride = {
      \ 'go': [
        \ 'break',
        \ 'default',
        \ 'func',
        \ 'interface',
        \ 'select',
        \ 'case',
        \ 'defer',
        \ 'go',
        \ 'map',
        \ 'struct',
        \ 'chan',
        \ 'else',
        \ 'goto',
        \ 'package',
        \ 'switch',
        \ 'const',
        \ 'fallthrough',
        \ 'if',
        \ 'range',
        \ 'type',
        \ 'continue',
        \ 'for',
        \ 'import',
        \ 'return',
        \ 'var'
      \ ]
\ }
" }}}
" Deoplete: {{{

let g:deoplete#enable_at_startup = 1

let g:go_fmt_experimental = 1

let s:mac_clang_locaction = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib" 
if filereadable(s:mac_clang_locaction)
  let g:deoplete#sources#clang#libclang_path = s:mac_clang_locaction
endif

" }}}
" UltiSnips: {{{

let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsListSnippets="<c-l>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = [s:VimConfig('UltiSnips'), 'UltiSnips']

" ultisnips is missing a setf trigger for snippets on bufenter
autocmd BufEnter *.snippets setf snippets

" in ultisnips snippet files, we want actual tabs instead of spaces for
" indents. us will use those tabs and convert them to spaces if expandtab is set when
" the user wants to insert the snippet.
autocmd filetype snippets setlocal noexpandtab 
inoremap <silent> <Tab> <C-R>=g:SmartTab()<cr>
inoremap <silent> <S-Tab> <C-R>=g:SmartSTab()<cr>
"au VimEnter * exec "inoremap <silent> <Tab> <C-R>=g:UltiSnips_Complete()<cr>"

" Make tab smart

func! g:SmartTab()
  if pumvisible()
    return "\<C-n>"
  else
    return "\<Tab>"
  endif
endfunc

func! g:SmartSTab()
  if pumvisible()
    return "\<C-p>"
  else
    return "\<Tab>"
  endif
endfunc

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

" Substitute the ZSH file format to SH cause highlighting is better
autocmd BufRead * call s:ftZSHtoSH()
func! s:ftZSHtoSH()
  " if &filetype == "zsh"
  "   setlocal filetype=sh
  " endif
endfunc

" autocmd BufRead * call AliasZSH()

" }}}
"                                Misc Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI Settings: {{{

" Setting Up Colorsheme and fonts
set nocursorline " improve performance
let g:lightline={'colorscheme': 'seoul256'}
set nolazyredraw

if has("gui_running")
  set guifont=menlo:h14
  "set guifont=dejavu\ sans\ mono\ for\ powerline:h14
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

if exists("neovim_dot_app")
  call MacSetFont("Menlo", 14)
endif

try
  colo gruvbox
  set background=dark 
catch /.*/
endtry

" }}}
" NeoVim Settings: {{{

if has('nvim')
  set termguicolors

  set ttyfast
  set noshowcmd
  set nolazyredraw

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
