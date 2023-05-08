" NOTE: Colorscheme should be set once in vimrc.
" Setting colorscheme here can cause color issue with the tabline.

" Show window's title and icons
set title icon

set guioptions-=e  "no guitablabel"
set guioptions-=m  "no menu bar"
set guioptions-=t  "no tearoff menu items"
set guioptions-=T  "no toolbar"
set guioptions-=r guioptions-=R  "no right scrollbar"
set guioptions-=l guioptions-=L  "no left scrollbar"
set guioptions-=b guioptions-=h  "no bottom scrollbar"
set guioptions+=c  "use console dialogs for simple choices"

" Don't blink cursor for n-v-c modes
set guicursor+=n-v-c:blinkon0

" Fonts to try
set guifont=Ubuntu\ Mono\ 12
set guifont+=InputMono:h11
set guifont+=IBM_Plex_Mono:h11
set guifont+=Source_Code_Pro:h11
set guifont+=Consolas:h11

" Select fonts
command SetFont set guifont=*
" vim:fdm=marker:fmr={{,}}:et:ts=4:sts=4:sw=4
