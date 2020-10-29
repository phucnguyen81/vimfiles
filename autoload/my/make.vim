" Run a compiler plugin with :make
func! my#make#make(compiler, dir) abort
    let save_dir = getcwd()
    let save_makeprg = &makeprg
    let save_errorformat = &errorformat
    try
        if !empty(a:dir)
            exec 'lcd '.fnameescape(a:dir)
        endif
        if !empty(a:compiler)
            exec 'compiler '.a:compiler
        endif
        make
        redraw!
    finally
        let &l:makeprg = save_makeprg
        let &l:errorformat = save_errorformat
        exec 'lcd '.fnameescape(save_dir)
        botright copen
    endtry
endfunc

" Run a compiler plugin with :lmake
func! my#make#lmake(compiler, dir) abort
    let save_dir = getcwd()
    let save_makeprg = &makeprg
    let save_errorformat = &errorformat
    try
        if !empty(a:dir)
            exec 'lcd '.fnameescape(a:dir)
        endif
        if !empty(a:compiler)
            exec 'compiler '.a:compiler
        endif
        lmake
        redraw!
    finally
        let &l:makeprg = save_makeprg
        let &l:errorformat = save_errorformat
        exec 'lcd '.fnameescape(save_dir)
        botright lopen
    endtry
endfunc
