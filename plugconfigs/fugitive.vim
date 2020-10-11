Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)

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
