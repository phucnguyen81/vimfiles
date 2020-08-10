## Unix setup
-   Clone this repo into `~/.vim`
-   Launch vim and run `:PlugInstall` to install plugins

## Unix Python integration
-   Check if `has('python3')` returns 1
-   If no python3, use `:version` to see the python version vim was compiled with
-   Install the python version

## Windows setup
-   Clone this repo into `~/vimfiles`
-   Launch vim and run `:PlugInstall` to install plugins

## Windows Python integration
-   Check if `has('python3')` returns 1
-   If no python3, use `:version` to see the python version vim was compiled with
-   Download the python distribution and extract it into `~/.vim/pythonthree`

## Fuzzy search
-   Press 'leader+n+n' to perform fuzzy search in current project
-   Run ':NN' to perform fuzzy search in current project

## Snippets
-   Currently using 'vim-snipmate' plugin
-   Run ':SnipMateOpenSnippetFiles' to see available snippets
-   Edit snippet files to add/remove snippets

## Templates
-   Run ':Template snippet_name' to insert snippet into current buffer
-   Run ':Template' to go to templates directory
-   Add 'template.py' to provide template for new python file

