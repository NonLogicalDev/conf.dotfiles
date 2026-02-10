" Vim color file
" Converted from Textmate theme Monokai Soda using Coloration v0.3.3 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "light_table"

hi Cursor ctermfg=235 ctermbg=231 cterm=NONE guifg=#252525 guibg=#f8f8f0 gui=NONE
hi Visual ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#555555 gui=NONE
hi CursorLine ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#363636 gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#363636 gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#363636 gui=NONE
hi LineNr ctermfg=243 ctermbg=236 cterm=NONE guifg=#797979 guibg=#363636 gui=NONE
hi VertSplit ctermfg=237 ctermbg=237 cterm=NONE guifg=#474747 guibg=#444444 gui=NONE
hi MatchParen ctermfg=158 ctermbg=NONE cterm=underline guifg=#aaeecc guibg=NONE gui=underline
hi StatusLine ctermfg=252 ctermbg=237 cterm=bold guifg=#cccccc guibg=#444444 gui=bold
hi StatusLineNC ctermfg=252 ctermbg=237 cterm=NONE guifg=#cccccc guibg=#444444 gui=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#444444 gui=NONE
hi IncSearch ctermfg=235 ctermbg=152 cterm=NONE guifg=#252525 guibg=#aadddd gui=NONE
hi Search ctermfg=161 ctermbg=NONE cterm=underline,bold guifg=NONE guibg=NONE gui=underline
hi Directory ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi Folded ctermfg=245 ctermbg=235 cterm=NONE guifg=#888888 guibg=#252525 gui=NONE

hi Normal ctermfg=252 ctermbg=235 cterm=NONE guifg=#cccccc guibg=#2d2d2d gui=NONE
hi Boolean ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi Character ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi Comment ctermfg=245 ctermbg=NONE cterm=NONE guifg=#888888 guibg=NONE gui=NONE
hi Conditional ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi DiffAdd ctermfg=252 ctermbg=64 cterm=bold guifg=#cccccc guibg=#46830c gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8b0707 guibg=NONE gui=NONE
hi DiffChange ctermfg=252 ctermbg=23 cterm=NONE guifg=#cccccc guibg=#233856 gui=NONE
hi DiffText ctermfg=252 ctermbg=24 cterm=bold guifg=#cccccc guibg=#204a87 gui=bold
hi ErrorMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi WarningMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#f8f8f0 guibg=#f92672 gui=NONE
hi Float ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi Function ctermfg=193 ctermbg=NONE cterm=NONE guifg=#d1f1a1 guibg=NONE gui=NONE
hi Identifier ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=italic
hi Keyword ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi Label ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi NonText ctermfg=236 ctermbg=235 cterm=NONE guifg=#3b3a32 guibg=#2d2d2d gui=NONE
hi Number ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi Operator ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi PreProc ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi Special ctermfg=252 ctermbg=NONE cterm=NONE guifg=#cccccc guibg=NONE gui=NONE
hi SpecialKey ctermfg=59 ctermbg=236 cterm=NONE guifg=#3b3a32 guibg=#363636 gui=NONE
hi Statement ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi StorageClass ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=italic
hi String ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi Tag ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi Title ctermfg=252 ctermbg=NONE cterm=bold guifg=#cccccc guibg=NONE gui=bold
hi Todo ctermfg=245 ctermbg=NONE cterm=inverse,bold guifg=#888888 guibg=NONE gui=inverse,bold
hi Type ctermfg=193 ctermbg=NONE cterm=NONE guifg=#d1f1a1 guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi rubyClass ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyFunction ctermfg=193 ctermbg=NONE cterm=NONE guifg=#d1f1a1 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubySymbol ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi rubyConstant ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi rubyStringDelimiter ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi rubyBlockParameter ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi rubyInstanceVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyInclude ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyGlobalVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRegexp ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi rubyRegexpDelimiter ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi rubyEscape ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi rubyControl ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyClassVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyOperator ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyException ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyPseudoVariable ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi rubyRailsUserClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi rubyRailsARAssociationMethod ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyRailsARMethod ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyRailsRenderMethod ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi rubyRailsMethod ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi erubyDelimiter ctermfg=246 ctermbg=NONE cterm=NONE guifg=#999999 guibg=NONE gui=NONE
hi erubyComment ctermfg=245 ctermbg=NONE cterm=NONE guifg=#888888 guibg=NONE gui=NONE
hi erubyRailsMethod ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi htmlTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlEndTag ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlTagName ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlArg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi javaScriptFunction ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=italic
hi javaScriptRailsFunction ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi javaScriptBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlKey ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi cssURL ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=italic
hi cssFunctionName ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi cssColor ctermfg=183 ctermbg=NONE cterm=NONE guifg=#ccaaff guibg=NONE gui=NONE
hi cssPseudoClassId ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi cssClassName ctermfg=158 ctermbg=NONE cterm=NONE guifg=#aaeecc guibg=NONE gui=NONE
hi cssValueLength ctermfg=152 ctermbg=NONE cterm=NONE guifg=#aadddd guibg=NONE gui=NONE
hi cssCommonAttr ctermfg=81 ctermbg=NONE cterm=NONE guifg=#66d9ef guibg=NONE gui=NONE
hi cssBraces ctermfg=246 ctermbg=NONE cterm=NONE guifg=#999999 guibg=NONE gui=NONE