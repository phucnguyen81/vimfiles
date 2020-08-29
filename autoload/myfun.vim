" Set common local options for identation of width.
" Here width is the number of spaces for a tab.
function! myfun#set_local_indent(width) abort
    exec "setlocal tabstop=".a:width
    exec "setlocal softtabstop=".a:width
    exec "setlocal shiftwidth=".a:width
    setlocal expandtab
    setlocal smarttab
    setlocal shiftround
    setlocal autoindent
endfunction

" Count occurences of given pattern starting at current line
function! myfun#count(isWORD, ...) abort
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
endfunction

" Clear screen
function! myfun#clear_screen()
    nohlsearch
    normal! \<C-l>
    " From ale plugin
    if exists(':ALEReset')
        ALEReset
    endif
endfunction

" Show the active colorscheme, see help with g:colors_name
function! myfun#show_color_name()
    if exists('g:colors_name')
        return g:colors_name
    else
        return ''
    endif
endfunction

" Split based on window width and height ratio
function! myfun#split_window()
    let ratio = winwidth('%') / winheight('%')
    if ratio > 2
        vsplit
    else
        split
    endif
endfunction

" Try to maximize the vim GUI screen
function! myfun#maximize_screen()
    if has('win32')
        simalt ~x
    elseif executable('wmctrl')
        call system("wmctrl -ir ".v:windowid." -b toggle,fullscreen")
        redraw!
    elseif exists(':Fullscreen')
        execute ':Fullscreen'
    else
        echomsg 'Failed to maximize window'
    endif
endfunction

" Close window after moving to the alternate window
function! myfun#close_window()
    let last_win = winnr('#')
    if last_win
        let last_win_id = win_getid(last_win)
        close!
        call win_gotoid(last_win_id)
    else
        close!
    endif
endfunction

" Delete current buffer, try not to close its window.
" If a window number is given, go to that window before
" deleting the buffer.
function! myfun#delete_buffer(...) abort
    let bufnr = bufnr('%')

    if empty(a:000)
        silent! bnext
    else
        let lastwin = a:000[0]
        silent! let lastwin_id = win_getid(lastwin)
        silent! call win_gotoid(lastwin_id)
    endif

    exec 'bdelete! '.bufnr
endfunction

" Make parent directory of current file.
function! myfun#make_dir() abort
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
endfunction

" Read a file into current buffer.
" Return the lines read.
function! myfun#read_file(fname) abort
    if filereadable(a:fname)
        let save_cursor = getcurpos()
        let lines = readfile(a:fname)
        call append(line('.'), lines)
        call setpos('.', save_cursor)
        return lines
    endif
    return []
endfunction

" Delete both buffer and its associated file
function! myfun#delete_file_buffer() abort
    let l:file = expand('%')
    if filereadable(l:file)
        if 'y' ==? input('Delete file '.l:file.'? [y/n] ')
            call delete(l:file)
        endif
    endif
    call myfun#delete_buffer()
endfunction

" Delete a buffer that can be moved to with :wincmd wincmd_arg
function! myfun#delete_buffer_at(wincmd_arg) abort
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
endfunction

" Quick new tab used with mappings
function! myfun#new_tab() abort
    -tabnew
endfunction

" Delete buffers not associated with files
function! myfun#delete_nofile_buffers()
    for buf in getbufinfo()
        if buf.listed && !filereadable(buf.name)
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunction

" Delete all hidden buffers
function! myfun#delete_hidden_buffers()
    for buf in getbufinfo()
        if buf.listed && buf.hidden
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunction

" Delete all buffers not shown in windows
function! myfun#delete_nowindow_buffers()
    for buf in getbufinfo()
        if buf.listed && empty(buf.windows)
            exec 'bdelete! '.buf.bufnr
        endif
    endfor
endfunction

" Exchange buffer with another window's.
" 'arg' can be either:
" - a window number
" - argument to a wincmd, e.g. j,k,l,h,w,ect.
" - a buffer name
function! myfun#switch_buffer(arg) abort
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
endfunction

" In current tabpage, rotate buffers among windows.
function! myfun#rotate_buffers() abort
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
endfunction

" Remove trailing spaces
function! myfun#remove_trailing_spaces() abort
    let save_pos=getpos('.')
    let save_reg=@/
    exec '%s/\s\+$//e'
    let @/=save_reg
    call setpos('.', save_pos)
endfunction

function! myfun#show_info() abort
    let virtual_env = exists("$VIRTUAL_ENV") ? expand("$VIRTUAL_ENV") : ""
    let my_gvimrc = exists("$MYGVIMRC") ? expand("$MYGVIMRC") : ""

    let info = [
      \"HOME: ".expand("$HOME"),
      \"Virtual Env: ".virtual_env,
      \"vimrc: ".expand("$MYVIMRC"),
      \"gvimrc: ".my_gvimrc,
      \"",
      \"Working dir: ".getcwd(),
      \"Context dir: ".myfun#current_dir(),
      \"",
      \"Path: ".expand('%:p'),
      \"File: ".expand('%'),
      \"Buffer: ".bufname(''),
      \"Window: ".winnr(),
      \"",
      \"Session: ".v:this_session,
      \"Keymap: ".&keymap,
      \]

    new
    setlocal hidden buftype=nofile bufhidden=wipe noswapfile
    call append(0, info)
    call cursor(1, 1)
endfunction

function! s:is_netrw_buffer()
    return (&filetype ==? 'netrw') && exists('b:netrw_curdir')
endfunction

" Return directory most relevant to current buffer
function! myfun#current_dir()
    if (&filetype ==? 'netrw')
        \ && exists('b:netrw_curdir')
        \ && isdirectory(b:netrw_curdir)
        return expand(b:netrw_curdir)
    endif
    " git_dir from fugitive plugin
    if (&filetype ==? 'fugitive')
        \ && exists('b:git_dir')
        \ && isdirectory(b:git_dir)
        return fnamemodify(b:git_dir, ':h')
    endif
    " TODO replace vim-rooter/FindRootDirectory with my own function
    if exists('*FindRootDirectory')
        let curdir = FindRootDirectory()
        if isdirectory(curdir)
            return curdir
        endif
    endif
    let curdir = expand('%:p:h')
    if isdirectory(curdir)
        return curdir
    endif
    return getcwd()
endfunction

function! s:slash() abort
  return !exists("+shellslash") || &shellslash ? '/' : '\'
endfunction

" Return absolute paths for files in range first..second.
" Source: tpope vinegar plugin
function! s:netrw_absolute_paths(first, ...) abort
    if !s:is_netrw_buffer()
        return []
    endif
    let files = getline(a:first, a:0 ? a:1 : a:first)
    call filter(files, 'v:val !~# "^\" "')
    call map(files, "substitute(v:val, '^\\(| \\)*', '', '')")
    call map(files, 'b:netrw_curdir . s:slash() . substitute(v:val, "[/*|@=]\\=\\%(\\t.*\\)\\=$", "", "")')
    return files
endfunction

function! myfun#current_file() abort
    let files = []
    call extend(files, s:netrw_absolute_paths(line('.')))
    call add(files, expand('%:p'))
    return fnamemodify(files[0], ':p')
endfunction

" Return current path (file or directory) most relevant under current context
" TODO get path of current file under netrw
function! myfun#current_path()
    let path = ''
    if (&filetype ==? 'netrw') && exists('b:netrw_curdir')
        let path = b:netrw_curdir
    endif
    if empty(path)
        let path = expand('%:p')
    endif
    if empty(path)
        let path = myfun#current_dir()
    endif
    return path
endfunction

function! myfun#open_current_path()
    call myfun#open(myfun#current_path())
    redraw!
endfunction

function! myfun#open(path)
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
endfunction

" Let user select a file from system browser.
" Return the selected file.
function! myfun#select_file() abort
    " Browse only, not save file, title is the file path
    return browse(0,
        \ 'Select file',
        \ myfun#current_dir(),
        \ expand('%:p:t'))
endfunction

" Let user select a directory from system browser.
" Return the selected directory.
function! myfun#select_dir()
    return browsedir('Select dir', myfun#current_dir())
endfunction

function! myfun#get_visual_selection() abort
    " Cannot find this in built-in Vim script function!
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
function! myfun#paste()
    if has('clipboard')
        call myfun#paste_clipboard()
    else
        call myfun#paste_command()
    endif
endfunction

" Paste using external command
function! myfun#paste_command()
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
endfunction

" Paste from clipboard
function! myfun#paste_clipboard()
    if &paste
        normal! "+p
    else
        set paste
        normal! "+p
        set nopaste
    endif
endfunction

function! myfun#yank() range abort
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
endfunction

" Ask for input, also handle save/restore vim typeahead.
" See inputsave, inputrestore on typeahead issue.
function! myfun#input(prompt, ...)
    call inputsave()
    try
        let l:result = call('input', a:000)
    finally
        call inputrestore()
    endtry
    return l:result
endfunction

" Create tags file for files under current dir, recursively
" (requires exuberant-ctags/universal-ctags)
"
" Ctrl-] (or :tag) jumps to tag under cursor
" g<ctrl-]> jumps to ambiguous tags
" Ctrl-t (or :pop) jumps back up the tag stack
function! myfun#create_tags(absolute_path) abort
    let dir = myfun#current_dir()
    let dir = input("Create tags for directory: ", dir, 'dir')
    if empty(dir)
        return
    endif
    if !isdirectory(dir)
        throw 'Not a directory: '.dir
    endif

    " -R: recursively down sub-dir
    " -V: verbose
    let cmd = "!ctags -R -V"
    if a:absolute_path
        " tags-relative=never: don't use paths in the tags file
        let cmd = cmd." --tag-relative=never"
    endif
    for name in ['.git', '__pycache__', '.venv', '.code', 'node_modules']
        let cmd = cmd." --exclude=".name
    endfor
    let cmd = cmd." ."

    split
    exec 'lcd '.fnameescape(dir)
    exec cmd
endfunction

function! myfun#search_doc(...) abort
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
endfunction

" Source:
" https://damien.pobel.fr/post/configure-neovim-vim-gf-javascript-import/
" TODO more robust solution (detect root directory, specific to javascript,
" ...)
function! myfun#find_node_modules_filename(fname) abort
    let nodeModules = "./node_modules/"
    let packageJsonPath = nodeModules . a:fname . "/package.json"

    if filereadable(packageJsonPath)
        return nodeModules . a:fname . "/" . json_decode(join(readfile(packageJsonPath))).main
    else
        return nodeModules . a:fname
    endif
endfunction

" Used in 'includeexpr' to resolve file names
function! myfun#includeexpr(filename) abort
    let fname = myfun#find_node_modules_filename(a:filename)
    if filereadable(fname)
        return fname
    endif
endfunction

