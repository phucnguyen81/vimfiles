" substitution with :Subvert from vim-abolish plugin
" :Subvert accounts for plurals and lower/upper cases
function s:Subvert()
    let l:what = input("Replace what? e.g. facilit{y,ies}: ")
    if empty(l:what)
        return
    endif

    let l:replacement = input("Replace '".l:what."' with? e.g. building{,s}: ")
    if empty(l:replacement)
        return
    endif

    exec "1,$Subvert/".l:what."/".l:replacement."/gc"
endfunction

" Smart substitution that handles cases and plurals.
" Call :Subvert from vim-abolish
command Isubvert call s:Subvert()
