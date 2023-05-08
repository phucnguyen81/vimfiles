setlocal includeexpr=my#note#includeepxr(v:fname)
setlocal iskeyword+=-
setlocal keywordprg=:DictKeywordprg 
setlocal suffixesadd+=.md
setlocal suffixesadd+=.txt

func! s:SearchDoc(symbol) abort
    let symbol = a:symbol
    let query = 'What is '.symbol.' ?'
    call openbrowser#search(query)
endfunc
let b:my_search_doc_function = funcref('s:SearchDoc')
