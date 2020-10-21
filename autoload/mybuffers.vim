" For each line, the buffer numbers is found at the beginning of the line
let s:buffer_number_pattern = '^\s*\d\+\s'

" Load the buffer corresponding to current line
function! s:LoadBuffer() abort
    let current_line = getline('.')
    let bufnr = str2nr(matchstr(current_line, s:buffer_number_pattern))
    if !empty(bufnr)
        exec 'buffer '.bufnr
    endif
endfunction

" Go to buffer on <CR>
function! s:MapKeys()
    noremap <silent> <buffer> <CR> :call <SID>LoadBuffer()<CR>
endfunction

" Delete buffers not listed in current buffer
function! s:UpdateBuffers() abort
    let buffers = []

    " Find buffer numbers as the first number in each line
    for line in getline(1, '$')
        let bufnr = str2nr(matchstr(line, s:buffer_number_pattern))
        if bufexists(bufnr)
            call add(buffers, bufnr)
        endif
    endfor

    " Delete buffers not listed in current buffer
    for buf in getbufinfo({'buflisted': 1})
        if index(buffers, buf.bufnr) == -1
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunction

" Write buffer list to a file
function! mybuffers#buffers() abort
    let pid = getpid()
    if exists('g:my_vardir') && isdirectory(g:my_vardir)
        let buffers_file = expand(g:my_vardir.'/vim_pid_'.pid.'.buffers')
    else
        let buffers_file = expand(tempname().'_vim_pid_'.pid.'.buffers')
    endif
    exec 'redir! > '.fnameescape(buffers_file)
    silent ls
    redir END
    new
    exec 'edit '.fnameescape(buffers_file)
endfunction

augroup my_buffers_augroup
    autocmd!
    autocmd BufEnter *.buffers call s:MapKeys()
    autocmd BufLeave *.buffers call s:UpdateBuffers()
augroup END
