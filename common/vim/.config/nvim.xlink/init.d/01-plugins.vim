" vim:foldmethod=marker
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialising Plugins:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Plugin Manager Setup: {{{

let g:PlugHomePath = g:VimConfig('autoload/plug.vim')
let g:PlugDataPath = g:MustDir(g:VimData('plug.vim'))
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

if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
endif

" }}}
" Language Definitions: {{{

Plug 'sheerun/vim-polyglot' " One pack to rule them all and in the darkness bind them.

Plug 'lepture/vim-jinja', { 'for': 'jinja' }

" Plug 'mattn/emmet-vim',        {'for':'html'} " Faster way to write HTML
" Plug 'vim-scripts/ragtag.vim', {'for':'xml' } " Helps with html/xml editing

" }}}
" Colorschemes: {{{

Plug 'nonlogicaldev/vim.color.gruvbox'

" }}}
" Interface Plugins: {{{

" Essentials:
Plug 'scrooloose/nerdtree'   " Ex Browser Replacement
Plug 'itchyny/lightline.vim' " Status Line Replacement

" Nice To Haves:
Plug 'ojroques/vim-oscyank'  " Use OSC 52 for copying to clibboard
if has('nvim')
  " NeoVim LUA Specific QuickSearch Plugin
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
else
  " Standard VIM QuickSearch Plugin
  Plug 'kien/ctrlp.vim'
endif

" Occasional:
" Plug 'jaxbot/semantic-highlight.vim' " Color every identifier with its own color
" Plug 'vimwiki/vimwiki'               " Personal Wiki
" Plug 'tpope/vim-speeddating'         " Needed for OrgMode
" Plug 'Shougo/vimfiler.vim'           " Adding Navigator to vim
" Plug 'kien/rainbow_parentheses.vim'  " Rainbow parenthetical expressions

" Color Management:
" Plug 'iandoe/vim-osx-colorpicker'
" Plug 'skammer/vim-css-color'
" Plug 'vim-scripts/Colorizer'

" }}}
" Behavior Engancements: {{{

Plug 'vim-scripts/bufkill.vim'         " Allows killing a buffer without closing current pane

Plug 'godlygeek/tabular'               " Aligns any delimiter in selected strings
Plug 'Raimondi/delimitMate'            " Auto closes brackets quotes and just about everything else

Plug 'vim-scripts/EnhancedJumps'       " Improve jumps (CTRL-I / CTRL-O)
Plug 'Lokaltog/vim-easymotion'         " Visualises increments of jump commands

Plug 'tpope/vim-commentary'            " Commenting out lines with 'gc'
Plug 'tpope/vim-surround'              " Surround current element with a symbol

Plug 'wellle/targets.vim'              " Pair ({[ targets, and many more text objects
Plug 'michaeljsmith/vim-indent-object' " Selecting things at the current indent level

" }}}
" Connectivity Plugins: {{{

Plug 'rizzatti/dash.vim'  " Dash integration (Documentation Lookup)
Plug 'tpope/vim-fugitive' " Git Integration

" }}}
" Code Completers: {{{

if (!(version < 704) && (has("python") || has("python3")) )
  " Requires version above 7.4 and a python installed.
  Plug 'SirVer/ultisnips' " Snippets
  Plug 'honza/vim-snippets'
endif

if has('nvim')
  " Language Server Support (requires up-to-date NeoVim to work)
  " (!See LUA Config Section for Configuration Details, this does not work out of the box!)
  Plug 'neovim/nvim-lspconfig', { 'branch': 'master' }

  " NeoVim Completion Plugin (this is what actually shows Language Server completions in UI)
  Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }

  " Language Server Support Components
  Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
  Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
  Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
  Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }

  " Plug 'glepnir/lspsaga.nvim'

  " LSP Ultisnips Integration
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  " Old Deoplete Completer (does not require JS):
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'neomake/neomake' " On the fly code checker
  " Plug 'zchee/deoplete-go',    { 'do': 'make' }
  " Plug 'zchee/deoplete-clang'
  " Plug 'wokalski/autocomplete-flow',
endif

" }}}
"===============================================================================
call s:PlugInitEnd()
""" }}}

" NeoVim LUA Plugin Configuration: {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("nvim")
  execute 'source' g:VimConfig("init.d/01-plugins.lua")
endif

" }}}

" Plugin Confuguration: {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme: GruvBox: {{{

let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_improved_strings = 0

"}}}
" Util: OCS Yank: {{{

augroup PlugOCSYank
  autocmd!
  autocmd User KeymapReady vnoremap <leader>c :OSCYank<CR>
  autocmd User KeymapReady nmap <leader>o <Plug>OSCYank
augroup END

" }}}
" Util: YankRing Configuration: {{{

let g:yankring_history_dir = '~/.vim'
let g:yankring_history_file = 'yankring_history'

" }}}
" UI: Airline Configuration: {{{

let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline_left_sep=''
let g:airline_right_sep=''

" }}}
" UI: NerdTree Config: {{{

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

augroup PlugNerdTree
  autocmd!
  autocmd User KeymapReady nmap <silent> <leader>m :NERDTreeCWD<cr>
augroup END

" }}}
" UI: Rainbow Paranthesis: {{{

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
"
" }}}
" UI: Ctrl P Config: {{{

augroup PlugCtrlP
  autocmd!
  autocmd User KeymapReady noremap <leader>[ :CtrlPBuffer<CR>
  autocmd User KeymapReady noremap <leader>] :CtrlPMRUFiles<CR>
  " autocmd User KeymapReady noremap <leader>] :CtrlPBufTagAll<CR>
  " autocmd User KeymapReady noremap <leader>} :CtrlPTag<CR>
augroup END

let g:ctrlp_buftag_types = {
  \   'go' : {
  \     'bin': 'gotags',
  \     'args': '-f -',
  \   },
  \   'js' : {
  \     'bin': 'jsctags',
  \     'args': '-f',
  \   },
  \ }
let g:ctrlp_extensions = ['buffertag']

" }}}
" Lang: GoLang: {{{

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_list_type = "quickfix"
"let g:go_fmt_command = "goimports"

augroup PlugLangGo
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
" Lang: VimWiki: {{{

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
" Lang: Highlighter Settings: {{{

let python_highlight_all = 1

augroup PlugLangPython
  autocmd!
  autocmd FileType python syn match pythonBoolean "\(\W\|^\)\@<=self\(\.\)\@="
augroup END

" }}}
" Lang: Emmet Config: {{{

augroup PlugEmmet
  autocmd!
  autocmd User KeymapReady imap <C-Tab> <C-y>,
augroup END

" }}}
" Lang: Semantic: {{{

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
" Lang: Deoplete: {{{

let g:deoplete#enable_at_startup = 1

let g:go_fmt_experimental = 1

" let s:mac_clang_locaction = "/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
" let s:mac_clang_locaction = "/Applications/Xcode.app/Contents/Frameworks/libclang.dylib"
let s:mac_clang_locaction = "/usr/local/Cellar/llvm/9.0.0_1/lib/libclang.dylib"
if filereadable(s:mac_clang_locaction)
  let g:deoplete#sources#clang#libclang_path = s:mac_clang_locaction
endif

" }}}
" Lang: UltiSnips: {{{

"let g:UltiSnipsExpandTrigger="<C-Space>"
"let g:UltiSnipsJumpForwardTrigger="<C-j>"
"let g:UltiSnipsJumpBackwardTrigger="<C-k>"
"let g:UltiSnipsListSnippets="<c-l>"

"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

"let g:UltiSnipsSnippetDirectories = [g:VimConfig('UltiSnips'), 'UltiSnips']


"augroup PlugUltiSnips
"  autocmd!

"  " ultisnips is missing a setf trigger for snippets on bufenter
"  autocmd BufEnter *.snippets setf snippets

"  " in ultisnips snippet files, we want actual tabs instead of spaces for
"  " indents. us will use those tabs and convert them to spaces if expandtab is set when
"  " the user wants to insert the snippet.
"  autocmd filetype snippets setlocal noexpandtab

"  autocmd User KeymapReady noremap <silent> <Tab> <C-R>=g:SmartTab()<cr>
"  autocmd User KeymapReady noremap <silent> <S-Tab> <C-R>=g:SmartSTab()<cr>

"  "au VimEnter * exec "inoremap <silent> <Tab> <C-R>=g:UltiSnips_Complete()<cr>"
"augroup END

"" Make tab smart

"func! g:SmartTab()
"  if pumvisible()
"    return "\<C-n>"
"  else
"    return "\<Tab>"
"  endif
"endfunc

"func! g:SmartSTab()
"  if pumvisible()
"    return "\<C-p>"
"  else
"    return "\<Tab>"
"  endif
"endfunc

" }}}
" }}}
