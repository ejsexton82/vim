" TABS:
set expandtab
set tabstop=4
set shiftwidth=4

" PLUGINS:
if exists('g:loaded_ftplugin_plugins')
    finish
endif
let g:loaded_ftplugin_plugins=1

packadd ale
packadd tagbar
nmap <F8> :TagbarToggle<CR>
packadd vim-commentary
packadd vim-surround
