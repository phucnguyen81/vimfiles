" Apply editorconfig file for file format (indent, end-of-line, trailing-spaces, etc)
Plug 'https://github.com/sgur/vim-editorconfig.git'

" Cases excluded from editorconfig
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

