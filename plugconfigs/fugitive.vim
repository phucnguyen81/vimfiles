Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)

    call append(line('$'), '--------------')
    read !git status
    call append(line('$'), '--------------')
    read !git add .
    read !git commit --message=Sync
    call append(line('$'), '--------------')
    if empty(system('git remote'))
        return
    endif
    read !git pull --rebase=merges
    read !git push
endfunction

command! -bar -nargs=0 Gsync call <SID>GitSync()
