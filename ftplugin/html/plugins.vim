if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

" PLUGINS:
if exists('g:loaded_ftplugin_html_plugins')
    finish
endif
let g:loaded_ftplugin_html_plugins=1

if has('win32')
	source $HOME/vimfiles/ftplugin/plugins.vim
	source $HOME/vimfiles/ftplugin/javascript/plugins.vim
else
	source $HOME/.vim/ftplugin/plugins.vim
	source $HOME/.vim/ftplugin/javascript/plugins.vim
endif
