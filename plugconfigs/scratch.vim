" Open Scratch buffer
Plug 'https://github.com/mtth/scratch.vim.git'
"
" TODO when leaving scratch buffer to go back to a non-modifiable buffer,
" an error message is shown: "E21: Cannot make changes, 'modifiable' is off"

if exists('g:my_scratch_file')
    let g:scratch_persistence_file = g:my_scratch_file
endif

" Disable default mappings
let g:scratch_no_mappings = 1

nmap gs :<C-u>Scratch<CR>
xmap gs <Plug>(scratch-selection-reuse)
