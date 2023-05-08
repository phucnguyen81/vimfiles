func! my#vifm#select() abort
    let curfile = myfun#current_file()
    if empty(curfile)
        let curfile = '.'
    endif
    if !isdirectory(curfile)
        let curfile = '--select='.curfile
    endif
    let cmd = ['vifm', curfile, curfile]
    let options = {
        \'term_name': 'vifm', 
        \'term_finish': 'close',
        \}
    call term_start(cmd, options)
endfunc
