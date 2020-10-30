" Run linters with lmake, results are collected into location-list.
" Args:
" linters: a list of compiler names to run as linters
" dir: a directory to run as current dir
func! my#linter#lmake(linters, dir) abort
    let dir = a:dir
    let linters = a:linters

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
        if !empty(dir)
            exec 'lcd '.fnameescape(save_dir)
        endif
    endtry
endfunc
