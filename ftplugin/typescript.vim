setlocal suffixesadd+=.d.ts
if executable('prettier')
    setlocal formatprg=prettier\ --parser\ typescript
endif
