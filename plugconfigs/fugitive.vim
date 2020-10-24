Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myproject#project_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)
    if !isdirectory('.git')
        throw 'No .git directory found in '.curdir
    endif

    0Git
    Git add .
    Git commit --message=Sync
    if empty(system('git remote'))
        return
    endif
    Git pull --rebase=merges
    Git push
    0Git
endfunction

command! -bar -nargs=0 Gsync call <SID>GitSync()
