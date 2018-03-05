if exists('g:loaded_ftplugin_vim_plugins')
    finish
endif
let g:loaded_ftplugin_vim_plugins = 1

if has('win32')
	source $HOME/vimfiles/ftplugin/plugins.vim
else
	source $HOME/.vim/ftplugin/plugins.vim
endif
