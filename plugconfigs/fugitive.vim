Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)
    edit! .

    Git add .
    Git commit --message=Sync
    if !empty(system('git remote'))
        Git pull
        Git push
    endif
endfunction

command! -bar -nargs=0 Gsync call <SID>GitSync()
