if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" PLUGINS:
if exists('g:loaded_ftplugin_scss_plugins')
    finish
endif
let g:loaded_ftplugin_scss_plugins = 1

source $HOME/.vim/ftplugin/plugins.vim
