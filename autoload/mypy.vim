" Get python 3 context for the given file
function! mypy#forfile(filename)
    let filename = a:filename
    return { 'python' : s:pythonthree_exe
      \ , 'file' : s:find_python3_file(filename)
      \ }
endfunction

" Get python 3 context
function! mypy#pythonthree()
    return { 'home' : s:pythonthree_dir
      \ , 'dll' : s:pythonthree_dll
      \ }
endfunction

" Find python3 installation in base directory
function! s:find_pythonthree_dir()
    if exists('g:my_basedir')
      \ && isdirectory(g:my_basedir)
      \ && isdirectory(expand(g:my_basedir.'/pythonthree'))
        return expand(g:my_basedir.'/pythonthree')
    else
        return ''
    endif
endfunction

" Find python3 directory in base directory
function! s:find_python3_dir()
    if exists('g:my_basedir')
      \ && isdirectory(g:my_basedir)
      \ && isdirectory(expand(g:my_basedir.'/python3'))
        return expand(g:my_basedir.'/python3')
    else
        return ''
    endif
endfunction

" Find a file under python3 directory
function! s:find_python3_file(filename)
    let filename = a:filename
    if empty(filename)
        return ''
    endif
    let python3dir = s:python3_dir
    if empty(python3dir)
        return ''
    endif
    let file = findfile(filename, python3dir)
    if empty(file)
        return ''
    endif
    return s:fullpath(file)
endfunction

" Find the python3 executable, which should be under
" the pythonthree directory
function! s:find_pythonthree_exe()
    let python_dir = s:pythonthree_dir
    let python_exe = findfile('python.exe', python_dir)
    if empty(python_exe)
        let python_exe = findfile('python', python_dir)
    endif
    return s:fullpath(python_exe)
endfunction

" Find the python3 dll, which should be under the pythonthree
" directory
function! s:find_pythonthree_dll()
    if !exists('&pythonthreedll')
        return ''
    endif
    let python_dll_name = fnamemodify(&pythonthreedll, ':t')
    let python_dir = s:pythonthree_dir
    let python_dll = findfile(python_dll_name, python_dir)
    return s:fullpath(python_dll)
endfunction

" Get full path of given path or empty if the path does
" not exist as file/directory.
function! s:fullpath(path)
    if empty(a:path)
        return ''
    endif
    let path = fnamemodify(a:path, ':p')
    if filereadable(path) || isdirectory(path)
        return path
    endif
    return ''
endfunction

let s:pythonthree_dir = s:find_pythonthree_dir()
let s:pythonthree_dll = s:find_pythonthree_dll()
let s:pythonthree_exe = s:find_pythonthree_exe()
let s:python3_dir = s:find_python3_dir()

