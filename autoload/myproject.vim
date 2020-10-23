func! myproject#make() abort
    let save_dir = getcwd()
    try
        exec 'lcd '.fnameescape(myfun#project_dir())
        make
    finally
        exec 'lcd '.fnameescape(save_dir)
        botright copen
    endtry
endfunc
