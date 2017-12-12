" STANDARD VIM CONFIGURATION:
" {{{
set nocompatible             " Make Vim stop acting like Vi

syntax enable                " Enable syntax highlighting
filetype plugin indent on    " Enable file type plugins and indenting

set encoding=UTF-8           " Use UTF-8 encoding
set fileformats=unix,dos,mac " Create new files using unix(LF) file format

set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone " Show full completion menu, even with one entry
set pumheight=15             " Completion menu height

set sidescrolloff=3          " Keep 3 lines left/right
set scrolloff=3              " Keep 3 lines above/below

set number                   " Show current line number
set relativenumber           " Show relative line numbers (good for movements)
set colorcolumn=80           " Show guide column at 80 characters

set foldmethod=marker        " Automatically fold default foldmarker

set gdefault                 " Replace globally (/g) by default
set incsearch                " Incremental search highlighting
set ignorecase               " Ignore case while searching...
set smartcase                " ...except when there are capital letters

set noshowmode               " Hide the mode since Airline shows it
set laststatus=2             " Make sure the status line is displayed

set nobackup                 " Don't need backup files
set noswapfile               " Don't need swap files

set path+=**                 " Search subfolders with find tab completion
set wildmenu                 " Displays all matches for tab completion
set wildignore=*.swp,*.orig  " Basic file types to ignore with find tab completion
set wildignore+=*.lock
set wildignore+=*.phar
set wildignore+=*.bak
set wildignore+=*.ico
set wildignore+=*.jpg,*.jpeg
set wildignore+=*.gif
set wildignore+=*.png
set wildignore+=*.svg

" }}}

" CONEMU CONFIGURATION:
" {{{
if !has('gui_running')
    set term=xterm

    " Fix the colors
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"

    " Fix the BackSpace
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>

    " Fix the Mouse Scroll Wheel
    set mouse=a
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
endif
" }}}

" ACK:
" {{{
cnoreabbrev ack Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
" }}}

" AIRLINE:
" {{{
let g:airline_powerline_fonts = 1
let g:airline_theme           = 'solarized'
let g:airline_solarized_bg    = 'dark'
let g:airline#extensions#tabline#enabled = 1
" }}}

" ALE: Better than Syntastic!
" {{{
cabbrev af ALEFix
let g:ale_lint_delay          = 1500   " Wait a couple seconds before linting
let g:ale_lint_on_enter       = 0      " Stop ALE from linting when switching buffers
let g:ale_php_phpcbf_standard = 'PSR2' " Use PSR-2 formatting standards with PHP
let g:ale_sign_error          = ''    " Cool ALE error symbol
let g:ale_sign_warning        = ''    " Cool ALE warning symbol
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

" FZF: Better than Ctrl-P! (but only if it's installed)
" {{{
if executable('fzf')
    packadd! fzf
    packadd! fzf.vim
    let g:fzf_layout = { 'down': '~40%' }

    " WITH RG: Even better than FZF! (but only if it's installed)
    if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files ' .
                    \ '--ignore-file .gitignore --ignore-file .hgignore ' .
                    \ '--glob !*.ico ' .
                    \ '--glob !*.png ' .
                    \ '--glob !*.gif ' .
                    \ '--glob !*.jpg --glob !*.jpeg --glob !*.jpe ' .
                    \ '--glob !*.ttf --glob !*.eot ' .
                    \ '--glob !*.lock '

        " Use RipGrep with FZF
        cnoreabbrev rg Rg
        command! -bang -nargs=* Rg
                    \ call fzf#vim#grep(
                    \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
                    \   <bang>0 ? fzf#vim#with_preview('up:60%')
                    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                    \   <bang>0)
    endif

    " FZF Utilities
    nnoremap <C-p> :Files<CR>
    nnoremap ; :Buffers<CR>
    nnoremap ,b :Buffers<CR>
    nnoremap ,f :Files<CR>
    nnoremap ,l :Lines<CR>
    nnoremap ,t :Tags<CR>
    "nnoremap <Leader>t :Files<CR>
    "nnoremap <Leader>r :Tags<CR>

    " Insert mode completion
    "imap <c-x><c-k> <plug>(fzf-complete-word)
    "imap <c-x><c-f> <plug>(fzf-complete-path)
    "imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    "imap <c-x><c-l> <plug>(fzf-complete-line)
else
    " TODO Default to Ctrl-P, because it's better than nothing
endif
" }}}

" RIPGREP: Better than Grep! (but only if it's installed)
" {{{
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" }}}

" SHORTCUTS:
" {{{
" Insert mode shortcuts
imap ii <Esc>

" Tag shortcuts
command! MakeTags !ctags -R .
nnoremap <leader>t :tag <c-r><c-w><cr>

" Quickfix shortcut
nnoremap <leader>x :cclose<CR>

nnoremap <C-a> ggVG
map  <C-s> <Esc>:w<CR>
nmap <C-s> :w<CR>
" }}}

" SIGNIFY:
" {{{
highlight SignColumn        ctermbg=None
highlight SignifySignAdd    ctermbg=None ctermfg=119
highlight SignifySignDelete ctermbg=None ctermfg=167
highlight SignifySignChange ctermbg=None ctermfg=227
" }}}

" SNIPPETS:
" {{{
nnoremap ,scontroller :-read $HOME/vimfiles/snippets/controller.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sdivgbrow :-read $HOME/vimfiles/snippets/divgbrow.php<CR>o
nnoremap ,shtml :-read $HOME/vimfiles/snippets/skeleton.html<CR>/HERE<CR>4x
nnoremap ,smodel :-read $HOME/vimfiles/snippets/model.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,stestcase :-read $HOME/vimfiles/snippets/testcase.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sttcontroller :-read $HOME/vimfiles/snippets/ttcontroller.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sttmodel :-read $HOME/vimfiles/snippets/ttmodel.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,stttrait :-read $HOME/vimfiles/snippets/tttrait.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sulgb4 :-read $HOME/vimfiles/snippets/ulgb4.php<CR>o
" }}}

" STARTIFY:
" {{{
let g:startify_session_persistence = 1
let g:startify_list_order          = [
            \   ['Sessions'], 'sessions', 
            \   ['Recent Files'], 'files', 
            \   ['Commands'], 'commands'
            \]
let g:startify_fortune_use_unicode = 1
" }}}

" THEME:
" {{{
set fillchars=vert:│
highlight VertSplit term=NONE cterm=NONE gui=NONE
highlight Folded    ctermbg=4
" }}}
