setlocal foldexpr=my#markdown#foldexpr()
setlocal foldmethod=expr
setlocal includeexpr=my#note#includeepxr(v:fname)
setlocal keywordprg=:DictKeywordprg
setlocal suffixesadd+=.md
setlocal suffixesadd+=.txt

let b:ale_fixers = ['prettier']

" TODO: use investigate.vim
func! s:SearchDoc(symbol) abort
    let symbol = a:symbol
    let query = 'What is '.symbol.' ?'
    call openbrowser#search(query)
endfunc
let b:my_search_doc_function = funcref('s:SearchDoc')
