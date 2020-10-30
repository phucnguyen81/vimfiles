" 'tagfunc' for my notes. 
" - tags are searched for in '*<tagname>*:'
" - root directory are first one among: g:my_notes_dir, an ancestor
"   dir with '.notes' file, current directory
func! my#note#tagfunc(pattern, flags, info) abort
    " Return the tags if they are found the normal way
    if empty(expand('%'))
        let tags = taglist(a:pattern)
    else
        let tags = taglist(a:pattern, expand('%:p'))
    endif
    if !empty(tags)
        return tags
    endif

    " Look under notes directory
    if exists('g:my_notes_dir') && isdirectory(g:my_notes_dir)
        let notes_dir = g:my_notes_dir
    else
        let notes_dir = getcwd()
    endif

    let rg_options = join([
        \'--no-config',
        \'--no-ignore-vcs',
        \'--no-heading --with-filename',
        \'--vimgrep --smart-case',
        \'--fixed-strings'
        \], ' ')
    let save_dir = getcwd()
    let save_grepprg = &grepprg
    let save_grepformat = &grepformat
    let pattern = '*'.a:pattern.'*:'
    let loclist = []

    " Search for tags with ripgrep
    try
        exec 'lcd '.fnameescape(notes_dir)
        " Search with rg
        let &l:grepprg = 'rg '.rg_options.' $*'
        let &l:grepformat='%f:%l:%c:%m'
        silent exec 'lgrep! '.shellescape(pattern)
        let loclist = getloclist(0)
    finally
        let &l:grepprg = save_grepprg
        let &l:grepformat = save_grepformat
        exec 'lcd '.fnameescape(save_dir)
    endtry

    " Convert search results to tags
    let tags = []
    for loc in loclist
        let filename = fnamemodify(bufname(loc.bufnr), ':~')
        let cmd = 'call cursor('.(loc.lnum).','.(loc.col).')'
        call add(tags, {
            \'name': a:pattern,
            \'filename': filename,
            \'cmd': cmd
            \})
    endfor
    return tags
endfunc
