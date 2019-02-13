" Author: Oleg Utkin
" Github: nonlogicaldev
" Close/open all folds zm/zr
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This line is important, some backwards compatible features break my setup
set nocompatible 
" let &t_SI = "\<Esc>]1337;CursorShape=1\x7"
" let &t_EI = "\<Esc>]1337;CursorShape=0\x7"


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

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"                            Initialising Plugins:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Definitions: {{{
" Autoinstall Vim Plug: {{{
" vim-plug (https://github.com/junegunn/vim-plug) settings 
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
"}}}

call plug#begin('~/.vim/plugged')
"===============================================================================
" Libraries: {{{

Plug 'vim-scripts/ingo-library' " Utility library needed for some plugins
Plug 'tpope/vim-repeat'
Plug 'Shougo/unite.vim'

" }}}
" Language Definitions: {{{

Plug 'digitaltoad/vim-pug' " Jade/Pug templates
Plug 'MicahElliott/Rocannon'
Plug 'chr4/nginx.vim'
Plug 'rkennedy/vim-delphi'
Plug 'aklt/plantuml-syntax'

Plug 'keith/swift.vim',                   { 'for':'swift'          }
Plug 'hdima/python-syntax',               { 'for':'python'         }
Plug 'fatih/vim-go',                      { 'for':'go'             }
Plug 'rust-lang/rust.vim',                { 'for':'rust'           }
Plug 'tikhomirov/vim-glsl',               { 'for':'glsl'           }
Plug 'raichoo/haskell-vim',               { 'for':'haskell'        }
Plug 'pangloss/vim-javascript',           { 'for':'javascript'     }

Plug 'guns/vim-clojure-static',           { 'for':'clojure'        }
Plug 'guns/vim-clojure-highlight',        { 'for':'clojure'        }
Plug 'tpope/vim-fireplace',               { 'for':'clojure'        }
Plug 'guns/vim-sexp',                     { 'for':'clojure'        }

Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for':'systemd'        }
Plug 'stephpy/vim-yaml',                  { 'for':'yaml'           }
Plug 'chase/vim-ansible-yaml',            { 'for':'yaml'           }
Plug 'cakebaker/scss-syntax.vim',         { 'for':['scss', 'sass'] }

Plug 'lepture/vim-jinja',                 { 'for':'jinja'          }
Plug 'ClockworkNet/vim-junos-syntax'

"Plug 'phildawes/racer',                  { 'do': 'cargo build --release' }
Plug 'vim-ruby/vim-ruby',                 { 'for':'ruby'           }
"Plug 'JuliaEditorSupport/julia-vim',      { 'for':'julia'          }

" }}}
" Colorschemes: {{{

Plug 'altercation/vim-colors-solarized'
Plug 'nonlogicaldev/vim-jasmine-colortheme'
"Plug 'morhetz/gruvbox'
Plug 'nonlogicaldev/gruvbox'
Plug 'fatih/molokai'
Plug 'flazz/vim-colorschemes'

" }}}
" Interface Plugins: {{{

" Graphical Enhancements
Plug 'itchyny/lightline.vim' " An even nicer replacement for the default status line
Plug 'kien/rainbow_parentheses.vim' " Rainbow parenthetical expressions
Plug 'jaxbot/semantic-highlight.vim' " Color every identifier with its own color
" Plug 'Yggdroot/indentLine' " A subtle visual guide for indents
Plug 'tomtom/tcomment_vim' " Lets you quickly comment out lines wtih gc

" Adding Navigator to vim
Plug 'scrooloose/nerdtree'
"Plug 'Shougo/vimfiler.vim'

" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'ryanoasis/vim-devicons' " Unleash Graphical awesomeness
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Making editing colors in vim a little easier
Plug 'iandoe/vim-osx-colorpicker'
Plug 'skammer/vim-css-color'
Plug 'vim-scripts/Colorizer'

" Quick Finders
Plug 'kien/ctrlp.vim'
"kPlug 'majutsushi/tagbar', {'on':['Tagbar','TagbarToggle']}

" The Amazing Orgmode (Half as amazing compared to emacs but Eh...)
Plug 'jceb/vim-orgmode'
" Plug 'blindfs/vim-taskwarrior'
" Plug 'tpope/vim-speeddating'

if has('nvim')
  Plug 'kassio/neoterm'
  "Plug 'airblade/vim-gitgutter'
endif

" }}}
" Behavior Engancements: {{{

Plug 'tpope/vim-abolish'
"Plug 'YankRing.vim' " Stores history of yanks and deletes
Plug 'vim-scripts/EnhancedJumps' " Improve jumps (CTRL-I / CTRL-O)
Plug 'michaeljsmith/vim-indent-object' " Selecting things at the current indent level
Plug 'tpope/vim-surround' " Surround current element with a symbol
Plug 'Lokaltog/vim-easymotion' " Visualises increments of jump commands
Plug 'godlygeek/tabular' " Aligns any delimiter in selected strings
Plug 'vim-scripts/bufkill.vim' " Allows you to kill a buffer without closing current pane
Plug 'Raimondi/delimitMate' " Auto closes brackets quotes and just about everything else

Plug 'mattn/emmet-vim', {'for':'html'}  " Super cool way to write html
Plug 'vim-scripts/ragtag.vim', {'for':'xml'} " Helps with html/xml editing

" }}}
" Connectivity Plugins: {{{

" Dash integration (Documentation Lookup)
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

" Git Integration
Plug 'tpope/vim-fugitive'
if has('nvim')
  "Plug 'airblade/vim-gitgutter' " This thing is a resource hog (unless you have neovim)
endif

" CTags Integration 
" (which would have been useful if I did not discoever Semantic Highlighter)
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'

" On the fly code checker
if has('nvim')
  Plug 'neomake/neomake'
else
  " Plug 'scrooloose/syntastic' " This thing is also a major resource hog
endif

" Terminal integration
"Plug 'gcmt/tube.vim' " Lets issuing commands straight to terminal

" }}}
" Code Completers: {{{

" Plug 'SyntaxComplete' " Adds all the syntax highlights to omniCompletion
" Plug 'ternjs/tern_for_vim'
Plug 'flowtype/vim-flow', { 'do': 'npm install -g flow-bin' }

Plug 'SirVer/ultisnips'

" vim-plug
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'zchee/deoplete-clang'
  Plug 'wokalski/autocomplete-flow'
  " Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
else
  Plug 'Valloric/YouCompleteMe'
endif

" }}}
"===============================================================================
call plug#end() 

" Call PlugInstall on first startup
if !filereadable(expand("~/.vim/.init"))
  PlugInstall
  call system('touch ~/.vim/.init')
endif

" }}}
"                               Custom Mappings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global Mappings: {{{

"set clipboard=unnamedplus
let mapleader = " " " This is a spaca by the way
let maplocalleader = "\\"


" select most recently changed text - particularly useful for pastes
nnoremap <leader>v `[v`]
nnoremap <leader>V `[V`]

nnoremap <leader><leader>m :cd %:p:h<cr>

" Maks sure that I never open the useless ExMode
nnoremap Q <nop>

" }}}
"                              General Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Backup File Settings: {{{

" Setting the backup to a specific folder
" so that I dont have to fight vim backup files in repositories
set backupdir=~/.vim/backup
set backupcopy=yes

set noswapfile      " Don't use swapfile
set nobackup        " Don't create annoying backup files

" }}}
" Encoding Settings: {{{

" Choosing the best encoding ever
set encoding=utf-8
" set fileencoding=utf-8

" Changing grep engine to ack, cause it is 1000 times faster and better
set grepprg=ack

" }}}
"                           Vim Behaviour Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editor Behaviour: {{{

set autowrite       " Automatically save before :next, :make etc.

set backspace=indent,eol,start  " intuitive backspacing.
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
" Cmd Settings: {{{

set wildmenu        " enhanced command line completion.
set wildmode=list:longest  " complete files like a shell.

set showcmd         " display incomplete commands.
set showmode        " display the mode you're in.

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
" Tab Navigation Simplified: {{{
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
" }}}
" Make Increment Play Well With TMUX: {{{
noremap <C-c> <C-a>
" }}}
" Pasting With Ease: {{{
 noremap <localleader>] "*p
 noremap <localleader>} "*P
 noremap <localleader>[ "*y
 noremap <localleader>{ "*Y
" }}}
" Slecting With Ease: {{{
noremap gA ggVG
"}}}
" Enable Nice Folds: {{{
command! Devify call SetUpDevExperience()
func! SetUpDevExperience()
  set foldenable
  set foldmethod=syntax
  set foldnestmax=1
  SemanticHighlight
endf

" }}}
" Essay Mode: {{{
" This mode sets lines to wrap and makes j an k go by actual visible lines as
" opposed to the lines int the files, which makes editing text rather
" unintuitive.

" Remap that supper annoying thing that seems to always happen
command! W w
func! WordProcessorMode() 
  " setlocal formatoptions=1 
  map j gj
  map k gk
  setlocal spell spelllang=en_gb
  set complete+=s
  " set formatprg=par
  " set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  setlocal wrap 
  setlocal linebreak 
  set nocursorline
endfu 
com! WP call WordProcessorMode()
" }}}
" Emacs Style Search: {{{

" (Yah yah I know... but that's like the only thing they got right!)
let &highlight = 0
nnoremap <expr> <CR> &hlsearch? ':let &hlsearch = 0<CR>' : '<CR>'
nnoremap <expr> <leader>' &hlsearch? ':let &hlsearch = 0<CR>' : ''
nnoremap <silent> N :let &hlsearch = 1<CR>N
nnoremap <silent> n :let &hlsearch = 1<CR>n
nnoremap <silent> <leader><leader>` :set nohlsearch<CR>

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
" Diff With Saved State: {{{
  
command! DiffSaved call s:DiffWithSaved()
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe " setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction

" }}}
" Quick List Toggle: {{{

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

nmap <silent> <leader><leader>q :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader><leader>Q :call ToggleList("Quickfix List", 'c')<CR>
function! ToggleList(bufname, pfx)
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
endfunction

" }}}
" Open Scratch Buffer: {{{

command! Scratch call s:OpenScratch() 

function! s:OpenScratch()
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
endf

" }}}
" Arrow Godmode: {{{

" Become a god?
nnoremap <up> <c-w>+
nnoremap <down> <c-w>-
nnoremap <right> <c-w><
nnoremap <left> <c-w>>

" }}}
" Misc Extensions: {{{

imap <C-j> <CR><C-o>O
 
" Open the vimrc file
command! Config call s:OpenConfig()
func! s:OpenConfig()
  exec "tabedit ~/.vimrc"
endfu

" Word Processor mode for easier markdown handling
command! WP call s:WordProcessorMode()
func! s:WordProcessorMode() 
  " setlocal formatoptions=1 
  map j gj
  map k gk
  setlocal spell spelllang=en_gb
  " set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  " set formatprg=par
  setlocal wrap 
  setlocal linebreak 
  set nocursorline
endfu 


" }}}
" Fuck You K: {{{

nmap K <nop> " By default this calls up man command on whaterver is under the cursor
             " And it is rediculosly slow and buggy if not run from terminal

" }}}
" TMUX Exec: {{{
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
" TaskWarrior: {{{
let g:task_rc_override     = 'rc.defaultwidth=999'
" }}}
" EasyMotion: {{{

" =[

" }}}
" Abolish: {{{

let g:abolish_save_file = "~/.vim/after/plugin/abolish.vim"

" }}}
" Highlighter Settings: {{{
let python_highlight_all = 1
au FileType python syn match pythonBoolean "\(\W\|^\)\@<=self\(\.\)\@="
" }}}
" IndentLine Configuration: {{{

let g:indentLine_char = '|'
let g:indentLine_color_gui = '#4F2528'

" }}}
" Airline Configuration: {{{

let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline_left_sep=''
let g:airline_right_sep=''

" }}}
" NerdTree Config: {{{

let g:NERDTreeMinimalUI = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match

" NERD tree mappings
nmap <silent> <leader>m :NERDTreeCWD<cr>
nmap <silent> <leader>n :ToggleNav<cr>
command! ToggleNav call s:ToggleNav()
func! s:ToggleNav() 
  if exists(":NERDTabsTreeToggle")
    exec ":NERDTreeTabsToggle"
  else
    exec ":NERDTreeToggle"
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
" UltiSnips: {{{
" ultisnips is missing a setf trigger for snippets on bufenter
autocmd BufEnter *.snippets setf snippets

" in ultisnips snippet files, we want actual tabs instead of spaces for
" indents. us will use those tabs and convert them to spaces if expandtab is set when
" the user wants to insert the snippet.
autocmd filetype snippets setlocal noexpandtab

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<Tab>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<Tab>"
            endif
        endif
    endif
    return ""
endfunction

inoremap <silent><Tab> <C-R>=g:UltiSnips_Complete()<cr>
au VimEnter * exec "inoremap <silent><Tab> <C-R>=g:UltiSnips_Complete()<cr>"

let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<M-Space>"
let g:UltiSnipsListSnippets="<c-e>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}
" Completer Configuration: {{{
" to avoid problems with arrows
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
if has('nvim')
  " inoremap <silent><expr> <TAB>
  "       \ pumvisible() ? "\<C-n>" :
  "       \ <SID>check_back_space() ? "\<TAB>" :
  "       \ deoplete#mappings#manual_complete()

  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~ '\s'
  " endfunction
else
  " let g:ycm_key_list_select_completion = ['<M-Tab>']
  " let g:ycm_semantic_triggers =  {
  "       \   'c' : ['->', '.'],
  "       \   'objc' : ['->', '.'],
  "       \   'cpp,objcpp' : ['->', '.', '::'],
  "       \   'perl' : ['->'],
  "       \   'php' : ['->', '::'],
  "       \   'cs,java,javascript,d,vim,ruby,python,perl6,scala,vb,elixir,go' : ['.'],
  "       \   'lua' : ['.', ':'],
  "       \   'erlang' : [':'],
  "       \ }
  " " nmap <silent> gd :YcmCompleter GoToDeclaration<CR>
  " " inoremap <M-Tab> <NOP>
  "
  " function! Auto_complete_string()
  "   if pumvisible()
  "     return "\<C-n>"
  "   else
  "     return "\<C-x>\<C-o>\<C-r>=Auto_complete_opened()\<CR>"
  "   end
  " endfunction
  "
  " function! Auto_complete_opened()
  "   if pumvisible()
  "     return "\<Down>"
  "   end
  "   return ""
  " endfunction
  "
  " inoremap <expr> <Nul> Auto_complete_string()
  " inoremap <expr> <C-q> Auto_complete_string()
endif

"}}}
" Org Mode Configuration: {{{


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
" Tube Terminal Config: {{{
let g:tube_terminal = 'iterm'

" }}}
" Syntastic: {{{
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" }}}
" GoLang: {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_list_type = "quickfix"
"let g:go_fmt_command = "goimports"
" }}}
" Easytags: {{{
let g:easytags_async = 1
let g:easytags_languages = {
\   'go': {
\     'cmd': '/Users/olegutkin/gocode/bin/gotags',
\       'args': [],
\       'fileoutput_opt': '-f',
\       'stdout_opt': '-f-',
\       'recurse_flag': '-R'
\   }
\}
" }}}
" Semantic: {{{
autocmd BufEnter,BufRead,BufWritePost *.go SemanticHighlight
autocmd BufEnter,BufRead,BufWritePost *.py SemanticHighlight
autocmd BufEnter,BufRead,BufWritePost *.jsx,*.js SemanticHighlight

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
" GruvBox: {{{

let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = 0

"}}}
" Clojure Static: {{{

let g:clojure_align_multiline_strings = 1

" }}}
" Deoplete: {{{

let g:deoplete#enable_at_startup = 1

let g:go_fmt_experimental = 1

" let g:tern#command = ["tern"]
" let g:tern#arguments = ["--persistent"]
" let g:tern_map_keys = 1

let g:deoplete#sources#clang#libclang_path = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib" 
let g:deoplete#sources#clang#clang_header = "/Users/olegutkin/.vim/plugged/YouCompleteMe/third_party/ycmd/clang_includes"

" }}}
" Flow: {{{

autocmd BufRead *.js nnoremap <buffer> gd :FlowJumpToDef<CR>

" }}}
" Surround: {{{

let g:surround_115 = "\1surround: \1\r\1\1""

" }}}
"                                Misc Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Languages: {{{

augroup lang_go
  autocmd!
  autocmd BufRead *.go setlocal foldmethod=syntax
  autocmd BufRead *.go setlocal foldnestmax=1
  autocmd BufWritePost *.go Neomake
augroup END


" }}}
" File Type Aliases: {{{

" Substitute the ZSH file format to SH cause highlighting is better
autocmd BufRead * call s:ftZSHtoSH()
function s:ftZSHtoSH()
  if &filetype == "zsh"
    setlocal filetype=sh
  endif
endfunction

" autocmd BufRead * call AliasZSH()

"}}}
" GUI Settings: {{{

" Setting Up Colorsheme and fonts
set nocursorline " improve performance
let g:lightline={'colorscheme': 'seoul256'}
set nolazyredraw

colo gruvbox
set background=dark 

if has("gui_running")
  set guifont=menlo:h14
  "set guifont=dejavu\ sans\ mono\ for\ powerline:h14
  "set macthinstrokes
  
  set macmeta
  set transparency=6
  set blurradius=10
  
  let g:gruvbox_seethru=0
  set background=light
  colo gruvbox
endif


if exists("neovim_dot_app")
  call MacSetFont("Menlo", 14)
endif

" }}}
" NeoVim Settings: {{{

let $NVIM_TUI_ENABLE_TRUE_COLOR=1 

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
"                          Pretending To Be Sublime:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
if has("gui_running")
  " No toolbars, menu or scrollbars in the GUI
  "set clipboard+=unnamed
  set vb t_vb=
  set guioptions-=m  " no menu
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r  " no scrollbar
  set guioptions-=R

  " Open ctrlp with cmd+p
  let g:ctrlp_map = '<D-p>'

  " Open goto symbol on current buffer
  nmap <D-r> :CtrlPBuffer<cr>
  imap <D-r> <esc>:CtrlPBuffer<cr>

  " Open goto symbol on all buffers
  nmap <D-R> :CtrlPBufTagAll<cr>
  imap <D-R> <esc>:CtrlPBufTagAll<cr>

  " Open goto file
  nmap <D-e> :CtrlP getcwd()<cr>
  imap <D-e> <esc>:CtrlP getcwd()<cr>

  " Comment lines with cmd+/
  map  <D-/> :TComment<cr>
  vmap <D-/> :TComment<cr>gv

  " Indent lines with cmd+[ and cmd+]
  nmap <D-]> >>
  nmap <D-[> <<
  vmap <D-[> <gv
  vmap <D-]> >gv

  " Open sidebar with cmd+k
  map <D-k> :NERDTreeTabsToggle<CR>

  " This mapping makes Ctrl-Tab switch between tabs. 
  " Ctrl-Shift-Tab goes the other way.
  " noremap <C-Tab> :tabnext<CR>
  " noremap <C-S-Tab> :tabprev<CR>

  " switch between tabs with cmd+1, cmd+2,..."
  map <D-1> 1gt
  map <D-2> 2gt
  map <D-3> 3gt
  map <D-4> 4gt
  map <D-5> 5gt
  map <D-6> 6gt
  map <D-7> 7gt
  map <D-8> 8gt
  map <D-9> 9gt

  " until we have default MacVim shortcuts this is the only way to use it in
  " insert mode
  imap <D-1> <esc>1gt
  imap <D-2> <esc>2gt
  imap <D-3> <esc>3gt
  imap <D-4> <esc>4gt
  imap <D-5> <esc>5gt
  imap <D-6> <esc>6gt
  imap <D-7> <esc>7gt
  imap <D-8> <esc>8gt
  imap <D-9> <esc>9gt
endif
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim:foldmethod=marker
