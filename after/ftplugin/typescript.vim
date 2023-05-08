let &l:define='\(\<\(class\|public\|private\)\>\|^\s*\ze\i\+(\)'

let &l:include='\s\<from\>\s'

func! TypescriptIncludeExpr(fname) abort
    let fname = a:fname
    let curdir = expand('%:h')

    " Trim left
    let fname = substitute(fname, '^\s\+', '', '')
    " Trim right
    let fname = substitute(fname, '\s\+$', '', '')
    " Relative path
    if !empty(matchstr(fname, '^\.'))
        let fname = simplify(curdir.'/'.fname)
    endif

    " check with src as parent
    for name in [fname, 'src/'.fname]
        if !empty(glob(name.'.ts', 1))
            return name
        endif
    endfor
endfunc

setlocal includeexpr=TypescriptIncludeExpr(v:fname)
