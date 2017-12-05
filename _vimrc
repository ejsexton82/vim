" BASIC CONFIGURATION:

set encoding=UTF-8
set nocompatible          " Make Vim stop acting like Vi
syntax enable             " Enable syntax highlighting
filetype plugin indent on " Enable file type plugins and indenting
set fileformats=unix,dos  " Create new files using unix(LF) file format

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
set relativenumber      " Show relative line numbers
set colorcolumn=80

" PLUGINS:
if executable('fzf')
	packadd! fzf
	packadd! fzf.vim
endif

" ALE:
cabbrev af ALEFix
let g:ale_php_phpcbf_standard = 'PSR2'
let g:ale_fixers = {
			\   'php': [
			\       'phpcbf',
			\       'remove_trailing_lines',
			\       'trim_whitespace'
			\   ]
			\}

" FZF:
if executable('fzf')
	let g:fzf_layout = { 'down': '~40%' }
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
endif


" QUICKFIX:
nnoremap <leader>x :cclose<CR>

" WILDIGNORE:
set wildignore=*.swp,*.orig
set wildignore+=*.lock
set wildignore+=*.phar
set wildignore+=*.bak
set wildignore+=*.ico
set wildignore+=*.jpg,*.jpeg
set wildignore+=*.gif
set wildignore+=*.png
set wildignore+=*.svg

" Search down into subfolders, tab completion
set path+=**

" Display all matching files for tab completion
set wildmenu

" PHPCOMPLETE:
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

" TAGS:
command! MakeTags !ctags -R .
nnoremap <leader>t :tag <c-r><c-w><cr>
" nnoremap ,t :TagbarOpenAutoClose<CR>

" TAGBAR:
nmap <F8> :TagbarToggle<CR>

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
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme                      = 'solarized'
let g:airline_solarized_bg               = 'dark'

" THEME:
if has('gui_running')
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

" SAUCE:
cnoreabbrev sauce Sauce

" SUPERTAB:
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" CUSTOM KEYS:
imap ii <Esc>
nnoremap <C-a> ggVG

" FILE OPERATIONS:
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>
cnoremap <C-s> <Esc>:w<CR>


