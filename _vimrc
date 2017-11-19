" BASIC CONFIGURATION:

set encoding=UTF-8

" Make Vim stop acting like Vi
set nocompatible

" Enable syntax and plugins
syntax enable
filetype plugin indent on

" CONEMU CONFIGURATION:
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

" LINE NUMBERS:
" 2017-10-19 	Disabled set number to try to improve performance
"set number              " Show current line number
set relativenumber      " Show relative line numbers
set colorcolumn=80

" PLUGINS:
call plug#begin('~/vimfiles/plugged')

" Theme
if has('gui_running')
    Plug 'altercation/vim-colors-solarized'
endif

" General
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'           " Vertical Indendation Lines
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'             " Automatic Text Alignment
Plug 'joonty/vim-sauce'
" Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

" Version Control
Plug 'mhinz/vim-signify'
Plug 'ludovicchabant/vim-lawrencium' " Mercurial wrapper

" Prose
"Plug 'junegunn/goyo.vim'

" Other Formats
" Plug 'vim-scripts/autohotkey-ahk', { 'for': 'ahk' }
Plug 'chivalry/filemaker.vim', { 'for': 'fmcalc' }

" PHP
Plug 'pangloss/vim-javascript', { 'for': ['php', 'html'] }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
Plug 'joonty/vdebug', { 'for': 'php' }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }

call plug#end()

" ACK: vimgrep
cnoreabbrev ack Ack
if executable('rg')
    let g:ackprg = 'rg --vimgrep --no-heading ' .
            \ '--ignore-file .gitignore --ignore-file .hgignore '
endif

" FZF:
let g:fzf_layout = { 'down': '~40%' }
let $FZF_DEFAULT_COMMAND = 'rg --files ' .
            \ '--ignore-file .gitignore --ignore-file .hgignore ' .
            \ '--glob !*.ico ' .
            \ '--glob !*.png ' .
            \ '--glob !*.gif ' .
            \ '--glob !*.jpg --glob !*.jpeg --glob !*.jpe ' .
            \ '--glob !*.ttf --glob !*.eot '

cnoreabbrev rg Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


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

" Ripgrep
"command! -bang -nargs=* Rg
"\ call fzf#vim#grep(
"\   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
"\   <bang>0 ? fzf#vim#with_preview('up:60%')
"\           : fzf#vim#with_preview('right:50%:hidden', '?'),
"\   <bang>0)


" Search down into subfolders, tab completion
set path+=**

" QUICKFIX:
nnoremap <leader>x :cclose<CR>

" WILDIGNORE:
set wildignore+=*/.hg/*,*/.git/*
set wildignore+=*/runtime/*,*/cache/*,*/vendor/*
set wildignore+=*.tags,tags,*/tags
set wildignore+=*.swp,*.orig
set wildignore+=*.lock
set wildignore+=*.phar
set wildignore+=*.eml
set wildignore+=*.bak
set wildignore+=*.ico
set wildignore+=*.jpg,*.jpeg
set wildignore+=*.gif
set wildignore+=*.png
set wildignore+=*.svg

" Display all matching files for tab completion
set wildmenu

" OMNICOMPLETION:
set completeopt=longest,menuone
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" TABS:
if has('gui_running')
    " Tab Commands
    nnoremap <C-Tab>   :tabnext<CR>
    nnoremap <C-S-Tab> :tabprev<CR>

    " opens commands in a new tab (colemak.vim from Shia Coleman)
    cnoreabbr <expr> f    (getcmdtype() . getcmdline() != ':f'    ? 'f'    : 'tabfind' )
    cnoreabbr <expr> fi   (getcmdtype() . getcmdline() != ':fi'   ? 'fi'   : 'tabfind' )
    cnoreabbr <expr> fin  (getcmdtype() . getcmdline() != ':fin'  ? 'fin'  : 'tabfind' )
    cnoreabbr <expr> find (getcmdtype() . getcmdline() != ':find' ? 'find' : 'tabfind' )
    cnoreabbr <expr> h    (getcmdtype() . getcmdline() != ':h'    ? 'h'    : 'tab help')
    cnoreabbr <expr> he   (getcmdtype() . getcmdline() != ':he'   ? 'he'   : 'tab help')
    cnoreabbr <expr> hel  (getcmdtype() . getcmdline() != ':hel'  ? 'hel'  : 'tab help')
    cnoreabbr <expr> help (getcmdtype() . getcmdline() != ':help' ? 'help' : 'tab help')
    cnoreabbr <expr> e    (getcmdtype() . getcmdline() != ':e'    ? 'e'    : 'tabedit' )
    cnoreabbr <expr> ed   (getcmdtype() . getcmdline() != ':ed'   ? 'ed'   : 'tabedit' )
    cnoreabbr <expr> edi  (getcmdtype() . getcmdline() != ':edi'  ? 'edi'  : 'tabedit' )
    cnoreabbr <expr> edit (getcmdtype() . getcmdline() != ':edit' ? 'edit' : 'tabedit' )
endif

" INDENTING:
"filetype indent plugin on

" TAGS:
command! MakeTags !ctags -R .
nnoremap <leader>t :tag <c-r><c-w><cr>
" nnoremap ,t :TagbarOpenAutoClose<CR>

" SNIPPETS:
nnoremap ,scontroller :-read $HOME/vimfiles/snippets/controller.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sdivgbrow :-read $HOME/vimfiles/snippets/divgbrow.php<CR>o
nnoremap ,shtml :-read $HOME/vimfiles/snippets/skeleton.html<CR>/HERE<CR>4x
nnoremap ,smodel :-read $HOME/vimfiles/snippets/model.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,stestcase :-read $HOME/vimfiles/snippets/testcase.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sttcontroller :-read $HOME/vimfiles/snippets/ttcontroller.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sttmodel :-read $HOME/vimfiles/snippets/ttmodel.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,stttrait :-read $HOME/vimfiles/snippets/tttrait.php<CR>:%s/CLASS//g<Left><Left>
nnoremap ,sulgb4 :-read $HOME/vimfiles/snippets/ulgb4.php<CR>o


" GREP:
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" SIGNIFY:
highlight SignColumn        ctermbg=None
highlight SignifySignAdd    ctermbg=None ctermfg=119
highlight SignifySignDelete ctermbg=None ctermfg=167
highlight SignifySignChange ctermbg=None ctermfg=227

" AIRLINE:
" let g:airline_powerline_fonts            = 0
let g:airline_symbols_ascii  		 = 1
" let g:airline_left_sep                   = ''
" let g:airline_left_alt_sep               = ''
" let g:airline_right_sep                  = ''
" let g:airline_right_alt_sep              = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme                      = 'solarized'
let g:airline_solarized_bg               = 'dark'

" INDENTLINE:
let g:indentLine_char = '|'

" THEME:
if has('gui_running')
    set guifont=Inconsolata\ NF:h12
    set background=dark
    let g:solarized_termcolors=256
    colorscheme solarized
endif

" FULL SCREEN:
if has('gui_running')
    " Automatically switch to fullscreen on load
    autocmd GUIEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)
    autocmd GUIEnter * call libcallnr("gvimfullscreen.dll", "SetAlpha", 240)

    " Hide some things we don't want
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=e

    " Map some keys to enable fullscreen
    noremap  <C-F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen",0)<CR>
    nnoremap <C-F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen",0)<CR>
endif

" CTRLP:
let g:ctrlp_prompt_mappings = {
            \ 'PrtBS()': ['<Char-0x07F>', '<BS>']
            \}

" Skip g:ctrlp_custom_ignore. Use wildingore.
" (Unless I'm missing something...)
"

" PROSE MODE USING GOYO:
"function! ProseMode()
"call goyo#execute(0, [])
"set spell noci nosi noai nolist noshowmode noshowcmd
"set complete+=s
""set bg=light
"endfunction

"command! ProseMode call ProseMode()
"nmap \p :ProseMode<CR>

" SAUCE:
cnoreabbrev sauce Sauce

" SUPERTAB:
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Reload vim-colemak to remap any overridden keys
source $HOME\vimfiles\autoload\colemak.vim

" Custom Keys
imap ii <Esc>
nnoremap <C-a> ggVG

" FILE OPERATIONS:
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>
cnoremap <C-s> <Esc>:w<CR>


