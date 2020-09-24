" Enhanced movements
Plug 'https://github.com/easymotion/vim-easymotion.git'

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" Jump using two-character label
nmap s <Plug>(easymotion-s2)

" Jump to a line
nmap S <Plug>(easymotion-bd-jk)

" Jump using two-character label, the label is highlighted
" nmap s <Plug>(easymotion-sn)
" Jump forwoard using two-character label
" nmap s <Plug>(easymotion-f2)
" Jump backward using two-character label
" nmap S <Plug>(easymotion-F2)

