" for vim-commentary
setlocal commentstring=//\ %s

setlocal suffixesadd+=.cs

" for vim-dispatch
let b:dispatch = 'csc.exe '.expand('%:p')
