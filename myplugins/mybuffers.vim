" Origin: https://github.com/codcodog/simplebuffer.vim
let s:save_cpo = &cpo
set cpo&vim

if !exists("g:botright_height")
    let g:simple_botright_height = 10
endif

" Show buffers
nnoremap <Leader>ls :call mybuffers#ToggleSimpleBuffer()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
