" In Python, definitions come after 'def' or 'class'
let &l:define='^\s*\<\(def\|class\)\>'

" Match everything that comes after from/import
let &l:include='^\s*\<\(from\|import\)\>\zs.\+'

func! PythonIncludeExpr(fname) abort
    let fname = a:fname
    let curdir = substitute(expand('%:h'), '\\', '/', 'g')

    " Collapse spaces
    let fname = substitute(fname, '\s\+', ' ', 'g')
    " Trim
    let fname = substitute(fname, '\ $', '', '')
    let fname = substitute(fname, '^\ ', '', '')
    " Replace 'import' with '/'
    let fname = substitute(fname, '\ import\ ', '/', '')
    " Remove everything from ','
    let fname = substitute(fname, ',.*$', '', '')
    " Remove everything from 'as'
    let fname = substitute(fname, '\ as\ .*$', '', '')
    " Replace starting '.' with current directory
    let fname = substitute(fname, '^\ \?\.', curdir.'/', '')
    " Replace '.' with '/'
    let fname = substitute(fname, '\.', '/', 'g')
    " Collapse '//'
    let fname = substitute(fname, '/\+', '/', 'g')

    for name in [fname, fnamemodify(fname, ':h')]
        if !empty(glob(name.'.py', 1))
            return name.'.py'
        elseif !empty(glob(name.'/__init__.py', 1))
            return name.'/__init__.py'
        endif
    endfor
endfunc

setlocal includeexpr=PythonIncludeExpr(v:fname)
