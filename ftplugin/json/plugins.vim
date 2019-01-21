setlocal tabstop=2 shiftwidth=2 softtabstop=2
if exists('g:loaded_ftplugin_json_plugins')
    finish
endif
let g:loaded_ftplugin_json_plugins = 1

if has('win32')
	if has('nvim')
		source $HOME/AppData/Local/nvim/ftplugin/plugins.vim
	else
		source $HOME/vimfiles/ftplugin/plugins.vim
	endif
else
	source $HOME/.vim/ftplugin/plugins.vim
endif
