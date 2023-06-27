setlocal colorcolumn=80
setlocal keywordprg=pydoc
setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
setlocal autoindent smarttab
setlocal formatoptions=croql foldmethod=indent foldlevel=10
setlocal suffixesadd+=.py

" Enabled linters
let b:linters = ['flake8', 'pylint']
