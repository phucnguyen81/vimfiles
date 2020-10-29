" Get a name to make a session with
func! my#session#makename() abort
    let curdir = getcwd()
    let prefix = fnamemodify(curdir, ':h:t')
    let dirname = fnamemodify(curdir, ':t')
    let basename = exists('*FugitiveHead') ? FugitiveHead() : dirname
    let session_name = prefix.'_'.basename
    return substitute(session_name, '\W', '_', 'g')
endfunc
