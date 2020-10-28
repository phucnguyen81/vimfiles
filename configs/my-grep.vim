func! s:Grep(wholeword, ...) abort
    let pattern = empty(a:000)? expand('<cword>'): a:000[0]
    call my#grep#grep(#{
        \ dir: getcwd(),
        \ wholeword: a:wholeword,
        \ pattern: pattern
        \})
endfunc
command! -nargs=? -bang Grep call <SID>Grep(<bang>0, <f-args>)
