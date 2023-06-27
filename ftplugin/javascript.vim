setlocal suffixesadd+=.js
setlocal suffixesadd+=.jsx
if executable('prettier')
    setlocal formatprg=prettier
endif

" For ale plugin
if exists('g:loaded_ale')
    let b:my_lint_command = 'ALELint'
endif
