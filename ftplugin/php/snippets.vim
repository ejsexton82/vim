" NORMAL:
nnoremap ,Controller   :-1read $HOME/.vim/snippets/php/Controller.php<CR>:%s/CLASS//<Left>
nnoremap ,Model        :-1read $HOME/.vim/snippets/php/Model.php<CR>:%s/CLASS//<Left>
nnoremap ,TTController :-1read $HOME/.vim/snippets/php/TTController.php<CR>:%s/CLASS//<Left>
nnoremap ,TTModel      :-1read $HOME/.vim/snippets/php/TTModel.php<CR>:%s/CLASS//<Left>
nnoremap ,TTTrait      :-1read $HOME/.vim/snippets/php/TTTrait.php<CR>:%s/CLASS//<Left>
nnoremap ,TestCase     :-1read $HOME/.vim/snippets/php/TestCase.php<CR>:%s/CLASS//<Left>

" INSERT:
iabbrev pubf public function
iabbrev pubsf public static function
iabbrev prif private function
iabbrev prisf private static function
iabbrev prof protected function
iabbrev prosf protected static function
iabbrev TTa TT::app()
iabbrev TTagbu TT::app()->getBaseUrl(true)
iabbrev TTap TT::app()->params
iabbrev TTau TT::app()->user
iabbrev TTabp TT::app()->basePath
iabbrev vd var_dump);<left><left>
iabbrev vde var_dump); exit;<left><left><left><left><left><left><left><left>
iabbrev fe foreach) {<cr>}<up><right><right><right><right><right><right>
iabbrev trp $this->renderPartial
