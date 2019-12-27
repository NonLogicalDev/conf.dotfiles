" Vim color file
" Converted from Textmate theme Solarized (dark) using Coloration v0.3.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Solarized (dark)"

hi Cursor ctermfg=17 ctermbg=102 cterm=NONE guifg=#002b36 guibg=#819090 gui=NONE
hi Visual ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#073642 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#0d3640 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#0d3640 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#0d3640 gui=NONE
hi LineNr ctermfg=59 ctermbg=23 cterm=NONE guifg=#426066 guibg=#0d3640 gui=NONE
hi VertSplit ctermfg=23 ctermbg=23 cterm=NONE guifg=#264952 guibg=#264952 gui=NONE
hi MatchParen ctermfg=100 ctermbg=NONE cterm=underline guifg=#859900 guibg=NONE gui=underline
hi StatusLine ctermfg=102 ctermbg=23 cterm=bold guifg=#839496 guibg=#264952 gui=bold
hi StatusLineNC ctermfg=102 ctermbg=23 cterm=NONE guifg=#839496 guibg=#264952 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=23 cterm=NONE guifg=NONE guibg=#073642 gui=NONE
hi IncSearch ctermfg=17 ctermbg=60 cterm=NONE guifg=#002b36 guibg=#586e75 gui=NONE
hi Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb4b16 guibg=NONE gui=NONE
hi Folded ctermfg=60 ctermbg=17 cterm=NONE guifg=#586e75 guibg=#002b36 gui=NONE

hi Normal ctermfg=102 ctermbg=17 cterm=NONE guifg=#839496 guibg=#002b36 gui=NONE
hi Boolean ctermfg=136 ctermbg=NONE cterm=NONE guifg=#b58900 guibg=NONE gui=NONE
hi Character ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb4b16 guibg=NONE gui=NONE
hi Comment ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi Conditional ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi DiffAdd ctermfg=102 ctermbg=64 cterm=bold guifg=#839496 guibg=#3e8410 gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#83090b guibg=NONE gui=NONE
hi DiffChange ctermfg=102 ctermbg=23 cterm=NONE guifg=#839496 guibg=#103b5f gui=NONE
hi DiffText ctermfg=102 ctermbg=24 cterm=bold guifg=#839496 guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Float ctermfg=168 ctermbg=NONE cterm=NONE guifg=#d33682 guibg=NONE gui=NONE
hi Function ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi Identifier ctermfg=64 ctermbg=NONE cterm=NONE guifg=#738a05 guibg=NONE gui=NONE
hi Keyword ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi Label ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi NonText ctermfg=23 ctermbg=23 cterm=NONE guifg=#073642 guibg=#07303b gui=NONE
hi Number ctermfg=168 ctermbg=NONE cterm=NONE guifg=#d33682 guibg=NONE gui=NONE
hi Operator ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi PreProc ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi Special ctermfg=102 ctermbg=NONE cterm=NONE guifg=#839496 guibg=NONE gui=NONE
hi SpecialKey ctermfg=23 ctermbg=23 cterm=NONE guifg=#073642 guibg=#0d3640 gui=NONE
hi Statement ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi StorageClass ctermfg=64 ctermbg=NONE cterm=NONE guifg=#738a05 guibg=NONE gui=NONE
hi String ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi Tag ctermfg=32 ctermbg=NONE cterm=bold guifg=#268bd2 guibg=NONE gui=bold
hi Title ctermfg=102 ctermbg=NONE cterm=bold guifg=#839496 guibg=NONE gui=bold
hi Todo ctermfg=60 ctermbg=NONE cterm=inverse,bold guifg=#586e75 guibg=NONE gui=inverse,bold
hi Type ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi rubyFunction ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=30 ctermbg=NONE cterm=NONE guifg=#269186 guibg=NONE gui=NONE
hi rubyConstant ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi rubyStringDelimiter ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyInclude ctermfg=130 ctermbg=NONE cterm=NONE guifg=#bd3800 guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyRegexp ctermfg=160 ctermbg=NONE cterm=NONE guifg=#d30102 guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=160 ctermbg=NONE cterm=NONE guifg=#d30102 guibg=NONE gui=NONE
hi rubyEscape ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb4b16 guibg=NONE gui=NONE
hi rubyControl ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=100 ctermbg=NONE cterm=NONE guifg=#859900 guibg=NONE gui=NONE
hi rubyException ctermfg=130 ctermbg=NONE cterm=NONE guifg=#bd3800 guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=66 ctermbg=NONE cterm=NONE guifg=#469186 guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=136 ctermbg=NONE cterm=NONE guifg=#a57800 guibg=NONE gui=NONE
hi rubyRailsARAssociationMethod ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=160 ctermbg=NONE cterm=NONE guifg=#d01f1e guibg=NONE gui=NONE
hi erubyComment ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=166 ctermbg=NONE cterm=NONE guifg=#cb4b16 guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi javaScriptRailsFunction ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi yamlKey ctermfg=32 ctermbg=NONE cterm=bold guifg=#268bd2 guibg=NONE gui=bold
hi yamlAnchor ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi yamlAlias ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=60 ctermbg=NONE cterm=NONE guifg=#586e75 guibg=NONE gui=NONE
hi cssURL ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi cssColor ctermfg=30 ctermbg=NONE cterm=NONE guifg=#269186 guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=130 ctermbg=NONE cterm=NONE guifg=#bd3800 guibg=NONE gui=NONE
hi cssClassName ctermfg=32 ctermbg=NONE cterm=NONE guifg=#268bd2 guibg=NONE gui=NONE
hi cssValueLength ctermfg=30 ctermbg=NONE cterm=NONE guifg=#269186 guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi cssBraces ctermfg=68 ctermbg=NONE cterm=NONE guifg=#5a74cf guibg=NONE gui=NONE