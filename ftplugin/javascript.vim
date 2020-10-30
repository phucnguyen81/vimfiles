setlocal suffixesadd+=.js
setlocal suffixesadd+=.jsx
setlocal includeexpr=myfun#node_modules_include(v:fname)
if executable('prettier')
    setlocal formatprg=prettier
endif

" For ale plugin
if exists('g:loaded_ale')
    let b:my_lint_command = 'ALELint'
endif
