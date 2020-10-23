" In Python, macro definitions come after 'def' or 'class'
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

" In Python, the included module come between 'from/import' and 'as'
setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)

" Extract filepath matched in 'include'
function! PythonIncludeExpr(fname)
    let parts = split(a:fname, ' import ')
    let left = parts[0]
    if len(parts) > 1
        let right = parts[1]
        let joined = join([left, right], '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(left, '\.', '/', 'g') . '.py'
endfunction

setlocal includeexpr=PythonIncludeExpr(v:fname)
