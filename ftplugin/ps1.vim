setlocal suffixesadd+=.ps1

setlocal keywordprg=:Dispatch\ powershell\ -Command\ Get-Help\ -Full

let b:dispatch = 'powershell -NoProfile -NonInteractive -File '.expand('%:p')

let s:dictionary = '~/assets/powershell_dictionary.txt'
if filereadable(expand(s:dictionary))
    exec 'setlocal dictionary='.s:dictionary
endif

func! s:PowershellSearchDoc(symbol) abort
    let symbol = matchstr(a:symbol, '[a-zA-Z].*$')
    let query = 'powershell '.symbol
    call openbrowser#search(query)
endfunc
let b:my_search_doc_function = funcref('s:PowershellSearchDoc')
