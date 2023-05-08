" Source vim commands/scripts
" Reference: https://vim.fandom.com/wiki/Source_current_file_when_editing_a_script

" Dumps a list of vim script lines in a file and source it
func! s:source_lines(lines)
  let lines = a:lines
  let tmpsofile = tempname()
  call writefile(lines, tmpsofile)
  execute "source ".fnameescape(tmpsofile)
  call delete(tmpsofile)
endfunc

" Source a range of vim script
func! s:source_range() range
  let lines = getline(a:firstline, a:lastline)
  call s:source_lines(lines)
endfunc

" Source current line only
func! s:source_current_line()
    let line = getline(".")
    call s:source_lines([line])
endfunc

command! -range Source <line1>,<line2>call s:source_range()
xnoremap <C-s><C-v> :call <SID>source_range()<CR>
nnoremap <C-s><C-v> :call <SID>source_current_line()<CR>
