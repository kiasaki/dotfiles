" vim:sw=8:ts=8

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "u"

hi Normal       cterm=NONE         ctermbg=NONE     ctermfg=NONE
hi SpecialKey   cterm=bold                          ctermfg=NONE
hi IncSearch    cterm=reverse                       ctermfg=NONE
hi Search       cterm=reverse                       ctermfg=NONE
hi MoreMsg      cterm=bold                          ctermfg=NONE
hi ModeMsg      cterm=bold                          ctermfg=NONE
hi LineNr       cterm=NONE                          ctermfg=6
hi StatusLine   cterm=NONE         ctermbg=0        ctermfg=15
hi StatusLineNC cterm=NONE         ctermbg=7        ctermfg=0
hi VertSplit    cterm=NONE         ctermbg=6        ctermfg=0
hi Title        cterm=bold                          ctermfg=NONE
hi Visual       cterm=NONE         ctermbg=5        ctermfg=15
hi VisualNOS    cterm=NONE         ctermbg=0        ctermfg=15
hi WarningMsg   cterm=standout                      ctermfg=NONE
hi WildMenu     cterm=standout                      ctermfg=NONE
hi Folded       cterm=standout                      ctermfg=NONE
hi FoldColumn   cterm=standout                      ctermfg=NONE
hi SignColumn   cterm=NONE          ctermbg=NONE    ctermfg=3
hi DiffLine     cterm=NONE                          ctermfg=4
hi DiffAdded    cterm=NONE                          ctermfg=2
hi DiffRemoved  cterm=NONE                          ctermfg=1
hi DiffText     cterm=reverse                       ctermfg=NONE
hi Keyword      cterm=NONE          ctermbg=NONE    ctermfg=6
hi Number       cterm=NONE          ctermbg=NONE    ctermfg=3
hi Char         cterm=NONE          ctermbg=NONE    ctermfg=NONE
hi Format       cterm=NONE          ctermbg=NONE    ctermfg=NONE
hi Special      cterm=NONE          ctermbg=NONE    ctermfg=NONE " 5
hi Constant     cterm=NONE          ctermbg=NONE    ctermfg=NONE " 2
hi Directive    cterm=NONE          ctermbg=NONE    ctermfg=NONE
hi Comment      cterm=NONE          ctermbg=NONE    ctermfg=6
hi Func         cterm=NONE          ctermbg=NONE    ctermfg=NONE " 2
hi Type         cterm=NONE          ctermbg=NONE    ctermfg=6
hi Identifier   cterm=NONE          ctermbg=NONE    ctermfg=NONE
hi PreProc      cterm=NONE                          ctermfg=NONE " 2
hi Statement    cterm=NONE          ctermbg=NONE    ctermfg=6
hi Conditional  cterm=NONE          ctermbg=NONE    ctermfg=6
hi Noise        cterm=NONE          ctermbg=NONE    ctermfg=NONE " 8
hi Ignore       cterm=bold                          ctermfg=NONE
hi String       cterm=NONE                          ctermfg=4
hi Underlined   cterm=underline                     ctermfg=4
hi netrwDir     cterm=NONE                          ctermfg=4
hi Error        cterm=NONE          ctermbg=9       ctermfg=15
hi ErrorMsg     cterm=NONE          ctermbg=9       ctermfg=15
hi ALEError     cterm=NONE          ctermbg=9       ctermfg=15
hi Todo         cterm=bold,standout ctermbg=0       ctermfg=11
hi MatchParen   cterm=bold          ctermbg=250     ctermfg=NONE
hi ColorColumn                      ctermbg=250
hi Pmenu                            ctermbg=7

" Helper for determining highlight group under cursor when developing theme
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
