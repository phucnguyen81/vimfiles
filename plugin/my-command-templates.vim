" For complex commands with many options, we can write
" their templates to a file and run them from there.

if !exists('g:my_command_template')
    echoerr 'g:my_command_template is not defined'
    finish
endif

function s:TemplateFile()
    return g:my_command_template
endfunction

command TGrepper call s:GrepperTemplate()
command Tls call s:LsTemplate()

" Prepare Grepper template file.
" Help: grepper.txt
" Source: https://github.com/mhinz/vim-grepper
function s:GrepperTemplate() abort
    let currdir = myfun#current_dir()
    let pattern = expand('<cword>')

    let t = []
    call add(t, 'lcd '.fnameescape(currdir))
    call add(t, '')
    call add(t, 'Grepper -highlight -quickfix -side -noprompt -dir cwd')
    call add(t, '\ -tool rg -grepprg rg')
    call add(t, '\ --vimgrep --no-heading --with-filename')
    call add(t, '\ --smart-case --fixed-strings')
    call add(t, '\ '.pattern)

    call writefile(t, s:TemplateFile())

    tabnew
    exec 'lcd '.fnameescape(currdir)
    exec 'edit '.fnameescape(s:TemplateFile())
endfunction

function s:LsTemplate() abort
    let lines = []
    call add(lines, 'let s:b = []')
    call add(lines, '')
    call add(lines, '" Buffers to keep')
    for buf in getbufinfo({'buflisted':1})
        call add(lines, 'call add(s:b, '.buf.bufnr.') "'.buf.name)
    endfor
    call add(lines, '')
    call add(lines, 'for buf in getbufinfo({"buflisted":1})')
    call add(lines, '    if index(s:b, buf.bufnr) < 0')
    call add(lines, '        exec "bdelete ".buf.bufnr')
    call add(lines, '    endif')
    call add(lines, 'endfor')

    call writefile(lines, s:TemplateFile())
    exec 'edit '.fnameescape(s:TemplateFile())
endfunction
