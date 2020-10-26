" Sync changes with remote
func! my#git#sync() abort
    let project_dir = my#project#dir()
    if empty(finddir('.git', project_dir))
        throw 'No .git directory found in '.project_dir
    endif

    " Use git compiler plugin in quickfix buffer
    botright copen
    exec 'lcd '.fnameescape(project_dir)
    compiler git

    " Commit current changes
    redraw | make status
    if input('Sync '.project_dir.'? (y/n) ') !=? 'y'
        return
    endif
    redraw | make add .
    redraw | make commit --message=Sync

    " Merges with upstream changes
    if !empty(system('git remote'))
        redraw | make pull --rebase=merges
        redraw | make push
        redraw | make status
    endif

    " `!` clears command messages
    redraw!
endfunc
