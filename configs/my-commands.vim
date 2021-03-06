" Change current working directory and show it
func! s:ChangeDirectory(...) abort
    let dir = a:0 ? a:1 : my#project#dir()
    exec 'lcd '.fnameescape(dir)
    silent edit ./
endfunc
command! -nargs=? -complete=dir CD call s:ChangeDirectory(<f-args>)

" Redirect output of ex command to file
func! s:RedirCommand(cmd) abort
    redir => message
    silent execute a:cmd
    redir END
    if empty(message)
        echoerr "No output"
        return
    endif
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
endfunc
command! -nargs=+ -complete=command RedirCmd call s:RedirCommand(<q-args>)

" Search for online documentation
command! -nargs=* K call myfun#search_doc(<f-args>)

" Count occurences of give pattern
command! -nargs=? -bang Count call myfun#count(<bang>0, <f-args>)

" TODO detect indentation, see sleuth plugin from tpope
command! -nargs=1 SetLocalIndent call myfun#set_local_indent(<f-args>)

" Print runtimepath
command! Prtp new | call append(0, split(&runtimepath, ',')) | call cursor(1,1)

func! s:ToggleVietnameseKeymap() abort
    if exists('b:saved_keymap')
        exec 'setlocal keymap='.(b:saved_keymap.keymap)
        exec 'setlocal timeoutlen='.(b:saved_keymap.timeoutlen)
        unlet b:saved_keymap
    else
        let b:saved_keymap = {
            \ 'keymap': &keymap,
            \ 'timeoutlen': &timeoutlen,
            \ }
        setlocal keymap=vietnamese-telex_utf-8
        setlocal timeoutlen=3000
    endif
endfunc
command! KeymapVn call s:ToggleVietnameseKeymap()

" Bulk-delete buffers
command! DelNofileBuffers call myfun#delete_nofile_buffers()

command! DelNowindowBuffers call myfun#delete_nowindow_buffers()

" Show current status (extras to status line)
command! Info call myfun#show_context_info()

command! Indent normal m'gg=G``

" Trim trailing spaces
command! Trim call myfun#remove_trailing_spaces()

" Toggle background
command! Bg :let &background = (&background=="light"?"dark":"light")

" Maximize screen
command! Maximize call myfun#maximize_screen()

" Toggle spell-check
command! Spell :set spell!

" Show line numbers
command! LineNumberOn set number relativenumber cursorline

" Don't show line numbers
command! LineNumberOff set nonumber norelativenumber nocursorline

" Generate tags file
command! -bang Ctags call myfun#create_tags(<bang>0)

" Open current path
command! -complete=file Open call myfun#open_current_path()
