func! s:complete_parms(parms) abort
    let parms = {
        \ 'dir': getcwd(),
        \ 'pattern': '',
        \ 'wholeword': 0
        \ }
    call extend(parms, a:parms, 'force')
    return parms
endfunc

func! my#grep#defaultgrep(params) abort
    throw 'No candidates for grep function.'
endfunc

func! my#grep#ripgrep(params) abort
    let params = s:complete_parms(a:params)
    let dir = params['dir']
    let wholeword = params['wholeword']
    let pattern = params['pattern']
    let grepformat = '%f:%l:%c:%m'
    let grepcmd = join([
        \'rg --no-heading --vimgrep --smart-case',
        \(wholeword ? '--word-regexp' : '--fixed-strings'),
        \shellescape(pattern)
        \])
    let banner = [
        \'Searching...: '.pattern,
        \'Dir: '.dir,
        \'Whole-word: '.(wholeword ? 'Yes' : 'No'),
        \]

    let lines = my#system#list(grepcmd, {'dir': dir, 'banner': banner})
    return getqflist({'efm': grepformat, 'lines': lines})
endfunc

func! my#grep#grep(parms) abort
    if exists('g:MyGrepFunc')
        return g:MyGrepFunc(a:parms)
    else
        throw 'g:MyGrepFunc not defined.'
    endif
endfunc
