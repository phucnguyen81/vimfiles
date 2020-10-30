func! s:default_parms() abort
    return {
        \'dir': getcwd(),
        \'linters': [],
        \}
endfunc

" Use lmake to run linters with a dict parameters, the results
" are collected into location list. The parms are:
" 'dir': a directory to run as current dir
" 'linters': a list of compiler names to run with
func! my#lint#lmake(parms) abort
    let parms = extend(s:default_parms(), a:parms, 'force')
    let dir = parms['dir']
    let linters = parms['linters']

    let save_dir = getcwd()
    let save_makeprg = &makeprg
    let save_errorformat = &errorformat
    try
        if !empty(dir)
            exec 'lcd '.fnameescape(dir)
        endif
        let loclist = []
        for linter in linters
            if !empty(linter)
                exec 'compiler '.linter
            endif
            lmake
            call extend(loclist, getloclist(0))
        endfor
        call setloclist(0, loclist)
    finally
        let &l:makeprg = save_makeprg
        let &l:errorformat = save_errorformat
        exec 'lcd '.fnameescape(save_dir)
    endtry
endfunc
