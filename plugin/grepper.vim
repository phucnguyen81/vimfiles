" Basic usage:
" :Grepper <Tab> to show flags
" At grepper prompt, do <Tab> to cycle through commands git, rg,...
" Enter query at grepper prompt

nmap gr <Plug>(GrepperOperator)
xmap gr <Plug>(GrepperOperator)

nnoremap <Leader>gr :Grepper<Space>

