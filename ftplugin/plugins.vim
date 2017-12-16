" TABS:
set expandtab
set tabstop=4
set shiftwidth=4

" PLUGINS:
if exists('g:loaded_ftplugin_plugins')
    finish
endif
let g:loaded_ftplugin_plugins=1

" ALE: Better than Syntastic!
" {{{
cabbrev af ALEFix
let g:ale_lint_delay          = 1500   " Wait a couple seconds before linting
let g:ale_lint_on_enter       = 0      " Stop ALE from linting when switching buffers
let g:ale_php_phpcbf_standard = 'PSR2' " Use PSR-2 formatting standards with PHP
let g:ale_fixers              = {
            \   'php': [
            \       'phpcbf',
            \       'remove_trailing_lines',
            \       'trim_whitespace'
            \   ],
            \   'vim': [
            \       'remove_trailing_lines',
            \       'trim_whitespace'
            \   ]
            \}
" }}}
packadd ale

" INDENTLINE:
" {{{
let g:indentLine_char = '┊'
" }}}
packadd indentLine

" TAGBAR:
" {{{
nmap <F8> :TagbarToggle<CR>
" }}}
packadd tagbar

packadd vim-commentary

packadd vim-surround
