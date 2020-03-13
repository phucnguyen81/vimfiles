setlocal suffixesadd+=.txt
setlocal suffixesadd+=.md

function! s:SearchDoc(symbol) abort
    let symbol = a:symbol
    let query = 'What is '.symbol.' ?'
    call openbrowser#search(query)
endfunction
let b:my_search_doc_function = funcref('s:SearchDoc')
