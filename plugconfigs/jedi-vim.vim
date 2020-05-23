" Autocompletion library for vim
Plug 'https://github.com/davidhalter/jedi-vim.git'

" Don't initialize at startup
let g:jedi#auto_initialization = 0

" Without forcing version, jedi picks latest python on $PATH TODO: set python
" path per project => just load a per project init script or from env variable
" let g:jedi#force_py_version = 3

