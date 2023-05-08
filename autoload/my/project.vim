let s:root_markers = ['.git', '.hg', '.svn', '.root', '.project']

" Check for project root marker closest to current file
func! s:find_root_dir() abort
    " candidates are directories containing at least one marker file
    let candidates = []
    for name in s:root_markers
        let rootdir = finddir(name, '.;')
        if !empty(rootdir)
            call add(candidates, fnamemodify(rootdir, ':p:h:h'))
        endif

        let rootfile = findfile(name, '.;')
        if !empty(rootfile)
            call add(candidates, fnamemodify(rootfile, ':p:h'))
        endif
    endfor

    " root is the longest path among candidate
    let root = ''
    for candidate in candidates
        if len(candidate) > len(root)
            let root = candidate
        endif
    endfor

    return root
endfunc

" Return the project directory under current context
func! my#project#dir() abort
    " netrw visible directory
    if (&filetype ==? 'netrw')
        \ && exists('b:netrw_curdir')
        \ && isdirectory(b:netrw_curdir)
        return expand(b:netrw_curdir)
    endif

    " b:git_dir is from fugitive plugin
    if (&filetype ==? 'fugitive')
        \ && exists('b:git_dir')
        \ && isdirectory(b:git_dir)
        return fnamemodify(b:git_dir, ':h')
    endif

    let root = s:find_root_dir()
    return empty(root) ? getcwd() : root
endfunc
