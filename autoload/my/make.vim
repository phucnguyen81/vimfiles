" Run a compiler plugin with the following args:
" command: 'make' or 'lmake', default to 'make'
" compiler: the compiler name to run with,
"           default to current makeprg
" dir: the directory to run as current directory,
"      default to current directory
func! s:run_compiler(command, compiler, dir) abort
    let command = empty(a:command)? 'make': a:command

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
        exec command
    finally
        let &l:makeprg = save_makeprg
        let &l:errorformat = save_errorformat
        if !empty(a:dir)
            exec 'lcd '.fnameescape(save_dir)
        endif
    endtry
endfunc

" Run a compiler plugin with :make
func! my#make#make(compiler, dir) abort
    call s:run_compiler('make', a:compiler, a:dir)
endfunc

" Run a compiler plugin with :lmake
func! my#make#lmake(compiler, dir) abort
    call s:run_compiler('lmake', a:compiler, a:dir)
endfunc

