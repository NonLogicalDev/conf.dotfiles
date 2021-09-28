" vim:foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialising Plugins:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin Manager Setup: {{{

let g:PlugHomePath = g:VimConfig('autoload/plug.vim')
let g:PlugDataPath = g:Dir(g:VimData('plug.vim'))
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

" }}}
""" Plugin Definitions: {{{
call s:PlugInitBegin()
"===============================================================================
" Libraries: {{{

Plug 'vim-scripts/ingo-library'
Plug 'tpope/vim-repeat'
Plug 'Shougo/unite.vim'
Plug 'rizzatti/funcoo.vim'

" }}}
" Language Definitions: {{{

Plug 'Matt-Deacalion/vim-systemd-syntax', { 'for':'systemd'        }

Plug 'stephpy/vim-yaml',                  { 'for':'yaml'           }
Plug 'chase/vim-ansible-yaml',            { 'for':'yaml'           }

Plug 'pangloss/vim-javascript',           { 'for':'javascript'     }
Plug 'lepture/vim-jinja',                 { 'for':'jinja'          }
Plug 'jceb/vim-orgmode',                  { 'for':'org'            }

Plug 'mattn/emmet-vim',        {'for':'html'} " Faster way to write HTML
Plug 'vim-scripts/ragtag.vim', {'for':'xml' } " Helps with html/xml editing

" Plug 'rust-lang/rust.vim',                { 'for':'rust'           }
" Plug 'chr4/nginx.vim'
" Plug 'raichoo/haskell-vim',               { 'for':'haskell'        }
" Plug 'tikhomirov/vim-glsl',               { 'for':'glsl'           }
" Plug 'keith/swift.vim',                   { 'for':'swift'          }
" Plug 'fatih/vim-go',                      { 'for':'go'             }
" Plug 'hdima/python-syntax',               { 'for':'python'         }

" }}}
" Colorschemes: {{{

Plug 'nonlogicaldev/vim.color.gruvbox'

" }}}
" Interface Plugins: {{{

Plug 'ojroques/vim-oscyank'  " Use OSC 52 for copying to clibboard
Plug 'vimwiki/vimwiki'       " Personal Wiki

Plug 'scrooloose/nerdtree'   " Ex Browser Replacement
" Plug 'Shougo/vimfiler.vim'   " Adding Navigator to vim

Plug 'itchyny/lightline.vim' " Status Line Replacement
" Plug 'kien/ctrlp.vim'        " Quick Finder

Plug 'jaxbot/semantic-highlight.vim' " Color every identifier with its own color
" Plug 'kien/rainbow_parentheses.vim'  " Rainbow parenthetical expressions


" Making editing colors in vim a little easier
" Plug 'iandoe/vim-osx-colorpicker'
" Plug 'skammer/vim-css-color'
" Plug 'vim-scripts/Colorizer'

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
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Plug 'neomake/neomake' " On the fly code checker
  " Plug 'zchee/deoplete-go',    { 'do': 'make' }
  " Plug 'zchee/deoplete-clang'
  " Plug 'wokalski/autocomplete-flow',
endif

" }}}
"===============================================================================
call s:PlugInitEnd()
""" }}}

" Plugin Confuguration:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimWiki: {{{
let g:vimwiki_list = [{
	\ 'path': '~/vimwiki',
	\ 'template_path': '~/vimwiki/templates/',
	\ 'template_default': 'default',
	\ 'syntax': 'markdown',
	\ 'ext': '.md',
	\ 'path_html': '~/vimwiki/site_html/',
	\ 'custom_wiki2html': 'vimwiki_markdown',
	\ 'template_ext': '.tpl'}]
" }}}
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

nmap <silent> <leader>m :NERDTreeCWD<cr>

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

" autocmd BufEnter,BufRead,BufWritePost *.go,*.py,*.jsx,*.js call s:Semantic()

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
"
" let g:semanticBlacklistOverride = {
"       \ 'go': [
"         \ 'break',
"         \ 'default',
"         \ 'func',
"         \ 'interface',
"         \ 'select',
"         \ 'case',
"         \ 'defer',
"         \ 'go',
"         \ 'map',
"         \ 'struct',
"         \ 'chan',
"         \ 'else',
"         \ 'goto',
"         \ 'package',
"         \ 'switch',
"         \ 'const',
"         \ 'fallthrough',
"         \ 'if',
"         \ 'range',
"         \ 'type',
"         \ 'continue',
"         \ 'for',
"         \ 'import',
"         \ 'return',
"         \ 'var'
"       \ ]
" \ }
" }}}
" Deoplete: {{{

let g:deoplete#enable_at_startup = 1

let g:go_fmt_experimental = 1

" let s:mac_clang_locaction = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
" let s:mac_clang_locaction = "/Applications/Xcode.app/Contents/Frameworks/libclang.dylib"
let s:mac_clang_locaction = "/usr/local/Cellar/llvm/9.0.0_1/lib/libclang.dylib"
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

let g:UltiSnipsSnippetDirectories = [g:VimConfig('UltiSnips'), 'UltiSnips']

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
