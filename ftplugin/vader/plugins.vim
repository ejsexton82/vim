if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" PLUGINS:
if exists('g:loaded_ftplugin_vader_plugins')
    finish
endif
let g:loaded_ftplugin_vader_plugins=1

source $HOME/.vim/ftplugin/plugins.vim

packadd vader.vim
