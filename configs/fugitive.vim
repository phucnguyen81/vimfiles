Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let project_dir = my#project#dir()
    if empty(finddir('.git', project_dir))
        throw 'No .git directory found in '.project_dir
    endif
    if input('Sync '.project_dir.'? (y/n) ') !=? 'y'
        return
    endif

    botright copen
    redraw!
    let save_dir = getcwd()
    try
        exec 'lcd '.fnameescape(project_dir)
        0Git
        Git add .
        Git commit --message=Sync
        if empty(system('git remote'))
            return
        endif
        Git pull --rebase=merges
        Git push
        0Git
    finally
        exec 'lcd '.fnameescape(save_dir)
    endtry
endfunction

command! -nargs=0 Gsync call <SID>GitSync()
command! -nargs=0 Gadd Git add %
