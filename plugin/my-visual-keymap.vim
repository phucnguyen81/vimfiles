" Replace selected text with previously yanked text
xnoremap p <Esc>:let current_reg = @"<CR>gvs<c-r>=current_reg<CR><Esc>

" Substitute selected text
xnoremap <Leader>s ""y:.,$s/<C-r>=escape(@",'/\')<CR>//gci<left><left><left><left>

" Improve ~ to convert between lower-case, upper-case and title-case
xnoremap ~ y:call setreg('', <SID>TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

" Search forward for current selection, support multi-line
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-r>=@/<CR><CR>

" Search backward for current selection, support multi-line
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-r>=@/<CR><CR>

" Convert text between lower-case, upper-case and title-case
func! s:TwiddleCase(str)
    if a:str ==# toupper(a:str)
        return  tolower(a:str)
    elseif a:str ==# tolower(a:str)
        return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        return toupper(a:str)
    endif
endfunc

" Set search register to the command type (/ or ?)
func! s:VSetSearch(cmdtype)
    let temp = @s
    try
        normal! gv"sy
        let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    finally
        let @s = temp
    endtry
endfunc
