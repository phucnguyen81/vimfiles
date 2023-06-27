" Common File commands
command! -nargs=0 Open browse edit
command! -nargs=0 Edit exec 'edit '.fnameescape(tempname())
command! -nargs=0 New exec 'new '.fnameescape(tempname())
command! -nargs=0 Vnew exec 'vnew '.fnameescape(tempname())

if exists('g:my_shell')
    command! -nargs=0 Term call term_start(g:my_shell)
    command! -nargs=0 VTerm call term_start(g:my_shell, {'vertical':1})
endif

" Notes
if exists('g:my_notesdir')
    command! -nargs=0 Note exec 'edit '.fnameescape(g:my_notesdir)
endif

" Todos
if exists('g:my_todosdir')
    command! -nargs=0 Todo exec 'edit '.fnameescape(g:my_todosdir)
endif

command! -nargs=0 Paste call myfun#paste()

" Search documentation for current filetype
command! -nargs=* K call myfun#search_doc(<f-args>)

" Count occurences of give pattern
command! -nargs=? -bang Count call myfun#count(<bang>0, <f-args>)

" TODO detect indentation, see sleuth plugin from tpope
command! -nargs=1 SetLocalIndent call myfun#set_local_indent(<f-args>)

" Show runtimepath
command! RuntimePath new | call append(0, split(&runtimepath, ',')) | call cursor(1,1)

" Toggle keymap for typing Vietnamese
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
command! VnKeymap call s:ToggleVietnameseKeymap()

" Bulk-delete buffers not attached to files
command! DelNofileBuffers call myfun#delete_nofile_buffers()

" Bulk-delete buffers not shown in any window
command! DelNowindowBuffers call myfun#delete_nowindow_buffers()

" Show current status (extras to status line)
command! Info call myfun#show_context_info()

" Indent the whole buffer
command! Indent normal m'gg=G``

" Trim trailing spaces
command! Trim call myfun#remove_trailing_spaces()

" Remove carriage return <C-m>/<CR>, see vim `keycodes`
command! RemoveCR %substitute/\r//

" Toggle between light and dark background
command! Bg :let &background = (&background=="light"?"dark":"light")

" Toggle spell-check
command! Spell :set spell!

" Show line numbers
command! LineNumberOn set number relativenumber cursorline

" Don't show line numbers
command! LineNumberOff set nonumber norelativenumber nocursorline

" Generate tags file
command! -bang Ctags call myfun#create_tags(<bang>0)
