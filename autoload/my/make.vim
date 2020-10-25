" Run :make under a given directory
func! my#make#make(dir) abort
    let save_dir = getcwd()
    try
        exec 'lcd '.fnameescape(dir)
        make
    finally
        exec 'lcd '.fnameescape(save_dir)
        botright copen
    endtry
endfunc
