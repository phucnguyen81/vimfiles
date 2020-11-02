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
    make status | redraw
    if input('Sync '.project_dir.'? (y/n) ') !=? 'y'
        return
    endif
    let message = input('Message: ')
    if empty(message)
        return
    endif
    make add . | redraw
    exec 'make commit --message '.shellescape(message) | redraw

    " Merges with upstream changes
    if !empty(system('git remote'))
        make pull --rebase=merges | redraw
        make push | redraw
        make status | redraw
    endif

    " `!` clears command messages
    redraw!
endfunc
