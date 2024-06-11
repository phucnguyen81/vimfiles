" Common File commands
command! -nargs=0 Open browse edit
command! -nargs=0 Edit exec 'edit '.fnameescape(tempname())
command! -nargs=0 New exec 'new '.fnameescape(tempname())
command! -nargs=0 Vnew exec 'vnew '.fnameescape(tempname())
command! -nargs=0 Oldfiles browse oldfiles
command! -nargs=0 Date normal i<C-R>=strftime('%Y-%m-%d')<CR><Esc>
command! -nargs=0 Time normal i<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR><Esc>
command! -nargs=0 Glocal diffget LOCAL
command! -nargs=0 Gremote diffget REMOTE
command! -nargs=0 Gbase diffget BASE

" Run completion script on current file
function! s:Complete() abort
    let file_path = expand('%:p')
    if file_path == ''
        echo 'No file associated with current buffer'
        return
    endif
    if !filereadable(file_path)
        echo 'File not readable: '.file_path
        return
    endif
    call system('pwsh -NoLogo -', 'complete.ps1 '.shellescape(file_path))
    edit
endfunc
command! -nargs=0 Complete call s:Complete()

" Run google search script on current file
function! s:GSearch() abort
    let file_path = expand('%:p')
    if file_path == ''
        echo 'No file associated with current buffer'
        return
    endif
    if !filereadable(file_path)
        echo 'File not readable: '.file_path
        return
    endif
    call system('pwsh -NoLogo -', 'gsearch.ps1 '.shellescape(file_path))
    edit
endfunc
command! -nargs=0 GSearch call s:GSearch()

if exists('g:my_shell')
    command! -nargs=0 Term call term_start(g:my_shell)
    command! -nargs=0 VTerm call term_start(g:my_shell, {'vertical':1})
endif

" Base dir
if exists('g:my_base')
    command! -nargs=0 Base exec 'edit '.fnameescape(g:my_base)
endif

" Notes
if exists('g:my_notesdir')
    function! MyCompleteNotes(ArgLead, CmdLine, CursorPos)
        " Get the list of note files in g:my_notesdir
        let notesdir = fnameescape(g:my_notesdir)
        let note_files = glob(notesdir . '/' . a:ArgLead . '*', 0, 1)

        " Filter the list to include only file names (not directories)
        let filtered_files = []
        for file in note_files
            call add(filtered_files, fnamemodify(file, ':t'))
        endfor

        " Return the filtered file names for auto-completion
        return filtered_files
    endfunction
    command! -nargs=? -complete=customlist,MyCompleteNotes Note exec 'edit '.fnameescape(g:my_notesdir.'/'.<q-args>)
endif

" Todos
if exists('g:my_todosdir')
    command! -nargs=0 Todo exec 'edit '.fnameescape(g:my_todosdir)
endif

" Bookmarks
if exists('g:my_bookmarks')
    command! -nargs=0 Bookmarks exec 'edit '.fnameescape(g:my_bookmarks)
endif

" Journal
if exists('g:my_journal')
    command! -nargs=0 Journal exec 'edit '.fnameescape(g:my_journal)
endif

" Minai workspace
if exists('g:my_minai')
    command! -nargs=0 Minai exec 'edit '.fnameescape(g:my_minai)
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

" Move current window to a new tab
command! MoveToNewTab wincmd T

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
