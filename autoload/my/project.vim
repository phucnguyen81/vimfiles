" Return the project directory under current context
func! my#project#dir() abort
    if (&filetype ==? 'netrw')
        \ && exists('b:netrw_curdir')
        \ && isdirectory(b:netrw_curdir)
        return expand(b:netrw_curdir)
    endif
    " git_dir from fugitive plugin
    if (&filetype ==? 'fugitive')
        \ && exists('b:git_dir')
        \ && isdirectory(b:git_dir)
        return fnamemodify(b:git_dir, ':h')
    endif
    " TODO replace vim-rooter/FindRootDirectory with my own function
    if exists('*FindRootDirectory')
        let curdir = FindRootDirectory()
        if isdirectory(curdir)
            return curdir
        endif
    endif
    let curdir = expand('%:p:h')
    if isdirectory(curdir)
        return curdir
    endif
    return getcwd()
endfunc
