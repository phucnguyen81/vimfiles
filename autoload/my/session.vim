" Get a name to make a session with
func! my#session#makename() abort
    let curdir = getcwd()
    let dirname = fnamemodify(curdir, ':t')
    let gitbranch = exists('*FugitiveHead')? FugitiveHead(): ''
    if !empty(gitbranch)
        let session_name = dirname.'_'.gitbranch
    else
        let parent_dir = fnamemodify(curdir, ':h:t')
        let session_name = parent_dir.'_'.dirname
    endif
    return substitute(session_name, '\W', '_', 'g')
endfunc
