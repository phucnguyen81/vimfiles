Plug 'https://github.com/tpope/vim-fugitive.git'

" TODO: use makeprg=git
func! s:GitSync() abort
    let project_dir = my#project#dir()
    if empty(finddir('.git', project_dir))
        throw 'No .git directory found in '.project_dir
    endif

    botright copen
    let save_dir = getcwd()
    try
        exec 'lcd '.fnameescape(project_dir)
        compiler git

        make status | redraw
        if input('Sync '.project_dir.'? (y/n) ') !=? 'y'
            return
        endif
        make add . | redraw
        make commit --message=Sync | redraw

        if !empty(system('git remote'))
            make pull --rebase=merges | redraw
            make push | redraw
            make status | redraw
        endif

        " `!` clears command messages
        redraw!
    finally
        exec 'lcd '.fnameescape(save_dir)
    endtry
endfunc

" Git status
nnoremap <Leader>gs :0Git<CR>
" Sync changes with remote
command! -nargs=0 Gsync call <SID>GitSync()
" Stage current file
command! -nargs=0 Gadd Git add %
