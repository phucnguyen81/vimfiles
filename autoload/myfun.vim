" Run a list of shell commands in the terminal
func! myfun#run_terminal_commands(commands) abort
    " Open a terminal over current buffer
    let buf = term_start(&shell, {
        \ 'curwin': 1,
        \ 'term_finish': 'close',
        \ })

    " Close buffer on terminal exit
    if exists('*term_setkill')
        call term_setkill(buf, 'term')
    endif

    " Send each command into the terminal
    for cmd in commands
        call term_sendkeys(buf, cmd)
        call term_sendkeys(buf, "\<CR>")
    endfor
endfunc

" Set common local options for identation of width.
" Here width is the number of spaces for a tab.
func! myfun#set_local_indent(width) abort
    exec "setlocal tabstop=".a:width
    exec "setlocal softtabstop=".a:width
    exec "setlocal shiftwidth=".a:width
    setlocal expandtab
    setlocal smarttab
    setlocal shiftround
    setlocal autoindent
endfunc

" Count occurences of given pattern starting at current line
func! myfun#count(isWORD, ...) abort
    let pattern = expand('<cword>')
    if a:isWORD
        let pattern = expand('<cWORD>')
    endif
    if !empty(a:000)
        let pattern = a:000[0]
    endif
    echom 'Count: '.pattern
    " Escape special characters in pattern
    let pattern = escape(pattern, '/\')
    exec '.,$s/\V\c'.pattern.'//gn'
endfunc

" Clear screen
func! myfun#clear_screen()
    nohlsearch
    normal! \<C-l>
    " From ale plugin
    if exists(':ALEReset')
        ALEReset
    endif
endfunc

" Split based on window width and height ratio
func! myfun#split_window()
    let ratio = winwidth('%') / winheight('%')
    if ratio > 2
        vsplit
    else
        split
    endif
endfunc

" Try to maximize the vim GUI screen
func! myfun#maximize_screen()
    if has('win32')
        simalt ~x
    elseif executable('wmctrl')
        call system("wmctrl -ir ".v:windowid." -b add,maximized_vert,maximized_horz")
        redraw!
    elseif exists(':Fullscreen')
        execute ':Fullscreen'
    else
        echomsg 'Failed to maximize window'
    endif
endfunc

" Close window after moving to the alternate window
func! myfun#close_window()
    let alt_win = win_getid(winnr('#'))
    close!
    silent! call win_gotoid(alt_win)
endfunc

" Delete current buffer, try not to close its window.
" If a window number is given, go to that window before
" deleting the buffer.
func! myfun#delete_buffer(...) abort
    let bufnr = bufnr('%')

    if empty(a:000)
        silent! bnext
    else
        let lastwin = a:000[0]
        silent! let lastwin_id = win_getid(lastwin)
        silent! call win_gotoid(lastwin_id)
    endif

    exec 'bdelete! '.bufnr
endfunc

" Custom complete function for getting filenames in directory of current file.
" Usage: -complete=customlist,myfun#list_file_names
func! myfun#list_file_names(ArgList, L, P)
    let dir = expand('%:h')
    if isdirectory(dir)
        let prefix = a:ArgList
        return map(globpath(dir, prefix.'*.*', 1, 1),
            \ {key, filename -> fnamemodify(filename, ':t')})
    else
        return []
    endif
endfunc

" Edit vimrc profile
func! myfun#edit_my_vimrc()
    if exists('g:my_vimrc_file')
        exec 'edit '.fnameescape(g:my_vimrc_file)
    else
        edit $MYVIMRC
    endif
endfunc

" Edit gvimrc profile
func! myfun#edit_my_gvimrc()
    if exists('g:my_gvimrc')
        exec 'edit '.fnameescape(g:my_gvimrc)
    else
        edit $MYGVIMRC
    endif
endfunc

" Edit a file under the directory of current file
func! myfun#edit(filename) abort
    let filename = a:filename
    let dir = expand('%:h')
    if isdirectory(dir)
        let filepath = expand(dir.'/'.filename)
        exec 'edit '.fnameescape(filepath)
    endif
endfunc

" Save current file using a new name under the same directory.
func! myfun#save_as(new_name) abort
    let new_name = a:new_name
    let dir = expand('%:h')
    if isdirectory(dir)
        let new_path = expand(dir.'/'.new_name)
        if filereadable(new_path)
            if input('Overwrite '.new_path.' (y/n)? ') ==? 'y'
                exec 'saveas! '.fnameescape(new_path)
            endif
        else
            exec 'saveas '.fnameescape(new_path)
        endif
    endif
endfunc

" Make parent directory of current file.
func! myfun#make_dir() abort
    let curfile = myfun#current_file()
    if empty(curfile)
        return
    endif
    let filedir = fnamemodify(curfile, ":p:h")
    if empty(filedir)
        return
    endif
    if !isdirectory(filedir)
        call mkdir(filedir, "p")
    endif
endfunc

" Read a file into current buffer.
" Return the lines read.
func! myfun#read_file(fname) abort
    if filereadable(a:fname)
        let save_cursor = getcurpos()
        let lines = readfile(a:fname)
        call append(line('.'), lines)
        call setpos('.', save_cursor)
        return lines
    endif
    return []
endfunc

" Delete both buffer and its associated file
func! myfun#delete_file_buffer() abort
    let l:file = expand('%')
    if filereadable(l:file)
        if 'y' ==? input('Delete file '.l:file.'? [y/n] ')
            call delete(l:file)
        endif
    endif
    call myfun#delete_buffer()
endfunc

" Delete a buffer that can be moved to with :wincmd wincmd_arg
func! myfun#delete_buffer_at(wincmd_arg) abort
    let l:win = winnr()
    let l:buf = bufnr('%')
    exec "wincmd ".a:wincmd_arg
    if winnr() == l:win
        echoerr "No window to delete"
        return
    endif
    let l:buf_below = bufnr('%')
    " Go back then delete
    exec l:win."wincmd w"
    if l:buf_below != l:buf
        exec "bdelete! ".l:buf_below
    else
        echoerr "Same buffer"
    endif
endfunc

" Quick new tab used with mappings
func! myfun#new_tab() abort
    -tabnew
endfunc

" Delete buffers not associated with files
func! myfun#delete_nofile_buffers()
    for buf in getbufinfo()
        if buf.listed && !filereadable(buf.name)
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunc

" Delete all buffers not shown in windows
func! myfun#delete_nowindow_buffers()
    for buf in getbufinfo()
        if buf.listed && empty(buf.windows)
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunc

" Exchange buffer with another window's.
" 'arg' can be either:
" - a window number
" - argument to a wincmd, e.g. j,k,l,h,w,ect.
" - a buffer name
func! myfun#switch_buffer(arg) abort
    let l:winid = win_getid()
    let l:bufnr = winbufnr(l:winid)

    " do the wincmd
    if len(a:arg) > 1
        " it's a buffer name
        exec "buffer! ".a:arg
        return
    elseif a:arg =~ '\d\+'
        " looks like number, assume a window's number
        exec a:arg."wincmd w"
    else
        " only one character, assume a wincmd
        exec "wincmd ".a:arg
    endif

    let l:next_buf = winbufnr(0)
    " stop here if window or buffer does not change
    if win_getid() == l:winid || l:next_buf == l:bufnr
        return
    endif

    " switch to original buffer
    exec "buffer! ".l:bufnr
    " then go back to orignal window
    exec win_gotoid(l:winid)
    " switch buffer with the other's
    exec "buffer! ".l:next_buf
endfunc

" In current tabpage, rotate buffers among windows.
func! myfun#rotate_buffers() abort
    " track current window to go back to
    let l:curr_win = winnr()

    " Get numbers of all buffers shown in some window in current tab page
    let l:buffers = tabpagebuflist()
    if empty(l:buffers)
        return
    endif

    " Rotate buffer numbers one position to the left
    call add(l:buffers, remove(l:buffers, 0))

    " After rotated, buffer's positions should match their windows.
    " Go to each window and edit corresponding buffer.
    let l:window = 0
    for l:buffer in l:buffers
        let l:window += 1
        exec l:window."wincmd w"
        if buflisted(l:buffer)
            exec "buffer! ".l:buffer
        endif
    endfor

    " Go back to orignal window
    exec l:curr_win."wincmd w"
endfunc

" Remove trailing spaces
func! myfun#remove_trailing_spaces() abort
    let save_pos=getpos('.')
    let save_reg=@/
    exec '%s/\s\+$//e'
    let @/=save_reg
    call setpos('.', save_pos)
endfunc

" Trim spaces
func! myfun#trim(text)
    return substitute(a:text, '\(\s\+$\)\|\(^\s\+\)', '', 'g')
endfunc

" TODO: move to my#project#info
func! myfun#show_context_info() abort
    let virtual_env = exists("$VIRTUAL_ENV") ? expand("$VIRTUAL_ENV") : ""
    let vimrc = exists("$MYVIMRC") ? expand("$MYVIMRC") : ""
    let gvimrc = exists("$MYGVIMRC") ? expand("$MYGVIMRC") : ""
    let project_dir = my#project#dir()
    let session =  v:this_session
    let lineno = line('.')

    let info = [
        \"Directory: ".getcwd(),
        \"Name: ".expand('%:~').'|'.lineno,
        \"Path: ".expand('%:p:~').'|'.lineno,
        \"Buffer: ".bufname(''),
        \"Window: ".winnr(),
        \"",
        \"Project: ".project_dir,
        \"Session: ".session,
        \"Virtual Env: ".virtual_env,
        \"",
        \"HOME: ".expand("$HOME"),
        \"vimrc: ".vimrc,
        \"gvimrc: ".gvimrc,
        \"",
        \"Keymap: ".&keymap,
        \]

    enew
    setlocal hidden buftype=nofile bufhidden=wipe noswapfile
    call append(0, info)
    call cursor(1, 1)
endfunc

func! s:is_netrw_buffer()
    return (&filetype ==? 'netrw') && exists('b:netrw_curdir')
endfunc

func! s:slash() abort
    return !exists("+shellslash") || &shellslash ? '/' : '\'
endfunc

" Return absolute paths for files in range first..second.
" Source: tpope vinegar plugin
func! s:netrw_absolute_paths(first, ...) abort
    if !s:is_netrw_buffer()
        return []
    endif
    let files = getline(a:first, a:0 ? a:1 : a:first)
    call filter(files, 'v:val !~# "^\" "')
    call map(files, "substitute(v:val, '^\\(| \\)*', '', '')")
    call map(files, 'b:netrw_curdir . s:slash() . substitute(v:val, "[/*|@=]\\=\\%(\\t.*\\)\\=$", "", "")')
    return files
endfunc

func! myfun#current_file() abort
    let files = []
    call extend(files, s:netrw_absolute_paths(line('.')))
    call add(files, expand('%:p'))
    return fnamemodify(files[0], ':p')
endfunc

" Return current path (file or directory) most relevant under current context
" TODO get path of current file under netrw
func! myfun#current_path()
    let path = ''
    if (&filetype ==? 'netrw') && exists('b:netrw_curdir')
        let path = b:netrw_curdir
    endif
    if empty(path)
        let path = expand('%:p')
    endif
    if empty(path)
        let path = my#project#dir()
    endif
    return path
endfunc

func! myfun#open_current_path()
    call myfun#open(myfun#current_path())
    redraw!
endfunc

" Yank context path
func! myfun#yank_path() abort
    let path = myfun#current_path()
    call setreg('', path)
    call setreg('+', path)
endfunc

func! myfun#open(path)
    let path = shellescape(a:path)

    if executable('xdg-open')
        return system('xdg-open '.path)
    endif

    if executable('open')
        return system('open '.path)
    endif

    if executable('pwsh')
        let cmd = join([
            \ 'pwsh',
            \ '-NoProfile',
            \ '-NoLogo',
            \ '-NonInteractive',
            \ '-Command Start-Process '.path,
            \ ])
        return system(cmd)
    endif

    if executable('powershell')
        let cmd = join([
            \ 'powershell',
            \ '-NoProfile',
            \ '-NoLogo',
            \ '-NonInteractive',
            \ '-Command Start-Process '.path,
            \ ])
        return system(cmd)
    endif

    throw 'Found no executables to open '.path
endfunc

" Let user select a file from system browser.
" Return the selected file.
func! myfun#select_file() abort
    " Browse only, not save file, title is the file path
    return browse(0,
        \ 'Select file',
        \ my#project#dir(),
        \ expand('%:p:t'))
endfunc

" Let user select a directory from system browser.
" Return the selected directory.
func! myfun#select_dir()
    return browsedir('Select dir', my#project#dir())
endfunc

func! myfun#get_visual_selection() abort
    " NOTE: to check visual mode is active, do mode() == 'v'
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfun

" Paste from clipboard
func! myfun#paste()
    if has('clipboard')
        call myfun#paste_clipboard()
    else
        call myfun#paste_command()
    endif
endfunc

" Paste using external command
func! myfun#paste_command()
    if executable('sfk.exe')
        " Call Windows sfk.exe from WSL
        silent read !sfk.exe fromclip
    elseif executable("pbpaste")
        silent read !pbpaste
    elseif executable("xclip")
        silent read !xclip -selection clipboard -o
    elseif executable("xsel")
        silent read !xsel --clipboard --output
    else
        throw "pbpaste, xclip or xsel in path required"
    endif
endfunc

" Paste from clipboard
func! myfun#paste_clipboard()
    if &paste
        normal! "+p
    else
        set paste
        normal! "+p
        set nopaste
    endif
endfunc

func! myfun#yank() range abort
    let l:prefix="silent ".a:firstline.",".a:lastline."write !"
    if executable("clip.exe")
        " Call Windows clip.exe from WSL
        execute l:prefix."clip.exe"
    elseif executable("clip")
        execute l:prefix."clip"
    elseif executable("pbcopy")
        execute l:prefix."pbcopy"
    elseif executable("xclip")
        execute l:prefix."xclip -selection clipboard -i"
    elseif executable("xsel")
        execute l:prefix."xsel --clipboard --input"
    else
        throw "One of pbcopy, xclip, xsel, or clip is required in path"
    endif
endfunc

" Ask for input, also handle save/restore vim typeahead.
" See inputsave, inputrestore on typeahead issue.
func! myfun#input(prompt, ...)
    call inputsave()
    try
        let l:result = call('input', a:000)
    finally
        call inputrestore()
    endtry
    return l:result
endfunc

" Create tags file for files under current dir, recursively
" (requires exuberant-ctags/universal-ctags)
" Args: 
"   absolute_path: whether to use absolute paths in the tag file
func! myfun#create_tags(absolute_path) abort
    let dir = my#project#dir()
    let dir = input('Create tags for directory: ', dir, 'dir')
    if empty(dir)
        return
    endif
    if !isdirectory(dir)
        throw 'Not a directory: '.dir
    endif

    " R: recursive search, V: verbose
    if executable('universal-ctags')
        let cmd = '!universal-ctags -RV'
    elseif executable('ctags')
        let cmd = '!ctags -RV'
    else
        throw 'Missing ctags/universal-ctags executables.'
    endif
    if a:absolute_path
        " tags-relative=never: don't use paths in the tags file
        let cmd = cmd.' --tag-relative=never'
    endif
    for name in [
        \ '.git', '.venv', '.code',
        \ 'node_modules', '__pycache__'
        \ ]
        let cmd = cmd.' --exclude='.name
    endfor

    copen
    exec 'lcd '.fnameescape(dir)
    exec cmd
    cclose
endfunc

func! myfun#search_doc(...) abort
    if empty(a:000)
        let search_terms = expand('<cword>')
    else
        let search_terms = join(a:000)
    endif

    if exists('b:my_search_doc_function')
        call call(b:my_search_doc_function, [search_terms])
    else
        call openbrowser#search(&filetype.' '.search_terms)
    endif
endfunc

" Source:
" https://damien.pobel.fr/post/configure-neovim-vim-gf-javascript-import/
" ...)
func! myfun#node_modules_include(fname) abort
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"

    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunc
