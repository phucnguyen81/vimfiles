" Start-screen/Splash-screen that shows recent files, sessions, etc.
" Source: https://github.com/mhinz/vim-startify.git
" Help: startify.txt

if exists('g:my_session_dir')
    let g:startify_session_dir = g:my_session_dir
endif

" What to show on Startify screen.
" TODO define Bookmarks and Commands.
let g:startify_lists = [
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

