if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" PLUGINS:
if exists('g:loaded_ftplugin_javascript_plugins')
    finish
endif
let g:loaded_ftplugin_javascript_plugins = 1

source $HOME/vimfiles/ftplugin/plugins.vim

packadd vim-javascript
