" Show window title and icons
set title icon

" Don't need menus, scroll bars, tab line...
set guioptions=c

" Don't blink cursor for n-v-c modes
set guicursor+=n-v-c:blinkon0

" Fonts to try
set guifont=Ubuntu\ Mono\ 12
set guifont+=IBM_Plex_Mono:h11
set guifont+=Source_Code_Pro:h11
set guifont+=InputMono_ExLight:h11
set guifont+=Consolas:h11

" NOTE: If colorscheme is already set in vimrc, setting colorscheme here can
" cause color issue with the tabline
"
" set background=dark
" silent! colorscheme gruvbox

" Select fonts
command SetFont set guifont=*
