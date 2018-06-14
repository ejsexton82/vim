" PLUGINS:
if exists('g:loaded_ftplugin_plugins')
    finish
endif
let g:loaded_ftplugin_plugins=1

" ALE: Better than Syntastic! {{{
cabbrev af ALEFix
cabbrev al ALELint
let g:ale_lint_on_text_changed     = 0 " Stop ALE from linting automatically because it's slow
let g:ale_lint_on_enter            = 0 
" let g:ale_lint_on_save             = 0
let g:ale_lint_on_filetype_changed = 0

let g:ale_lint_delay          = 1500   " Wait a couple seconds before linting
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

packadd ale
" }}}
" INDENTLINE: {{{
let g:indentLine_char = '┊'
set list lcs=tab:\┊\ 
" }}}
" TAGBAR: {{{
nmap <F8> :TagbarToggle<CR>
packadd tagbar
" }}}
packadd vim-commentary
packadd vim-surround
