setlocal suffixesadd+=.js
setlocal suffixesadd+=.jsx

if executable('prettier')
    setlocal formatprg=prettier
endif

" For dispatch plugin
let b:dispatch='node %'

