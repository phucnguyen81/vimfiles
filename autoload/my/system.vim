func! s:complete_parms(parms, expr) abort
    let expr = a:expr
    let parms = {
        \'dir': getcwd(),
        \'input': '',
        \'banner': [],
        \}
    call extend(parms, a:parms, 'force')

    let input = parms['input']
    let banner = parms['banner']
    if empty(banner)
        let parms['banner'] = [
            \'Running...: '.expr,
            \'Input: '.string(input),
            \]
    endif

    return parms
endfunc

" Get output from systemlist call.
"
" Args:
"   expr: the command to run
"   parms: a dict of optional arguments
"       dir: the directory to run the command in
"       input: string or list to pass to stdin
"       banner: list of lines to show while running the command
func! my#system#list(expr, parms) abort
    let expr = a:expr
    let parms = s:complete_parms(a:parms, expr)
    let input = parms['input']
    let dir = parms['dir']
    let banner = parms['banner']

    cexpr banner
    botright copen
    exec 'lcd '.fnameescape(dir)
    redraw
    if empty(input)
        return systemlist(expr)
    else
        return systemlist(expr, input)
    endif
endfunc
