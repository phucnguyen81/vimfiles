" lightline: configurable status line
" Source: https://github.com/itchyny/lightline.vim.git

func! CurrentDirName() abort
    return fnamemodify(getcwd(), ':t')
endfunc

let s:color = 'default'
if exists('g:my_statuscolor')
    let s:color = g:my_statuscolor
endif

" See :help lightline
let g:lightline = {
    \ 'colorscheme': s:color,
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \           [ 'cwdname' ],
    \           [ 'readonly', 'relativepath', 'modified' ] ],
    \    'right': [ [ 'lineinfo' ],
    \             [ 'percent' ],
    \             [ 'fileformat', 'fileencoding', 'filetype' ] ],
    \ },
    \ 'inactive': {
    \   'left': [ [ 'relativepath' ] ],
    \   'right': [ [ 'lineinfo' ] ],
    \ },
    \ 'tabline': {
    \   'right': []
    \ },
    \ 'tab_component': {
    \   'at': '@'
    \ },
    \ 'tab': {
    \   'active': [ 'tabnum', 'filename', 'modified' ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'cwdname': 'CurrentDirName',
    \ },
    \ }
