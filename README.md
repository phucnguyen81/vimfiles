## Unix install/upgrade
-   Clone this repo into `~/.vim`
-   Launch vim and run `:PlugInstall` to install plugins
-   Check if `has('python3')` returns 1
-   If no python3, use `:version` to see the python version vim was compiled with
-   Install the python version

## Windows install/upgrade
-   Clone this repo into `~/vimfiles`
-   Launch vim and run `:PlugInstall` to install plugins
-   Check if `has('python3')` returns 1
-   If no python3, use `:version` to see the python version vim was compiled with
-   Download the python distribution and extract it into `~/vimfiles/pythonthree`

## Dashboard
- `<Leader><Leader>` shows startup dashboard

## Fuzzy search
-   `<Leader>nn` or `:NN` performs fuzzy search in current project

## Snippets
-   Currently using `vim-snipmate` plugin
-   Run `:SnipMateOpenSnippetFiles` to see available snippets for current filetype
-   Edit snippet files to update snippets

## Templates
- `<Leader>rt` does fuzzy search a template to insert into current buffer
- `:Tpl` shows template dir 
