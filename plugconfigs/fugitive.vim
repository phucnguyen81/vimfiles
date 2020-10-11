Plug 'https://github.com/tpope/vim-fugitive.git'

function! s:GitSync() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)

    Git status
    Git add .
    Git commit --message=Sync
    if empty(system('git remote'))
        return
    endif
    Git pull --rebase=merges
    Git push
endfunction

command! -bar -nargs=0 Gsync call <SID>GitSync()

function! GitSync2() abort
    let curdir = myfun#current_dir()
    if input('Sync '.curdir.'? (y/n) ') !=? 'y'
        return
    endif

    " Set local current directory in new buffer
    -tabnew
    exec 'lcd '.fnameescape(curdir)

    " Open a terminal
    " Send the commands to it
    let buf = term_start(&shell, {
        \ 'curwin': 1,
        \ 'term_finish': 'close',
        \ })
    if exists('*term_setkill')
        call term_setkill(buf, 'term')
    endif

    call term_sendkeys(buf, 'git status')
    call term_sendkeys(buf, "\<CR>")

    call term_sendkeys(buf, 'git add .')
    call term_sendkeys(buf, "\<CR>")

    call term_sendkeys(buf, 'git commit --message=Sync')
    call term_sendkeys(buf, "\<CR>")

    if empty(system('git remote'))
        return
    endif

    call term_sendkeys(buf, 'pull --rebase=merges')
    call term_sendkeys(buf, "\<CR>")

    call term_sendkeys(buf, 'git push')
    call term_sendkeys(buf, "\<CR>")
endfunction
