" Apply editorconfig file for file format (indent, end-of-line,
" trailing-spaces, etc)
" See https:/github.com/sgur/vim-editorconfig

" Don't apply editorconfig for these cases
let g:editorconfig_blacklist = {
    \ 'filetype': ['git.*', 'fugitive'],
    \ 'pattern': ['\.un~$']}

