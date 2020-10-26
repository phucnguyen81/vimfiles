" For each line, the buffer numbers is found at the beginning of the line
let s:buffer_number_pattern = '^\s*\d\+\s'
let s:my_buffers_name = 'my_buffers'

" Compare two buf-infos by last-used then buffer-number
func! s:CompareBufInfo(buf1, buf2) abort
    let buf1 = a:buf1
    let buf2 = a:buf2
    if has_key(buf1, 'lastused') && has_key(buf2, 'lastused')
        if buf1.lastused > buf2.lastused
            return 1
        elseif buf1.lastused < buf2.lastused
            return -1
        endif
    elseif buf1.bufnr > buf2.bufnr
        return 1
    elseif buf1.bufnr < buf2.bufnr
        return -1
    else
        return 0
    endif
endfunc

" Get sorted buf-infos
func! s:GetBufInfo() abort
    let bufinfos = getbufinfo({'buflisted': 1})
    return reverse(sort(bufinfos, function('s:CompareBufInfo')))
endfunc

" Load the buffer corresponding to current line
func! s:LoadBuffer() abort
    let current_line = getline('.')
    let bufnr = str2nr(matchstr(current_line, s:buffer_number_pattern))
    if !empty(bufnr)
        exec 'buffer '.bufnr
    endif
endfunc

" Delete buffers not listed in current buffer
func! s:LeaveMyBuffers() abort
    if getbufvar('%', s:my_buffers_name)
        let buffers = []

        " Find buffer numbers as the first number in each line.
        " TODO: use map() here
        for line in getline(1, '$')
            let bufnr = str2nr(matchstr(line, s:buffer_number_pattern))
            if bufexists(bufnr)
                call add(buffers, bufnr)
            endif
        endfor

        " Delete buffers not listed in current buffer
        for buf in s:GetBufInfo()
            if index(buffers, buf.bufnr) == -1
                exec 'bdelete! '.buf.bufnr
            endif
        endfor
    endif
endfunc

" Get a formatted string of a buffer-info
func! s:BufToStr(buf) abort
    let buf = a:buf
    let bufnumber = printf('%4s', buf.bufnr)
    let stat = printf('%3s', buf.hidden ? 'h' : '')
    if empty(buf.name)
        let name = '[No Name]'
    else
        let name = fnamemodify(buf.name, ':~')
    endif
    return bufnumber.' '.stat.' '.name
endfunc

" Show buffer info, one buffer per line
func! s:EnterMyBuffers() abort
    if getbufvar('%', s:my_buffers_name)
        let curbuf = bufnr('%')
        %delete "_
        let buflines = []
        for buf in s:GetBufInfo()
            if !getbufvar(buf.bufnr, s:my_buffers_name)
                let bufline = s:BufToStr(buf)
                call add(buflines, bufline)
            endif
        endfor
        call append(0, buflines)
        call cursor(1, 1)
    endif
endfunc

augroup my_buffers_augroup
    autocmd!
    autocmd BufEnter * call s:EnterMyBuffers()
    autocmd BufLeave * call s:LeaveMyBuffers()
augroup END

" Show buffer list
func! my#buffer#buffers() abort
    new
    call setbufvar('%', s:my_buffers_name, 1)
    setlocal bufhidden=wipe buftype=nofile
    noremap <silent> <buffer> <CR> :call <SID>LoadBuffer()<CR>
    call s:EnterMyBuffers()
endfunc
