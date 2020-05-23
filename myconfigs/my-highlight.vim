" SignColumn should match background
highlight clear SignColumn

" Current line number row will have same background color in relative mode
highlight clear LineNr

" Manually set highlight for diff mode
highlight DiffText cterm=none ctermfg=Black ctermbg=Red
    \ gui=none guifg=Black guibg=Red

" Manually set highlight for diff mode
highlight DiffChange cterm=none ctermfg=Black ctermbg=LightMagenta
    \ gui=none guifg=Black guibg=LightMagenta

" Manually set background and foreground colors for search highlight.
" This should be left for current colorscheme.
" highlight Search ctermfg=yellow ctermbg=black

