" -----------------------------------------------------------------------------
" File: ao.vim
" Description: Ao color scheme for Vim (ported from Helix)
" Author: YardQuit (Helix version)
" Port: Claude (Vim version based on gruvbox structure)
" Source: https://github.com/helix-editor/helix
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='ao'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:ao_bold')
  let g:ao_bold=1
endif
if !exists('g:ao_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:ao_italic=1
  else
    let g:ao_italic=0
  endif
endif
if !exists('g:ao_undercurl')
  let g:ao_undercurl=1
endif
if !exists('g:ao_underline')
  let g:ao_underline=1
endif
if !exists('g:ao_inverse')
  let g:ao_inverse=1
endif

if !exists('g:ao_termcolors')
  let g:ao_termcolors=256
endif

" }}}
" Palette: {{{

" setup palette dictionary
let s:ao = {}

" fill it with absolute colors [guicolor, ctermcolor]
let s:ao.deep_abyss       = ['#080d15', 232]
let s:ao.stormy_night     = ['#254862', 24]
let s:ao.nightfall_blue   = ['#1f2937', 235]
let s:ao.midnight_thunder = ['#0d1526', 233]
let s:ao.twilight_blue    = ['#2c5484', 24]
let s:ao.pitch_black      = ['#000000', 0]
let s:ao.winter_sky       = ['#f3f4f6', 255]
let s:ao.slate_gray       = ['#838a97', 245]
let s:ao.blaze_orange     = ['#ff9000', 208]
let s:ao.lemon_zest       = ['#ffba00', 214]
let s:ao.leafy_green      = ['#81be83', 108]
let s:ao.dreamy_blue      = ['#6eb0ff', 75]
let s:ao.crystal_blue     = ['#99c7ff', 117]
let s:ao.sky_blue         = ['#45b1e8', 74]
let s:ao.moonlight_ocean  = ['#0c1420', 233]
let s:ao.rustic_red       = ['#540b0c', 52]
let s:ao.ruby_glow        = ['#fa7970', 210]
let s:ao.walnut_brown     = ['#987654', 137]
let s:ao.rustic_amber     = ['#9d5800', 130]
let s:ao.slate_purple     = ['#d2a8ff', 183]
let s:ao.light_purple     = ['#7533bd', 97]
let s:ao.deep_purple      = ['#4c1785', 54]

" Basic color mapping (Helix color names to actual colors)
let s:ao.black  = ['#0d1117', 233]
let s:ao.red    = ['#fa7970', 210]
let s:ao.green  = ['#81be83', 108]
let s:ao.yellow = ['#ffba00', 214]
let s:ao.orange = ['#ff9000', 208]
let s:ao.blue   = ['#45b1e8', 74]
let s:ao.purple = ['#d2a8ff', 183]
let s:ao.brown  = ['#987654', 137]
let s:ao.gray   = ['#838a97', 245]
let s:ao.white  = ['#dadada', 253]

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:ao_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:ao_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:ao_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:ao_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:ao_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" Ao is a dark-only theme
let s:bg0  = s:ao.deep_abyss
let s:bg1  = s:ao.midnight_thunder
let s:bg2  = s:ao.nightfall_blue
let s:bg3  = s:ao.stormy_night
let s:bg4  = s:ao.twilight_blue

let s:fg0  = s:ao.white
let s:fg1  = s:ao.winter_sky
let s:fg2  = s:ao.crystal_blue
let s:fg3  = s:ao.slate_gray
let s:fg4  = s:ao.gray

let s:red    = s:ao.red
let s:green  = s:ao.green
let s:yellow = s:ao.yellow
let s:blue   = s:ao.blue
let s:purple = s:ao.purple
let s:orange = s:ao.orange
let s:brown  = s:ao.brown
let s:gray   = s:ao.gray

" Additional theme-specific colors
let s:blaze_orange   = s:ao.blaze_orange
let s:lemon_zest     = s:ao.lemon_zest
let s:leafy_green    = s:ao.leafy_green
let s:dreamy_blue    = s:ao.dreamy_blue
let s:crystal_blue   = s:ao.crystal_blue
let s:sky_blue       = s:ao.sky_blue
let s:ruby_glow      = s:ao.ruby_glow
let s:walnut_brown   = s:ao.walnut_brown
let s:rustic_amber   = s:ao.rustic_amber
let s:slate_purple   = s:ao.slate_purple
let s:light_purple   = s:ao.light_purple
let s:deep_purple    = s:ao.deep_purple
let s:rustic_red     = s:ao.rustic_red
let s:pitch_black    = s:ao.pitch_black

" reset to 16 colors fallback
if g:ao_termcolors == 16
  let s:bg0[1]     = 0
  let s:red[1]     = 1
  let s:green[1]   = 2
  let s:yellow[1]  = 3
  let s:blue[1]    = 4
  let s:purple[1]  = 5
  let s:sky_blue[1] = 6
  let s:fg3[1]     = 7
  let s:gray[1]    = 8
  let s:orange[1]  = 9
  let s:leafy_green[1] = 10
  let s:lemon_zest[1] = 11
  let s:dreamy_blue[1] = 12
  let s:slate_purple[1] = 13
  let s:crystal_blue[1] = 14
  let s:fg1[1]     = 15
endif

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0  = s:pitch_black[0]
  let g:terminal_color_1  = s:red[0]
  let g:terminal_color_2  = s:green[0]
  let g:terminal_color_3  = s:yellow[0]
  let g:terminal_color_4  = s:blue[0]
  let g:terminal_color_5  = s:purple[0]
  let g:terminal_color_6  = s:sky_blue[0]
  let g:terminal_color_7  = s:fg1[0]
  let g:terminal_color_8  = s:fg3[0]
  let g:terminal_color_9  = s:ruby_glow[0]
  let g:terminal_color_10 = s:leafy_green[0]
  let g:terminal_color_11 = s:lemon_zest[0]
  let g:terminal_color_12 = s:dreamy_blue[0]
  let g:terminal_color_13 = s:slate_purple[0]
  let g:terminal_color_14 = s:crystal_blue[0]
  let g:terminal_color_15 = s:fg0[0]
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Ao Hi Groups: {{{

" memoize common hi groups
call s:HL('AoFg0', s:fg0)
call s:HL('AoFg1', s:fg1)
call s:HL('AoFg2', s:fg2)
call s:HL('AoFg3', s:fg3)
call s:HL('AoFg4', s:fg4)
call s:HL('AoGray', s:fg3)
call s:HL('AoBg0', s:bg0)
call s:HL('AoBg1', s:bg1)
call s:HL('AoBg2', s:bg2)
call s:HL('AoBg3', s:bg3)
call s:HL('AoBg4', s:bg4)

call s:HL('AoRed', s:red)
call s:HL('AoRedBold', s:red, s:none, s:bold)
call s:HL('AoGreen', s:green)
call s:HL('AoGreenBold', s:green, s:none, s:bold)
call s:HL('AoYellow', s:yellow)
call s:HL('AoYellowBold', s:yellow, s:none, s:bold)
call s:HL('AoBlue', s:blue)
call s:HL('AoBlueBold', s:blue, s:none, s:bold)
call s:HL('AoPurple', s:purple)
call s:HL('AoPurpleBold', s:purple, s:none, s:bold)
call s:HL('AoOrange', s:orange)
call s:HL('AoOrangeBold', s:orange, s:none, s:bold)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg0, s:bg0)

set background=dark

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine', s:none, s:bg2)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:none, s:pitch_black)
  " Active tab page label
  call s:HL('TabLineSel', s:fg1, s:bg4)
  " Not active tab page label
  call s:HL('TabLine', s:fg3, s:pitch_black, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn', s:none, s:bg3)

  " Concealed element
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:blaze_orange, s:bg0, s:bold)
endif

" Cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
hi! link lCursor Cursor

" Character under the cursor
call s:HL('MatchParen', s:bg0, s:blaze_orange, s:bold)

" Directory names
hi! link Directory AoBlueBold

" Diff mode
call s:HL('DiffAdd', s:leafy_green, s:bg0, s:inverse)
call s:HL('DiffChange', s:sky_blue, s:bg0, s:inverse)
call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffText', s:yellow, s:bg0, s:inverse)

" Error messages
call s:HL('ErrorMsg', s:bg0, s:ruby_glow, s:bold)
" More prompt
hi! link MoreMsg AoYellowBold
" Current mode message
hi! link ModeMsg AoYellowBold
" 'Press enter' prompt
hi! link Question AoOrangeBold
" Warning messages
call s:HL('WarningMsg', s:lemon_zest, s:none, s:bold)

" Folds
call s:HL('Folded', s:fg3, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:fg3, s:bg0)

" SignColumn
call s:HL('SignColumn', s:none, s:bg0)

" Incsearch
call s:HL('IncSearch', s:bg0, s:blaze_orange, s:bold)
" Search
call s:HL('Search', s:bg0, s:blaze_orange, s:bold)

" Line number
call s:HL('LineNr', s:fg3, s:bg0)

" Non-text characters
call s:HL('NonText', s:bg3)
call s:HL('SpecialKey', s:bg3)

" Messages
hi! link QuickFixLine AoYellowBold

" Popup menu: normal item
call s:HL('Pmenu', s:fg1, s:bg1)
" Popup menu: selected item
call s:HL('PmenuSel', s:fg1, s:bg4)
" Popup menu: scrollbar
call s:HL('PmenuSbar', s:none, s:bg1)
" Popup menu: scrollbar thumb
call s:HL('PmenuThumb', s:none, s:bg4)

" Statusline
call s:HL('StatusLine', s:fg1, s:bg4)
call s:HL('StatusLineNC', s:fg3, s:pitch_black)

" Column separating vertically split windows
call s:HL('VertSplit', s:fg1, s:none)
call s:HL('WinSeparator', s:fg1, s:none)

" Visual mode selection
call s:HL('Visual', s:none, s:light_purple)
hi! link VisualNOS Visual

" Wildmenu completion
call s:HL('WildMenu', s:fg1, s:bg4, s:bold)

" Current font
hi! link Title AoGreenBold

" Spelling
call s:HL('SpellBad', s:none, s:none, s:undercurl, s:ruby_glow)
call s:HL('SpellCap', s:none, s:none, s:undercurl, s:lemon_zest)
call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:sky_blue)
call s:HL('SpellRare', s:none, s:none, s:undercurl, s:walnut_brown)

" }}}
" Syntax Highlighting: {{{

hi! link Special AoOrange

call s:HL('Comment', s:gray, s:none, s:italic)
call s:HL('Todo', s:lemon_zest, s:none, s:bold . s:italic)
call s:HL('Error', s:ruby_glow, s:bg0, s:bold . s:inverse)

" Generic Syntax
hi! link Constant AoBlue
hi! link String AoBlue
hi! link Character AoBlue
hi! link Number AoBlue
hi! link Boolean AoBlue
hi! link Float AoBlue

hi! link Identifier AoOrange
hi! link Function AoPurple

hi! link Statement AoRed
hi! link Conditional AoRed
hi! link Repeat AoRed
hi! link Label AoBlue
hi! link Operator AoFg0
hi! link Keyword AoRed
hi! link Exception AoRed

hi! link PreProc AoFg0
hi! link Include AoFg0
hi! link Define AoFg0
hi! link Macro AoGreen
hi! link PreCondit AoFg0

hi! link Type AoFg0
hi! link StorageClass AoRed
hi! link Structure AoFg0
hi! link Typedef AoFg0

hi! link SpecialChar AoYellow
hi! link Tag AoGreen
hi! link Delimiter AoFg0
hi! link SpecialComment AoGray
hi! link Debug AoYellow

hi! link Underlined AoFg2
hi! link Ignore AoGray

" }}}
" TreeSitter Highlighting: {{{

if has('nvim-0.8')
  " Identifiers
  hi! link @variable AoOrange
  hi! link @variable.builtin AoOrange
  hi! link @variable.parameter AoYellow
  hi! link @variable.member AoGreen
  hi! link @property AoGreen
  hi! link @field AoGreen

  " Literals
  hi! link @constant AoBlue
  hi! link @constant.builtin AoBlue
  hi! link @constant.macro AoGreen
  hi! link @string AoBlue
  hi! link @string.regex AoYellow
  hi! link @string.escape AoYellow
  hi! link @string.special AoYellow
  hi! link @character AoBlue
  hi! link @character.special AoYellow
  hi! link @number AoBlue
  hi! link @boolean AoBlue
  hi! link @float AoBlue

  " Functions
  hi! link @function AoPurple
  hi! link @function.builtin AoPurple
  hi! link @function.call AoPurple
  hi! link @function.macro AoGreen
  hi! link @function.method AoGreen
  hi! link @method AoGreen
  hi! link @method.call AoGreen
  hi! link @constructor AoOrange

  " Keywords
  hi! link @keyword AoRed
  hi! link @keyword.function AoRed
  hi! link @keyword.operator AoBlue
  hi! link @keyword.return AoRed
  hi! link @keyword.storage AoRed
  hi! link @keyword.directive AoFg0
  hi! link @conditional AoRed
  hi! link @repeat AoRed
  hi! link @label AoBlue
  hi! link @exception AoRed

  " Types
  hi! link @type AoFg0
  hi! link @type.builtin AoFg0
  hi! link @type.definition AoFg0
  hi! link @type.qualifier AoGreen
  hi! link @storageclass AoRed
  hi! link @attribute AoYellow
  hi! link @namespace AoFg0

  " Punctuation
  hi! link @punctuation.delimiter AoFg0
  hi! link @punctuation.bracket AoOrange
  hi! link @punctuation.special AoYellow

  " Comment
  hi! link @comment Comment
  hi! link @comment.documentation Comment

  " Markup (Markdown, etc.)
  hi! link @markup.heading AoOrangeBold
  call s:HL('@markup.heading.1', s:crystal_blue, s:none, s:bold)
  call s:HL('@markup.heading.2', s:sky_blue, s:none, s:bold)
  call s:HL('@markup.heading.3', s:dreamy_blue, s:none, s:bold)
  call s:HL('@markup.heading.4', s:crystal_blue)
  call s:HL('@markup.heading.5', s:sky_blue)
  call s:HL('@markup.heading.6', s:dreamy_blue)
  call s:HL('@markup.list', s:blaze_orange)
  call s:HL('@markup.list.checked', s:leafy_green)
  call s:HL('@markup.list.unchecked', s:blaze_orange)
  call s:HL('@markup.bold', s:crystal_blue, s:none, s:bold)
  call s:HL('@markup.italic', s:crystal_blue, s:none, s:italic)
  call s:HL('@markup.strikethrough', s:crystal_blue, s:none, 'strikethrough,')
  call s:HL('@markup.link', s:crystal_blue, s:none, s:underline)
  call s:HL('@markup.link.label', s:crystal_blue)
  call s:HL('@markup.link.url', s:slate_purple, s:none, s:underline)
  call s:HL('@markup.raw', s:fg1)
  call s:HL('@markup.raw.block', s:fg0)
  call s:HL('@markup.quote', s:fg1, s:none, s:italic)

  " Tags
  hi! link @tag AoGreen
  hi! link @tag.attribute AoYellow
  hi! link @tag.delimiter AoOrange

  " Other
  hi! link @operator AoFg0
  hi! link @preproc AoFg0
  hi! link @define AoFg0
  hi! link @include AoFg0
  hi! link @debug AoYellow

  " Text
  hi! link @text AoFg0
  hi! link @text.literal AoFg1
  hi! link @text.reference AoFg2
  hi! link @text.title AoOrangeBold
  call s:HL('@text.uri', s:slate_purple, s:none, s:underline)
  call s:HL('@text.underline', s:none, s:none, s:underline)
  hi! link @text.todo Todo

  " LSP Semantic Tokens (0.9+)
  hi! link @lsp.type.namespace @namespace
  hi! link @lsp.type.type @type
  hi! link @lsp.type.class @type
  hi! link @lsp.type.enum @type
  hi! link @lsp.type.interface @type
  hi! link @lsp.type.struct @type
  hi! link @lsp.type.parameter @variable.parameter
  hi! link @lsp.type.variable @variable
  hi! link @lsp.type.property @property
  hi! link @lsp.type.enumMember @constant
  hi! link @lsp.type.function @function
  hi! link @lsp.type.method @method
  hi! link @lsp.type.macro @macro
  hi! link @lsp.type.decorator @function
endif

" }}}
" LSP & Diagnostics: {{{

if has('nvim-0.6')
  " Diagnostics
  call s:HL('DiagnosticError', s:ruby_glow)
  call s:HL('DiagnosticWarn', s:lemon_zest)
  call s:HL('DiagnosticInfo', s:sky_blue)
  call s:HL('DiagnosticHint', s:walnut_brown)

  call s:HL('DiagnosticVirtualTextError', s:fg1, s:rustic_red)
  call s:HL('DiagnosticVirtualTextWarn', s:fg1, s:rustic_amber)
  call s:HL('DiagnosticVirtualTextInfo', s:fg1, s:bg4)
  call s:HL('DiagnosticVirtualTextHint', s:bg0, s:walnut_brown)

  call s:HL('DiagnosticUnderlineError', s:none, s:none, s:undercurl, s:ruby_glow)
  call s:HL('DiagnosticUnderlineWarn', s:none, s:none, s:undercurl, s:lemon_zest)
  call s:HL('DiagnosticUnderlineInfo', s:none, s:none, s:undercurl, s:sky_blue)
  call s:HL('DiagnosticUnderlineHint', s:none, s:none, s:undercurl, s:walnut_brown)

  " LSP
  call s:HL('LspReferenceText', s:none, s:bg3)
  call s:HL('LspReferenceRead', s:none, s:bg3)
  call s:HL('LspReferenceWrite', s:none, s:bg3)
  call s:HL('LspInlayHint', s:fg3, s:none)
  call s:HL('LspCodeLens', s:fg3, s:none)
endif

" }}}
" Plugin Support: {{{

" Git Signs
hi! link GitSignsAdd AoGreen
hi! link GitSignsChange AoBlue
hi! link GitSignsDelete AoRed

" GitGutter
hi! link GitGutterAdd GitSignsAdd
hi! link GitGutterChange GitSignsChange
hi! link GitGutterDelete GitSignsDelete

" Telescope
call s:HL('TelescopeBorder', s:fg3)
call s:HL('TelescopePromptBorder', s:bg4)
call s:HL('TelescopeResultsBorder', s:fg3)
call s:HL('TelescopePreviewBorder', s:fg3)
call s:HL('TelescopeSelection', s:fg1, s:bg4)
call s:HL('TelescopeSelectionCaret', s:blaze_orange)
call s:HL('TelescopeMultiSelection', s:crystal_blue)
call s:HL('TelescopeMatching', s:sky_blue, s:none, s:bold)

" Neo-tree
call s:HL('NeoTreeNormal', s:fg1, s:bg1)
call s:HL('NeoTreeNormalNC', s:fg1, s:bg1)
call s:HL('NeoTreeDirectoryIcon', s:sky_blue)
call s:HL('NeoTreeDirectoryName', s:sky_blue)
call s:HL('NeoTreeFileName', s:fg1)
call s:HL('NeoTreeFileIcon', s:fg3)
call s:HL('NeoTreeGitAdded', s:leafy_green)
call s:HL('NeoTreeGitModified', s:sky_blue)
call s:HL('NeoTreeGitDeleted', s:ruby_glow)
call s:HL('NeoTreeIndentMarker', s:bg3)

" Which-key
call s:HL('WhichKey', s:crystal_blue)
call s:HL('WhichKeyGroup', s:sky_blue)
call s:HL('WhichKeyDesc', s:fg1)
call s:HL('WhichKeySeparator', s:fg3)
call s:HL('WhichKeyFloat', s:fg1, s:bg1)

" Indent Blankline
call s:HL('IblIndent', s:bg3)
call s:HL('IblScope', s:bg4)
hi! link IndentBlanklineChar IblIndent
hi! link IndentBlanklineContextChar IblScope

" Notify
call s:HL('NotifyERRORBorder', s:ruby_glow)
call s:HL('NotifyWARNBorder', s:lemon_zest)
call s:HL('NotifyINFOBorder', s:sky_blue)
call s:HL('NotifyDEBUGBorder', s:fg3)
call s:HL('NotifyTRACEBorder', s:slate_purple)
call s:HL('NotifyERRORIcon', s:ruby_glow)
call s:HL('NotifyWARNIcon', s:lemon_zest)
call s:HL('NotifyINFOIcon', s:sky_blue)
call s:HL('NotifyDEBUGIcon', s:fg3)
call s:HL('NotifyTRACEIcon', s:slate_purple)
call s:HL('NotifyERRORTitle', s:ruby_glow)
call s:HL('NotifyWARNTitle', s:lemon_zest)
call s:HL('NotifyINFOTitle', s:sky_blue)
call s:HL('NotifyDEBUGTitle', s:fg3)
call s:HL('NotifyTRACETitle', s:slate_purple)

" CMP (completion)
call s:HL('CmpItemAbbrMatch', s:sky_blue, s:none, s:bold)
call s:HL('CmpItemAbbrMatchFuzzy', s:sky_blue)
call s:HL('CmpItemKind', s:crystal_blue)
call s:HL('CmpItemMenu', s:fg3)

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
