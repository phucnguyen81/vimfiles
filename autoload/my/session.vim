" Get a name to make a session with
func! my#session#makename() abort
    let curdir = getcwd()
    let dirname = fnamemodify(curdir, ':t')
    if exists('*FugitiveHead')
        let session_name = dirname.'_'.FugitiveHead()
    else
        let parent_dir = fnamemodify(curdir, ':h:t')
        let session_name = parent_dir.'_'.dirname
    endif
    return substitute(session_name, '\W', '_', 'g')
endfunc
