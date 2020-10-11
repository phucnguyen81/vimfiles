Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)
    let tmpfile = tempname()
    exec 'edit '.tmpfile

    call append(line('$'), '--------------')
    read !git status
    update

    call append(line('$'), '--------------')
    read !git add .
    update

    call append(line('$'), '--------------')
    read !git commit --message=Sync
    update

    if empty(system('git remote'))
        return
    endif

    call append(line('$'), '--------------')
    read !git pull --rebase=merges
    update

    call append(line('$'), '--------------')
    read !git push
    update
endfunction

command! -bar -nargs=0 Gsync call <SID>GitSync()
