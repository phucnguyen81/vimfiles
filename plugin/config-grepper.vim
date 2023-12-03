" vim-grepper: Work with multiple grep tools
" Source: https://github.com/mhinz/vim-grepper.git

" Basic usage:
" :Grepper then do `-<Tab>` to show options, enter to get grepper prompt
" At grepper prompt, do `<Tab>` to cycle through tools (git, rg,...)
" Enter query at grepper prompt

" Initialize with empty options
let g:grepper = {}

" Select what tool (git, rg, ag,...) to run
let g:grepper.prompt = 1

" Limits to these tools
let g:grepper.tools = ['rg', 'git', 'grep']

" Search in the repo defined in `g:grepper.repo`
let g:grepper.dir = 'repo'

" Mark directory to search for
let g:grepper.repo = ['.git', '.hg', '.svn']

" Open the quickfix/location window if there are any matches
let g:grepper.open = 1

" Don't automatically jump to the first match
let g:grepper.jump = 0
