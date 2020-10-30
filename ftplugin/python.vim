setlocal expandtab autoindent smarttab
setlocal formatoptions=croql foldmethod=indent foldlevel=10
setlocal keywordprg=pydoc
setlocal suffixesadd+=.py

" Enabled linters
let b:linters = ['flake8', 'pylint']
