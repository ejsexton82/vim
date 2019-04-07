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
	if has('nvim')
		source $HOME/AppData/Local/nvim/ftplugin/plugins.vim
	else
		source $HOME/vimfiles/ftplugin/plugins.vim
	endif
else
	source $HOME/.vim/ftplugin/plugins.vim
endif
