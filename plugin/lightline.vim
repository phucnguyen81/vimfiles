" Status line for vim
" Source: https://github.com/itchyny/lightline.vim

"let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Replace filename with relative-path
let g:lightline = {
    \ 'colorscheme': 'PaperColor',
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'readonly', 'relativepath', 'modified' ] ],
    \ },
    \ 'inactive': {
        \ 'left': [ [ 'relativepath' ] ]
    \ }
\ }
